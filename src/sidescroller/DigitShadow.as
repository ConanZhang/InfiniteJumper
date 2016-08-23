/**
 * File:    DigitShadow.as
 *
 * Author:  Georbec Ammon (u0552894@utah.edu)
 * Date:    Fall Semester 2013
 * Partner: I worked alone 
 * Course:  Computer Science 1410-EAE
 *
 * Description:
 *
 * This constructor takes:    an "owner" sprite that will use multiple digit sprites
 an x coordinate to draw the digit
 a y coordinate to  draw the digit
 which number to draw
 a fill color
 a stroke (line) color
 This file will take in parameters in order to draw a "digit" (0-9)
 with the createDisplayList function.
 
 
 Of note is that this DigitShadow will draw both the parts of the digit that are "turned on" and the parts
 that are "off," in green and red outline, respectively.
 *
 */
package sidescroller
{
	
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	
	public class DigitShadow extends Sprite
	{
		public var fillColor: uint = 0xFF0000;
		public var lineColorOn: uint = 0x0000FF;
		public var lineColorOff: uint = 0x0000FF;
		
		/**
		 * Digit constructor
		 * 
		 * The constructor takes the parameters described in the above comment and
		 * draws the initialized digit (0) then positions the digit and adds it to the
		 * sprite that is passed down in the parameters.
		 *
		 */
		public function DigitShadow(theClockSprite:  DisplayObjectContainer, 
									digitXPosition:  int, 
									digitYPosition:  int, 
									theNumberToDraw: int,
									digitFillColor:  uint,
									digitLineColorOn:  uint,
									digitLineColorOff: uint) 
		{
			//fill class variables with the data sent through parameters
			fillColor = digitFillColor;
			lineColorOn = digitLineColorOn;
			lineColorOff = digitLineColorOff;
			
			//draw the digit
			createDisplayList(theNumberToDraw);
			
			//position the digit according to parameters
			this.x = digitXPosition;
			this.y = digitYPosition;
			
			//add the digit to the clock
			theClockSprite.addChild(this);
		}
		
		
		/**
		 --1--
		 |     |
		 2     3
		 |     |
		 --4--
		 |     |
		 5     6 
		 |     |
		 --7--
		 
		 Above is the reference picture for the following commands:
		 Line One .......... drawHorizontalSegment(0);
		 Line Two .......... drawVerticalSegment(-55, 0);
		 Line Three ........ drawVerticalSegment(25,0);
		 Line Four ......... drawHorizontalSegment(68);
		 Line Five ......... drawVerticalSegment(-55, 75);
		 Line Six .......... drawVerticalSegment(25,75);
		 Line Seven ........ drawHorizontalSegment(135);
		 
		 These above commands are used to draw the digits 0 through 9 according
		 to theNumberToDraw parameter.
		 
		 In DigitShadow, now we will use two different drawing methods for "on" and "off."
		 */		 
		public function createDisplayList(theNumberToDraw: int) : void
		{
			
			if (theNumberToDraw == 0)
			{
				this.graphics.clear();
				//line four TURNED OFF
				drawHorizontalSegmentTurnedOff(68);
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line two
				drawVerticalSegmentTurnedOn  (-55, 0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line five
				drawVerticalSegmentTurnedOn  (-55, 75);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				//line seven
				drawHorizontalSegmentTurnedOn(135);
			}
			else if (theNumberToDraw == 1)
			{
				this.graphics.clear();
				//line seven TURNED OFF
				drawHorizontalSegmentTurnedOff(135);
				//line four TURNED OFF
				drawHorizontalSegmentTurnedOff(68);
				//line five TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 75);
				//line one TURNED OFF
				drawHorizontalSegmentTurnedOff(0);
				//line two TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				
			}
			else if (theNumberToDraw == 2)
			{
				this.graphics.clear();
				//line six TURNED OFF
				drawVerticalSegmentTurnedOff  (25, 75);
				//line two TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 0);
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line four
				drawHorizontalSegmentTurnedOn(68);
				//line five
				drawVerticalSegmentTurnedOn  (-55, 75);
				//line seven
				drawHorizontalSegmentTurnedOn(135);
			}
			else if (theNumberToDraw == 3)
			{
				this.graphics.clear();
				//line five TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 75);
				//line two TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 0);
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line four
				drawHorizontalSegmentTurnedOn(68);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				//line seven
				drawHorizontalSegmentTurnedOn(135);
			}
			else if (theNumberToDraw == 4)
			{
				this.graphics.clear();
				//line one TURNED OFF
				drawHorizontalSegmentTurnedOff(0);
				//line five TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 75);
				//line seven TURNED OFF
				drawHorizontalSegmentTurnedOff(135);
				//line two
				drawVerticalSegmentTurnedOn  (-55, 0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line four
				drawHorizontalSegmentTurnedOn(68);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				
			}
			else if (theNumberToDraw == 5)
			{
				this.graphics.clear();
				//line three TURNED OFF
				drawVerticalSegmentTurnedOff  (25, 0);
				//line five TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 75);
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line two
				drawVerticalSegmentTurnedOn  (-55, 0);
				//line four
				drawHorizontalSegmentTurnedOn(68);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				//line seven
				drawHorizontalSegmentTurnedOn(135);
			}
			else if (theNumberToDraw == 6)
			{
				this.graphics.clear();
				//line three TURNED OFF
				drawVerticalSegmentTurnedOff  (25, 0);
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line two
				drawVerticalSegmentTurnedOn  (-55, 0);
				//line four
				drawHorizontalSegmentTurnedOn(68);
				//line five
				drawVerticalSegmentTurnedOn  (-55, 75);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				//line seven
				drawHorizontalSegmentTurnedOn(135);
			}
			else if (theNumberToDraw == 7)
			{
				this.graphics.clear();
				//line two TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 0);
				//line four TURNED OFF
				drawHorizontalSegmentTurnedOff(68);
				//line five TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 75);
				//line seven TURNED OFF
				drawHorizontalSegmentTurnedOff(135);
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
			}
			else if (theNumberToDraw == 8)
			{
				this.graphics.clear();
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line two
				drawVerticalSegmentTurnedOn  (-55, 0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line four
				drawHorizontalSegmentTurnedOn(68);
				//line five
				drawVerticalSegmentTurnedOn  (-55, 75);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				//line seven
				drawHorizontalSegmentTurnedOn(135);
			}
			else if (theNumberToDraw == 9)
			{
				this.graphics.clear();
				//line five TURNED OFF
				drawVerticalSegmentTurnedOff  (-55, 75);
				//line one
				drawHorizontalSegmentTurnedOn(0);
				//line two
				drawVerticalSegmentTurnedOn  (-55, 0);
				//line three
				drawVerticalSegmentTurnedOn  (25, 0);
				//line four
				drawHorizontalSegmentTurnedOn(68);
				//line six
				drawVerticalSegmentTurnedOn  (25, 75);
				//line seven
				drawHorizontalSegmentTurnedOn(135);
			}
			else
			{
				trace("Error in Digit.as class.  theNumberToDraw did not equal 0 through 9, it traces as: " + theNumberToDraw);
			}
			
		}//end createDisplayList
		
		
		/**
		 * drawHorizontalSegment function
		 * 
		 * This function is the basic function that takes a y coordinate
		 * and draws a simple horizontal segment that is "on."  It is called in createDisplayList.
		 *
		 */
		public function drawHorizontalSegmentTurnedOn(yOffset: int):  void
		{
			//this.graphics.beginFill(fillColor);
			this.graphics.lineStyle(1, lineColorOn);
			this.graphics.drawRect(-25, yOffset, 50, 15);
			//this.graphics.endFill();
		}
		
		
		/**
		 * drawVerticalSegment function
		 * 
		 * This function is the basic function that takes a y coordinate and x coordinate
		 * and draws a simple vertical segment that is "on."  It is called in createDisplayList.
		 *
		 */
		public function drawVerticalSegmentTurnedOn(xOffset: int, yOffset: int): void
		{
			//this.graphics.beginFill(fillColor);
			this.graphics.lineStyle(1, lineColorOn);
			this.graphics.drawRect(xOffset, yOffset, 30, 75);
			//this.graphics.endFill();
		}
		
		
		
		/**
		 * drawHorizontalSegmentTurnedOff function
		 * 
		 * This function is the basic function that takes a y coordinate
		 * and draws a simple horizontal segment.  It is called in createDisplayList.
		 *
		 * This is the exact same draw function, but will use a different color to show the
		 * "shadow" of the digit when it is turned off.
		 */
		public function drawHorizontalSegmentTurnedOff(yOffset: int):  void
		{
			//this.graphics.beginFill(fillColor);
			this.graphics.lineStyle(1, lineColorOff, 0.3);
			this.graphics.drawRect(-25, yOffset, 50, 15);
			//this.graphics.endFill();
		}
		
		
		/**
		 * drawVerticalSegmentTurnedOff function
		 * 
		 * This function is the basic function that takes a y coordinate and x coordinate
		 * and draws a simple vertical segment.  It is called in createDisplayList.
		 *
		 * This is the exact same draw function, but will use a different color to show the
		 * "shadow" of the digit when it is turned off.
		 */
		public function drawVerticalSegmentTurnedOff(xOffset: int, yOffset: int): void
		{
			//this.graphics.beginFill(fillColor);
			this.graphics.lineStyle(1, lineColorOff, 0.3);
			this.graphics.drawRect(xOffset, yOffset, 30, 75);
			//this.graphics.endFill();
		}
		
		
		
	}//end class
	
}//end package
