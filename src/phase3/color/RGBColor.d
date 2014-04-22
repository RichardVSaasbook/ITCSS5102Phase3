module phase3.color.RGBColor;

import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Device;
import org.eclipse.swt.graphics.RGB;

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
		 * Returns: This RGBColor's red value.
		 * Date: April 15, 2014
		 */
		ubyte getRed() {
			return red;
		}
		
		/**
		 * Returns: This RGBColor's green value.
		 * Date: April 15, 2014
		 */
		ubyte getGreen() {
			return green;
		}
		
		/**
		 * Returns: This RGBColor's blue value.
		 * Date: April 15, 2014
		 */
		ubyte getBlue() {
			return blue;
		}
		
		/**
		 * Returns: The RGB object for this RGBColor's red, green
		 *		and blue values.
		 * Date: April 20, 2014
		 */
		RGB getRGB() {
			return new RGB(red, green, blue);
		}
		
		RGBColor opBinary(string op)(RGBColor rgb) {
		   static if (op == "-") return new RGBColor(cast(ubyte) (red - rgb.getRed()), cast(ubyte) (green - rgb.getGreen()), cast(ubyte) (blue - rgb.getBlue()));
		   else static assert(0, "Operator "~op~" not implemented");
		}
	private:
		ubyte red,
			green,
			blue;
}
