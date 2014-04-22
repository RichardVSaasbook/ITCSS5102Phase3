module phase3.color.ColorManager;

import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Device;
import org.eclipse.swt.graphics.RGB;

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
		 * Increments the reference count for the given Color
		 * by one.
		 *
		 * Params:
		 * 		rgb = The Color being referenced.
		 * Date: April 16, 2014
		 */
		void addRef(RGB rgb) {
			long colorId = getColorId(rgb);
			long refCount = refs.get(colorId, 0);
			refs[colorId] = refCount + 1;
		}
		
		/**
		 * Decrements the reference count for the given Color
		 * by one. If the reference count reaches 0, the Color
		 * resource is disposed.
		 *
		 * Params:
		 *		rgb = The Color being referenced.
		 * Date: April 16, 2014
		 */
		void removeRef(RGB rgb) {
			long colorId = getColorId(rgb);
			long refCount = refs.get(colorId, 0);
			refs[colorId] = refCount - 1;
			
			if (refs[colorId] == 0) {
				colors[colorId].dispose();
			}
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
		Color getColor(RGB rgb) {
			long colorId = getColorId(rgb);
			
			if (colorId !in colors) {
				colors[colorId] = new Color(device, rgb);
			}
			
			if (colors[colorId].isDisposed) {
				colors[colorId] = new Color(device, rgb);
			}
			
			return colors[colorId];
		}
		
	private:
		Color[long] colors;
		long[long] refs;
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
		long getColorId(RGB rgb) {
			return rgb.red * 255 * 255 + rgb.green * 255 + rgb.blue;
		}
}
