/**
 * 
 * File:		Side_Scroller.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-18-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 *The Side_Scroller class is the screen that creates the world.
 *
 * It is a Sprite.
 *  
 **/
package
{
	import flash.display.Sprite;
	import sidescroller.*;
	import nightskybackground.*;
	
	/**CHANGE BACKGROUND COLOR, STAGE SIZE, AND FRAME RATE**/
	[SWF(backgroundColor="#101010", width="800", height="800", frameRate="55")]
	
	public class Side_Scroller extends Sprite
	{
		private var world : World;
		
		public function Side_Scroller()
		{
			//Create background
			createBackground();
			//Create world
			world = new World(this);			
		}
		
		private function createBackground():void
		{			
			//Loop Until Desired Number of Stars is Reached//
			for ( var i:int = 1; i < 75; i++)
			{
				//Create new Star Object//
				var a_star:Star = new Star();
				
				//Add Star Object to Stage//
				this.addChild(a_star);                 
				
				//Declared Variables for Star Position//
				var random_x:Number = Math.random() * this.stage.stageWidth;
				var random_y:Number = Math.random() * this.stage.stageHeight;
				
				//Star Position Coordinates//
				a_star.x = random_x;
				a_star.y = random_y;
				
				//Draw the Star//
				a_star.create_display_list();
							
			}
			
			//Create new Mountain Object//
			var mountain1:Mountain = new Mountain();
			var mountain2:Mountain = new Mountain();
			var mountain3:Mountain = new Mountain();
			
			//Add Mountain Object to Stage//
			this.addChild(mountain1);
			this.addChild(mountain2);
			this.addChild(mountain3);
			
			//Mountain Position Coordinates//
			mountain1.x = 0;
			mountain1.y = -60;
			
			mountain2.x = 0;
			mountain2.y = -30;
			
			mountain3.x = 0;
			mountain3.y = 0;
			
			//Draw the Mountain//
			mountain1.create_display_list();
			mountain2.create_display_list();
			mountain3.create_display_list();
			
		}
	}//end class
}//end package