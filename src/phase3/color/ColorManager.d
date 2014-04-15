module phase3.color.ColorManager;

import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Device;

import phase3.color.HSLColor;
import phase3.color.RGBColor;

/**
 * The ColorManager keeps track of all Color resources
 * created and will dispose of them after the program finishes.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 15, 2014
 */
class ColorManager {
	public:
		/**
		 * Creates a new ColorManager.
		 *
		 * Params:
		 * 		device = The main Display's Device.
		 * Date: April 15, 2014
		 */
		this(Device device) {
			this.device = device;
		}
		
		/**
		 * Will dispose of all Color resources.
		 *
		 * Date: April 15, 2014
		 */
		void disposeColors() {
			foreach(long i, Color color; colors) {
				color.dispose();
			}
		}
		
		/**
		 * Adds a Color resource to be kept track of.
		 *
		 * Params:
		 * 		color = The Color resource to keep track of.
		 * Date: April 15, 2014
		 */
		void addColor(Color color) {
			long colorId = getColorId(color.getRed(), color.getGreen(), color.getBlue());
			colors[colorId] = color;
		}
		
		/**
		 * Removes and disposes the Color resource to stop
		 * keeping track of it.
		 *
		 * Params:
		 *		color = The Color resource to remove.
		 * Date: April 15, 2014
		 */
		void removeColor(Color color) {
			long colorId = getColorId(color.getRed(), color.getGreen(), color.getBlue());
			colors[colorId].dispose();
			colors.remove(colorId);
		}
		
		/**
		 * Returns the Color resource that matches the given
		 * RGBColor, creating it if necessary.
		 *
		 * Params:
		 *		rgbColor = The RGBColor corresponding to the requested
		 *				   Color.
		 * Returns: The corresponding Color resource.
		 * Date: April 15, 2014
		 */
		Color getColor(RGBColor rgbColor) {
			long colorId = getColorId(rgbColor.getRed(), rgbColor.getGreen(), rgbColor.getBlue());
			
			if (colorId !in colors) {
				colors[colorId] = new Color(device, rgbColor.getRed(), rgbColor.getGreen(), rgbColor.getBlue());
			}
			
			return colors[colorId];
		}
		
		/**
		 * Returns the Color resource that matches the given
		 * HSLColor, creating it if necessary.
		 *
		 * Params:
		 *		hslColor = The HSLColor corresponding to the requested
		 *				   Color.
		 * Returns: The corresponding Color resource.
		 * Date: April 15, 2014
		 */
		Color getColor(HSLColor hslColor) {
			return getColor(hslColor.toRGBColor());
		}
		
	private:
		Color[long] colors;
		Device device;
		
		/**
		 * Calculates and returns the color id of the
		 * given Color resource.
		 *
		 * Params:
		 * 		red = The red value.
		 *		green = The green value.
		 *		blue = The blue value.
		 * Returns: The id of the Color resource.
		 * Date: April 15, 2014
		 */
		long getColorId(int red, int green, int blue) {
			return red * 255 * 255 + green * 255 + blue;
		}
}
