/**
 * 
 * File:		Player.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-18-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Player class is a Particle that can move and collide.
 *  
 **/
package sidescroller
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	
	public class Player extends Particle implements Mover, Collider
	{		
		/**Class Member Variables**/
		/*Movement*/
		//Horizontal
		protected var playerSpeed:Number;//pixels able to move left or right by every frame
		
		protected var isMovingLeft: Boolean;
		protected var isMovingRight: Boolean;
		
		//Vertical
		protected var isJumping: Boolean;
		protected var decreaseUpwardsVelocity:Boolean;
		
		/*Collisions*/
		protected var stabilizeTimer:Timer;
		protected var colliding: Boolean = true;
		
		/*Player Sprite (Finite State Machine)*/
		//Sprites
		private var drawing:  Sprite;//symbol from Flash Pro
		private var drawing2: Sprite;//symbol from Flash Pro
		
		//Finite States
		private var mode: int;//mode will be determined by integers
		
		private const STANDING: int = 0;
		private const WALKING: int = 1;
		
		//Timer to switch between states
		private var timer: Timer;
		
		//Owner
		private var world: Sprite;
		
		/**CONSTRUCTOR**/
		public function Player(worldP: Sprite, 
							   locationParameter:Point, 
							   velocityParameter: GeometricVector, 
							   massParameter: Number)
		{
			/**Pass variables into Particle super class for physics**/
			super( locationParameter, velocityParameter, massParameter);
				
			/**Assign Member Variables to Parameters**/
			world = worldP;
			
			//Add player to OWNER (simulator)
			world.addChild(this);
			
			/**Assigning Values to Class Member Variables**/
			/*Movement*/
			//Horizontal
			playerSpeed = 35;
			
			isMovingLeft = false;
			isMovingRight = false;
			
			//Vertical
			isJumping = false;
			decreaseUpwardsVelocity = false;
			
			/*Player Sprite (Finite State Machine)*/
			//Sprites
			drawing = new PlayerDrawing();//symbol from Flash Pro
			drawing2 = new PlayerDrawingState2();//symbol from Flash Pro
			
			/**Collisions**/
			stabilizeTimer = new Timer(250);
			stabilizeTimer.addEventListener(TimerEvent.TIMER, handleStabilizeTimer);
			
			/**-----FINITE STATE MACHINE START-----**/
			//Initial state
			mode = STANDING;			 
			
			//Add drawing to PLAYER CLASS, PLEASE NEVER FORGET TO DO THIS!!!
			this.addChild(drawing);
			//this.addChild(drawing2);
			
			//Size
			drawing.scaleX = 0.2;
			drawing.scaleY = 0.2;
			
			drawing2.scaleX = 0.2;
			drawing2.scaleY = 0.2;
			
			//Location
			drawing.x = 0;
			drawing.y = -50;
			
			drawing2.x = 0;
			drawing2.y = -50;
			
			//Timer event to switch between states/sprites
			timer = new Timer(250); //Change state every 1/4th of a second
			timer.addEventListener(TimerEvent.TIMER, handleTimer);
			timer.start();//start timer		
			
			/**--------END CONSTRUCTOR FSM--------**/
						
			
			/**Add Event Listeners**/
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);//player constantly moves in direction pressed, even when no keys are pressed
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);//UNCOMMENT FOR DIFFERENT PLAYER CONTROL (player stops moving on key up)
		}
		
		protected function handleStabilizeTimer(event:TimerEvent):void
		{
			if (colliding == false)
			{
				colliding = true;
			}
		}
		
		/**MOVE FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public override function move(duration:Number):void
		{
			
			/**Lateral Movement**/
			if (isMovingLeft)
			{
				this.velocity.x = -playerSpeed;//move left until hits limit set in condition  
			}
			else if (isMovingRight)
			{
				this.velocity.x =  playerSpeed;//move right until hits limit set in condition
			}
			
			/**Vertical Movement**/
			if (decreaseUpwardsVelocity == true && this.velocity.y >= -10)
			{				
				this.velocity.y -= 20; 
			}
			
			/**Falling**/
			//Calculate Physics
			super.move(duration);
			
			//Update player location based on particle calculations
			this.update_gui();
		}
		
		/**COLLIDE FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function collide(otherObject: Sprite):Boolean
		{
			return false;//CHANGE ME IF YOU EVER WANT THE PLAYER TO COLLIDE
		}
		
		/**GET NORMAL FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function getNormal():GeometricVector
		{
			return new GeometricVector(-1,0);
		}
		
		/**FUNCTION TO HANDLE KEY DOWNS**/
		protected function handleKeyDown(event:KeyboardEvent):void
		{
			//user presses left arrow or A
			if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.A)
			{
				//Move left
				isMovingLeft = true;
				isMovingRight = false;
				//move(0.1);
				drawing.scaleX = -0.2;
				drawing2.scaleX = -0.2;
			}
			//user presses right arrow or D
			else if(event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.D)
			{
				//Move right
				isMovingRight = true;
				isMovingLeft = false;
				//move(0.1);
				drawing.scaleX = 0.2;
				drawing2.scaleX = 0.2;
				
			}
			//user presses space,shift, up arrow, or W
			else if (event.keyCode == Keyboard.SPACE || event.keyCode == Keyboard.SHIFT || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.W)
			{
				if( isJumping == false  &&  (this.contains(drawing) || this.contains(drawing2))   )
				{
						//jump
						isJumping = true;					
						this.velocity.y = 70;
				}
			}
			else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.S)
			{
				if((this.contains(drawing) || this.contains(drawing2))   )
				{
					decreaseUpwardsVelocity = true;
				}
			}
		}
		
		/**FUNCTION TO HANDLE KEY UPS**/
		protected function handleKeyUp(event:KeyboardEvent):void
		{
			//Don't move when are not pressed
			if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.A)
			{
				isMovingLeft = false;

			}
			//user presses right arrow or D
			else if(event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.D)
			{
				isMovingRight = false;
			}
			else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.S)
			{
				decreaseUpwardsVelocity = false;
			}
		}
		
		/**FUNCTION TO HANDLE TIME SWITCHING FINITE STATES**/
		private function handleTimer(event:TimerEvent):void
		{
			if (mode == STANDING)
			{
				/**-----FSM SWITCH-----**/
				//change mode variables
				mode = WALKING;
				//check for the correct sprite
				if (this.contains(drawing))
				{
					//remove old sprite
					this.removeChild(drawing);
					//add new sprite
					this.addChild(drawing2);
				}
				/**-----END FSM-----**/
			}
			else if (mode == WALKING)
			{
				/**-----FSM SWITCH-----**/
				//change mode variables
				mode = STANDING;
				if( this.contains(drawing2) )
				{
					//remove old sprite
					this.removeChild(drawing2);
					//add new sprite
					this.addChild(drawing);
				}
				/**-----END FSM-----**/
			}
		}
		
		/**getX FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getX():int
		{
			/**TEST CODE**/
			//trace(this.location.x);
			
			return this.location.x;
		}
		
		/**getY FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getY():int
		{
			return this.location.y;
		}
		
		/**setY FUNCTION**/
		public function reset(xCoordinate: Number, yCoordinate:Number):void
		{
			this.location.x = xCoordinate;
			this.location.y = yCoordinate;
			
			this.velocity.y = 0
				
			update_gui();
		}
		
		/**FUNCTION TO UPDATE PLAYER LOCATION BY MATH DONE IN THE PARTICLE CLASS**/
		protected function update_gui() : void
		{
			/*if(isJumping)
			{
				drawing.rotation += 5;
				drawing2.rotation += 5;
			}*/
			
			//set x position to particle calculations for the next x position
			this.x = this.location.x;
			//set y position to particle calculations for the next y position
			this.y = -this.location.y;//MIRROR DUE TO Y INCREASING ↓
		}
		
		/**FUNCTION TO STABILIZE PLAYER**/
		public function stabilize() : void
		{
			if(colliding == true)
			{
				//Can jump again
				isJumping = false;
				
				//Reverse the vertical velocity to positive (bounce) and reduce it
				this.velocity.y = -(this.velocity.y );
				
				//Decrease the horizontal velocity by some (friction)
		 		this.velocity.x = (this.velocity.x * 0.25);
				
				colliding = false;
				
				stabilizeTimer.start();
			}
		}
		
	}//end class
}//end package