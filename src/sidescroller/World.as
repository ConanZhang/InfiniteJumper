/**
 * 
 * File:		World.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-18-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The World class contains code to hold movers and apply physics to a simulation. It adds  it  to the screen,
 * centers it,and updates the simulation accordingly.  Also has the scoreboards and text and moves them.
 *
 * It is a Sprite and can move.
 *  
 **/
package sidescroller
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class World extends Sprite
	{
		/**Class Member Variables**/
		//Array of Active Objects
		//Movers
		private var movers:Vector.<Particle>;//holds all objects that move (except platforms)
		private var platformMovers:Vector.<Platform>;//moving platforms
		private var platformMoverElement: Platform;
		
		private var colliders: Vector.<Collider>;//holds all objects that collide
		private var platformPosition: Number;
		private var platformCounter: int;
		private var platformRemoveTimer: Timer;
		private var platformSpeed: Number;
		
		//Scoreboard
		private var scoreboard: Scoreboard;//score to count number of shots fired
		private var highScore: Scoreboard;
		private var highScoreCount: int;
		private var score: int;
		private var scoreTimer: Timer;
		private var scoreText: Sprite;
		private var maxText: Sprite;
		private var scoreAndMaxTextColorRandomizer: ColorTransform;
		
		//Physics
		public const gravity : GeometricVector = new GeometricVector(0, -20);//a velocity that is always pulling down or subtracting from all other velocities

		/**CONSTRUCTOR**/
		public function World(screen:Sprite)
		{
			/**World**/
			//Add to stage/screen 
			screen.addChild(this);
			
			//Fill vars
			platformCounter = 0;
			platformPosition = 350;
			platformSpeed = Math.random()*(4-3)+ 3;
			score = 0;
			
			//Center
			this.x = stage.stageWidth/2;
			this.y = stage.stageHeight/2;
			
			/**Scoreboard**/
			scoreboard = new Scoreboard(this);
			this.addChild(scoreboard);
			scoreboard.x = -100;
			scoreboard.y = -350;
			
			scoreTimer = new Timer(1000);
			scoreTimer.addEventListener(TimerEvent.TIMER, handleScoreTimer);
			scoreTimer.start();
			
			//Highscore
			highScore = new Scoreboard(this);
			this.addChild(highScore);
			
			highScore.x = 100;
			highScore.y = -350;
			
			//Score/Max Text...
			scoreText = new ScoreTextDrawing();
			maxText   = new MaxTextDrawing();
			this.addChild(scoreText);
			this.addChild(maxText);
				//...Position...
			scoreText.x = -100;
			scoreText.y = -375;
			maxText.x   = 100;
			maxText.y   = -375;
				//...Scale...
			scoreText.scaleX = .5;
			scoreText.scaleY = .5;
			maxText.scaleX = .5;
			maxText.scaleY = .5;
				//...Randomize color of each
			scoreAndMaxTextColorRandomizer = new ColorTransform();
			scoreAndMaxTextColorRandomizer.color = Math.random() *(0xffffff - 0x555555) + 0x555555;
			scoreText.transform.colorTransform = scoreAndMaxTextColorRandomizer;
			scoreAndMaxTextColorRandomizer.color = Math.random() *(0xffffff - 0x555555) + 0x555555;
			maxText.transform.colorTransform = scoreAndMaxTextColorRandomizer;


			
			/**Movers**/
			movers = new Vector.<Particle>(1);
			
			//Player
			movers[0] = new Player(this, new Point(0, 0), new GeometricVector(0,0), 1);
			
			//Moving Platforms
			platformMovers = new Vector.<Platform>(0);
			
			//Platforms
			
			//Platform remove timer
			platformRemoveTimer = new Timer(100,1);
			platformRemoveTimer.addEventListener(TimerEvent.TIMER, removePlatform);
			
			
			/**Colliders**/
			colliders = new Vector.<Collider>(1);
			
			/**Starting platforms**/
			//Base
			colliders[0] = new Platform(this, 0, 30, 0, 0, 500, Math.random() * 0xffffff, 0);
						
			/**Start Simulation**/
			start_simulation();
		}
	
		/**FUNCTION TO START SIMULATION BY UPDATING EVERYTHING ON GUI AND LOGICALLY**/
		public function start_simulation(  ) : void
		{
			this.addEventListener( Event.ENTER_FRAME, updateAll );
		}
		
		/**FUNCTION TO END SIMULATION BY STOP UPDATING EVERY EVERYTHING ON GUI AND LOGICALLY**/
		public function stop_simulation(  ) : void
		{
			this.removeEventListener( Event.ENTER_FRAME, updateAll );
		}
		
		/**FUNCTION TO UPDATE GUI AND LOGIC**/
		protected function updateAll(event:Event):void
		{
			
			
			/**Check if Player has fallen off the screen**/
			if ( (Player)(movers[0]).getY() < -400 )
			{
				//reset position of new platforms
				platformPosition = 400;
				platformSpeed = Math.random()*(4-3)+ 3;
				score = 0;
				
				//reset player
				(Player)(movers[0]).reset(0, 10);
				
				//Reset Screen
				this.x = 400;
				
				scoreboard.x = -100;
				scoreText.x  = -100;
				highScore.x  = 100;				
				maxText.x    = 100;
 	 			
  				/*
				//delete moving platforms
				for each (var platformMoverElementReset: Platform in platformMovers)
				{
					this.removeChild(platformMoverElementReset as Sprite);
					platformMovers.pop();
				}
				//delete colliding platforms
				for each(var colliderElementReset:Collider in colliders)
				{
					//this.removeChild(colliderElementReset as Sprite);
					//colliders.pop();
				}
				*/
			}
			
			/**Making new platforms**/
			platformCounter++;
			
			if (platformCounter == 25)
			{
				//make new random kind of platform
				var newPlatform: Platform;
				
				
					platformCounter = 0;
					platformPosition += 125;
					//moving platform
					newPlatform = new Platform(	this, 
												platformPosition,
												Math.floor(Math.random() * (300- (-300 + 1) ) ) + -300, 
												0, 
												0, 
												Math.random()*(100-50) + 50, 
												Math.random() *(0xffffff - 0x555555) + 0x555555, 
												platformSpeed);
					colliders.push(newPlatform);
					platformMovers.push(newPlatform);
				
			}
			/**Movers**/
			for each (var moverElement: Particle in movers)
			{					
				moverElement.add_force( gravity );//apply a negative velocity to all velocities to simulate gravity
				moverElement.move( 0.1 );// tell movers to simulate 1/10 of a second of motion every frame to simulate movement
				moverElement.clear_forces();//clear forces every frame to determine new calculations
			}
			
			//Platforms
			for each (platformMoverElement in platformMovers)
			{
				platformMoverElement.move(0.1);
				
				if(platformMovers[0].x < -400)
				{
					platformRemoveTimer.start();
				}
			}
			
			/**COLLISIONS**/
			for each(var colliderElement:Collider in colliders)
			{
				//A platform and player collide
				if ( GUI_Collision_Detection.isColliding( colliderElement as Sprite, movers[0] as Sprite ) )
				{
					/**TEST CODE**/
					//trace("collision!");
					
					(Player)(movers[0]).stabilize();//stabilize player
				}
			}
			
			/**Screen Scroll**/
			this.x -= 1.5;//uncomment for autoscroll every frame
			
			//this.x = stage.stageWidth/2 - (Player)(movers[0]).getX();//screen centered on player
			 
			scoreboard.x +=  1.5;//-(stage.stageWidth/2 - (Player)(movers[0]).getX() ) + 400;//screen centered on player
			highScore.x +=  1.5;
			scoreText.x += 1.5;
			maxText.x +=1.5;
		}
		
		private function handleScoreTimer(e:TimerEvent):void
		{
			score++;
			scoreboard.updateScore(score);
			
			//Increase Speed
			if (score < 25)
			{
				platformSpeed = Math.random()*(4-3)+ 3;
			}
			else if (score < 50)
			{
				platformSpeed = Math.random()*(5-4)+ 4;
			}
			else if (score < 75)
			{
				platformSpeed = Math.random()*(6-5)+ 5;
			}
			else if (score < 100)
			{
				platformSpeed = Math.random()*(7-6)+ 6;
			}
			else if(score < 125)
			{
				platformSpeed = Math.random()*(8-7)+ 7;
			}
			else if(score < 150)
			{
				platformSpeed = Math.random()*(9-8)+ 8;
			}
			else if(score < 175)
			{
				platformSpeed = Math.random()*(10-9)+ 9;
			}
			else if(score < 200)
			{
				platformSpeed = Math.random()*(11-10)+ 10;
			}
			else if(score < 225)
			{
				platformSpeed = Math.random()*(12-11)+ 11;
			}
			else if(score < 250)
			{
				platformSpeed = Math.random()*(13-12)+ 12;
			}
			
			//Update Highscore
			if (score > highScoreCount)
			{
				highScoreCount = score;
				
				highScore.updateScore(highScoreCount);
			}
		}
		
		private function removePlatform(e:TimerEvent):void
		{
			//GUI
			removeChild(platformMovers[0]);
			
			//Logic
			platformMovers.splice(0,1);
			colliders.splice(1, 1);
	 	}
		

	}//end class
}//end package