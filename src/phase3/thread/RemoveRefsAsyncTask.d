module phase3.thread.RemoveRefsAsyncTask;

import org.eclipse.swt.widgets.Display;

import phase3.color.ColorManager;
import phase3.color.RGBColor;
import phase3.thread.AsyncTask;

/**
 * Removes references to all colors in a 2-dimensional
 * RGBColor array.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 21, 2014
 */
class RemoveRefsAsyncTask : AsyncTask!int {
	public:
		/**
		 * Creates a new RemoveRefsAsyncTask.
		 *
		 * Params:
		 *		display = The main Display of the application.
		 *		colorManager = The ColorManager of the application.
		 *		colors = The RGBColors to remove references of.
		 */
		this(Display display, ColorManager colorManager, RGBColor[][] colors) {
			super(display, null, false);
			this.colorManager = colorManager;
			this.colors = colors;
		}
		
	protected:
		/**
		 * Remove two references to all colors in the RGBColors
		 * array.
		 */
		override void doInBackground() {
			for (int x = 0; x < colors.length; x++) {
				for (int y = 0; y < colors[x].length; y++) {
					colorManager.removeRef(colors[x][y].getRGB());
					colorManager.removeRef(colors[x][y].getRGB());
				}
			}
		}
		
	private:
		ColorManager colorManager;
		RGBColor[][] colors;
}
