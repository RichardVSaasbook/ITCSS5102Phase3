module phase3.color.HSLColor;

import phase3.color.RGBColor;

import std.math;

/**
 * This is a color represtend by a hue, saturation, and lightness value.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 9, 2014
 */
class HSLColor {
	public:
		/**
		 * Creates an HSLColor with the hue, saturation,
		 * and lightness values set to 0.
		 *
		 * Date: April 9, 2014
		 */
		this() {
			hue = 0;
			saturation = 0;
			lightness = 0;
		}
		
		/**
		 * Creates an HSLColor.
		 *
		 * Params:
		 * 		hue = The hue value.
		 *		saturation = The saturation value.
		 *		lightness = The lightness value.
		 * Date: April 9, 2014
		 */
		this(uint hue, real saturation, real lightness) {
			this.hue = hue;
			this.saturation = saturation;
			this.lightness = lightness;
		}
	
		/**
		 * Converts this HSLColor to an RGBColor.
		 *
		 * See_Also:
		 *		<a href="http://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl/">Converting Between HSL & RGB</a>
		 * Date: April 9, 2014
		 */
		RGBColor toRGBColor() {
			RGBColor color;
		
			if (saturation == 0) {
				color = new RGBColor(cast(ubyte) round(lightness * 255), cast(ubyte) round(lightness * 255), cast(ubyte) round(lightness * 255));
			}
			else {
				real tempA = lightness < 0.5 ? lightness * (1 + saturation) : lightness + saturation - lightness * saturation;
				real tempB = 2 * lightness - tempA;
				real huePrime = hue / 360.0;
				real[] rgbPrime = [huePrime + 1 / 3.0, huePrime, huePrime - 1 / 3.0];
				ubyte[] rgb = [0, 0, 0];
				
				for (int c = 0; c < 3; c++) {
					real cValue = rgbPrime[c];
					
					if (cValue < 0) {
						cValue += 1;
					}
					else if (cValue > 1) {
						cValue -= 1;
					}
					
					if (6 * cValue < 1) {
						rgb[c] = cast(ubyte) (tempB + (tempA - tempB) * 6 * cValue);
					}
					else if (2 * cValue < 1) {
						rgb[c] = cast(ubyte) tempA;
					}
					else if (3 * cValue < 2) {
						rgb[c] = cast(ubyte) (tempB + (tempA - tempB) * (2 / 3.0 - cValue) * 6);
					}
					else {
						rgb[c] = cast(ubyte) tempB;
					}
				}
				
				color = new RGBColor(cast(ubyte) round(rgb[0] * 255), cast(ubyte) round(rgb[1] * 255), cast(ubyte) round(rgb[2] * 255));
			}
			
			return color;
		}
	private:
		uint hue;
		real saturation,
			lightness;
}
