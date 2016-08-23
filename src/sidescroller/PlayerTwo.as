/**
 * 
 * File:		PlayerTwo.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-18-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The PlayerTwo class is a Player with different controls
 *  
 **/
package sidescroller
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class PlayerTwo extends Player
	{
		/*Player Sprite (Finite State Machine)*/
		//Sprites
		public var playerTwoDrawing:  Sprite = new PlayerTwoDrawing();//symbol from Flash Pro
		private var playerTwoDrawing2: Sprite;//symbol from Flash Pro
		
		
		public function PlayerTwo(worldP:Sprite, locationParameter:Point, velocityParameter:GeometricVector, massParameter:Number)
		{
			super(worldP, locationParameter, velocityParameter, massParameter);
			
			/*Player Sprite (Finite State Machine)*/
			//Sprites
			//playerTwoDrawing ;//symbol from Flash Pro
			playerTwoDrawing2 = new PlayerTwoDrawingState2();//symbol from Flash Pro
		}
	}
	/**FUNCTION TO HANDLE KEY DOWNS**/
	private override function handleKeyDown(event:KeyboardEvent):void
	{
		//user presses left arrow or A
		if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.A)
		{
			//Move left
			super.isMovingLeft = true;
			super.isMovingRight = false;
			//move(0.1);
			playerTwoDrawing.scaleX = -0.2;
			playerTwoDrawing2.scaleX = -0.2;
		}
			//user presses right arrow or D
		else if(event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.D)
		{
			//Move right
			super.isMovingRight = true;
			super.isMovingLeft = false;
			//move(0.1);
			playerTwoDrawing.scaleX = 0.2;
			playerTwoDrawing2.scaleX = 0.2;
			
		}
			//user presses space,shift, up arrow, or W
		else if (event.keyCode == Keyboard.SPACE || event.keyCode == Keyboard.SHIFT || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.W)
		{
			if( super.isJumping == false  &&  (this.contains(drawing) || this.contains(drawing2))   )
			{
				if (this.velocity.y >= 0)
				{
					//jump
					super.isJumping = true;					
					this.velocity.y = 70; 
				}
			}
		}
		else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.S)
		{
			if((this.contains(drawing) || this.contains(drawing2))   )
			{
				super.decreaseUpwardsVelocity = true;
			}
		}
	}
	
	/**FUNCTION TO HANDLE KEY UPS**/
	private override function handleKeyUp(event:KeyboardEvent):void
	{
		//Don't move when are not pressed
		if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.A)
		{
			super.isMovingLeft = false;
			
		}
			//user presses right arrow or D
		else if(event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.D)
		{
			super.isMovingRight = false;
		}
		else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.S)
		{
			super.decreaseUpwardsVelocity = false;
		}
	}
}