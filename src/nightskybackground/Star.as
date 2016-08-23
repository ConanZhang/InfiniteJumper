package nightskybackground
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 File:Star.as
	 
	 Author:	Conan Zhang (conan.zhang@utah.edu)
	 Date:		09-18-13
	 Partner:	None
	 Course:	Computer Science 1410 - EAE
	 
	 Description:
	 
	 Star Class with functions to draw circular or rectangular stars 
	 and to control their blinking/twinkling rate.
	 
	 */
	
	public class Star extends Sprite
	{
		/*
		Summary of the create_display_list function:
		The create_display_list function draws circular and rectangular stars
		with the ability to blink/twinkle.
		
		Parameters: 
		Variables: blinking
		Drawing Commands
		
		Return Value: void Just draws.
		
		Description: Draws stars with varying shapes, sizes, values, and blink/twinkle rates.
		
		*/
		
		//Declared Variable//
		private var blinking:Timer;
		
		//Draw Star Code//
		public function create_display_list() : void
		{
			if(Math.random() > 0.5)
			{
				//Draw Circular Stars//
				this.graphics.clear();
				this.graphics.beginFill(0xBADE57, Math.random());
				this.graphics.drawCircle(0,0,1 + Math.random()*2);
				this.graphics.endFill();
				
				//Blink/Twinkle Code//
				blinking = new Timer(Math.random()*(10000-1000) + 1000);
				blinking.addEventListener("timer", timerHandler);
				blinking.start();
			}
			else
			{
				//Draw Rectangular Stars//
				this.graphics.clear();
				this.graphics.beginFill(0x71E373, Math.random());
				this.graphics.drawRect (-2,-2,4,4);
				this.graphics.endFill();
				
				//Blink/Twinkle Code//
				blinking = new Timer(Math.random()*(10000-1000) + 1000);
				blinking.addEventListener("timer", timerHandler);
				blinking.start();
			}
		}
		
		/*
		Summary of the timeHandler function:
		The timeHandler function controls the blinking rate of the stars.
		
		Parameters:
		Booleans: this.visible = true/false
		
		Return Value: void Keeps track of time and visibility.
		
		Description: Asks whether or not the star is visible and
		delays its blinking/twinkling as such.
		
		*/
		public function timerHandler(event:TimerEvent):void 
		{
			if ( this.visible )
			{
				this.visible = false;
			}
			else
			{
				this.visible = true;
			}
			//blinking.delay = Math.random()*5000;
		}
		
	}
}