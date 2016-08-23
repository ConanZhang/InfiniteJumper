package nightskybackground
{
	import flash.display.Sprite;
	
	/*
	File:Mountain.as
	
	Author:	Conan Zhang (conan.zhang@utah.edu)
	Date: 09-18-13
	Partner: None
	Course:	Computer Science 1410 - EAE
	
	Description:
	
	Mountain Class with functions to randomly generate hexadecimal colors for
	mountain range colors and the function to actually draw the mountain.
	
	*/
	public class Mountain extends Sprite
	{
		/*
		Summary of the randomRange function:
		The randomRange function returns a number between the values max and min.
		
		Parameters: 
		Variables: max, min
		
		Return Value: Number
		
		Description: Returns a number that can be used to create mountains 
		with a random color within a desired range.
		
		*/
		
		public function randomRange(max:Number, min:Number = 0x000010):Number
		{
			return Math.random()*(max - min) + min;
		}
		
		/*
		Summary of the create_display_list function:
		The create_display_list function draws mountains.
		
		Parameters: 
		Variables: change_in_height, mountain_height, mountain_color
		Drawing Commands
		
		Return Value: void Just draws.
		
		Description: Draws a mountain range that has a fluctuating elevation and random color.
		
		*/
		
		public function create_display_list():void
		{
			//Declared Variables//
			var change_in_height:Number;
			var mountain_height:Number = 700;
			var mountain_color:Number = randomRange(0x000050);
			
			//Draw Mountain Code//
			this.graphics.clear();
			
			for ( var i:int = -1; i <= stage.stageWidth; i++)
			{
				this.graphics.lineStyle(1, mountain_color);
				this.graphics.moveTo(i,stage.stageHeight);
				this.graphics.lineTo(i, mountain_height);
				change_in_height = Math.random()*4-2;
				mountain_height = mountain_height + change_in_height;
			}
		}
	}
}