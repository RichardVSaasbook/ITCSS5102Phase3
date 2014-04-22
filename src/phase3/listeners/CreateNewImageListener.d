module phase3.listeners.CreateNewImageListener;

/**
 * This listener is fired whenever the user clicks
 * the create Button in the NewDialog.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 22, 2014
 */
interface CreateNewImageListener {
	public:
		/**
		 * Called whenever the NewDialog confirms an imag
		 * creation.
		 *
		 * Params:
		 *		width = The width of the image.
		 *		height = The height of the image.
		 * Date: April 22, 2014
		 */
		void onCreateNewImage(int width, int height);
}
