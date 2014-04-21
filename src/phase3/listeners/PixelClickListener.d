module phase3.listeners.PixelClickListener;

/**
 * The PixelClickListener is fired whenever a pixel
 * in an ImageCanvas is clicked on.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 20, 2014
 */
interface PixelClickListener {
	public:
		/**
		 * Called when a pixel is clicked.
		 *
		 * Params:
		 *		x = The x-coordinate of the clicked pixel.
		 *		y = The y-coordinate of the clicked pixel.
		 * Date: April 20, 2014
		 */
		void onPixelClick(int x, int y);
}
