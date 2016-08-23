/**
 * 
 * File:		Scoreboard.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The scoreboard is a Sprite that keeps track of how many shots the player has taken.
 * 
 **/
package sidescroller
{
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	
	public class Scoreboard extends Sprite
	{
		/**Class Member Variables**/
		//Logic
		private var leftScore:    int = 0;  //100s place
		private var middleScore:  int = 0;//10s place
		private var rightScore:   int = 0;//1s place
		
		//GUI
		private var leftDigit: DigitShadow; //100s place
		private var middleDigit:DigitShadow;//10s place
		private var rightDigit:DigitShadow;//1s place
		
		/**CONSTRUCTOR**/
		public function Scoreboard(owner: DisplayObjectContainer)
		{
			/**100s Place Digit**/
			//Create 
			leftDigit = new DigitShadow(this, -35, 0, 0, 0x101010, Math.random() *(0xffffff - 0x555555) + 0x555555, 0x101010);
			
			//Size
			leftDigit.scaleX = 0.20;
			leftDigit.scaleY = 0.20;
			
			/**10's Place Digit**/
			//Create 
			middleDigit = new DigitShadow(this, 0, 0, 0, 0x101010, Math.random() *(0xffffff - 0x555555) + 0x555555, 0x101010);
			
			//Size
			middleDigit.scaleX = 0.20;
			middleDigit.scaleY = 0.20;
			
			/**1's Place Digit**/
			//Create 
			rightDigit = new DigitShadow(this, 35, 0, 0, 0x101010, Math.random() *(0xffffff - 0x555555) + 0x555555, 0x101010);
			
			//Size
			rightDigit.scaleX = 0.20;
			rightDigit.scaleY =0.20;
		}
		
		/**FUNCTION TO UPDATE SCORE EVERY FRAME**/
		public function updateScore(scoreParameter: int) : void
		{
			//ONE DIGIT SCORE
			if (scoreParameter < 10)
			{
				//100's place is a 0
				leftDigit.createDisplayList(0);
				
				//10s is 0
				middleDigit.createDisplayList(0);
				
				//1's place draws score from parameter
				rightDigit.createDisplayList(scoreParameter);
				
			}			
				//TWO DIGIT SCORE
			else if (scoreParameter >= 10 && scoreParameter<=99)
			{
				//100's place is a 0
				leftDigit.createDisplayList(0);
				//Size 100's place
				
				//Draw 10's place digit divided by 10 (provides digit as one digit to draw)
				middleDigit.createDisplayList(scoreParameter/10);
				
				//Draw 1's place digit modulo by 10 (provides remainder as one digit to draw)
				rightDigit.createDisplayList(scoreParameter%10);
			}
			else if(scoreParameter >=100 && scoreParameter <= 999)
			{
				//100's place is a 0
				leftDigit.createDisplayList(scoreParameter/100);				
				
				//Draw 10's place digit divided by 10 (provides digit as one digit to draw)
				middleDigit.createDisplayList((scoreParameter/10)%10);
				
				//Draw 1's place digit modulo by 10 (provides remainder as one digit to draw)
				rightDigit.createDisplayList(scoreParameter%10);

			}
			
		}
	}
}