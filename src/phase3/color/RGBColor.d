module phase3.color.RGBColor;

import phase3.color.HSLColor;

import std.algorithm;
import std.math;

/**
 * This is a color represented by a red, green, and blue value.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 9, 2014
 */
class RGBColor {
	public:
		/**
		 * Creates an RGBColor with 0 as the red, green,
		 * and blue values.
		 *
		 * Date: April 9, 2014
		 */
		this() {
			red = 0;
			green = 0;
			blue = 0;
		}
	
		/**
		 * Creates an RGBColor.
		 *
		 * Params:
		 *		red = The red value.
		 *		green = The green value.
		 *		blue = The blue value.
		 * Date: April 9, 2014
		 */
		this(ubyte red, ubyte green, ubyte blue) {
			this.red = red;
			this.green = green;
			this.blue = blue;
		}
		
		/**
		 * Converts this RGBColor to an HSLColor.
		 *
		 * See_Also:
		 *		<a href="http://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl/">Converting Between HSL & RGB</a>
		 * Date: April 9, 2014
		 */
		HSLColor toHSLColor() {
			HSLColor color;
			
			real rPrime = red / 255.0;
			real gPrime = green / 255.0;
			real bPrime = blue / 255.0;
			
			ubyte minB = min(red, green, blue);
			ubyte maxB = max(red, green, blue);
			real minR = min(rPrime, gPrime, bPrime);
			real maxR = max(rPrime, gPrime, bPrime);
			
			real lightness = (minR + maxR) / 2.0;
			uint hue;
			real saturation;
			
			if (minB == maxB) {
				hue = 0;
				saturation = 0;
			}
			else {
				saturation = lightness < 0.5 ? (maxR - minR) / (maxR + minR) : (maxR - minR) / (2 - maxR - minR);
				
				real huePrime;
				
				if (red == maxB) {
					huePrime = (gPrime - bPrime) / (maxR - minR);
				}
				else if (green == maxB) {
					huePrime = 2 + (bPrime - rPrime) / (maxR - minR);
				}
				else {
					huePrime = 4 + (rPrime - gPrime) / (maxR - minR);
				}
				
				hue = cast(uint) round(huePrime * 60);
				
				if (hue < 0) {
					hue += 360;
				}
			}
			
			return new HSLColor(hue, saturation, lightness);
		}
	private:
		ubyte red,
			green,
			blue;
}
