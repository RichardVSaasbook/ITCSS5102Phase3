module phase3.thread.InvertColorsAsyncTask;

import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

import phase3.color.RGBColor;
import phase3.thread.AsyncTask;

/**
 * Inverts all of the Colors in a 2-dimensional RGBColor
 * array.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 21, 2014
 */
class InvertColorsAsyncTask : AsyncTask!(RGBColor[][]) {
	public:
		/**
		 * Creates a new InvertColorsAsyncTask.
		 *
		 * Params:
		 *		display = The main Display of the application.
		 *		mainShell = The main Shell of the application.
		 *		colors = The RGBColor array.
		 * Date: April 21, 2014
		 */
		this(Display display, Shell mainShell, RGBColor[][] colors) {
			super(display, mainShell, true);
			this.colors = colors;
		}
	
	protected:
		/*
		 * Invert each color.
		 */
		override void doInBackground() {
			int width = colors.length;
			int height = colors[0].length;
			float progressIncrement = width * height / 1000.0;
			RGBColor[][] invertedColors = new RGBColor[][](width, height);
			RGBColor white = new RGBColor(255, 255, 255);
			
			for (int x = 0; x < width; x++) {
				for (int y = 0; y < height; y++) {
					invertedColors[x][y] = white - colors[x][y];
					updateProgress(cast(int) ((x * width + y) * progressIncrement));
				}
			}
			
			finish(invertedColors);
		}
	
	private:
		RGBColor[][] colors;
}
