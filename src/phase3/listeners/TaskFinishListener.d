module phase3.listeners.TaskFinishListener;

/**
 * The TaskFinishListener is fired whenever an AsyncTask
 * finishes.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 22, 2014
 */
interface TaskFinishListener(T) {
	public:
		/**
		 * Called when the AsyncTask finishes.
		 *
		 * Params:
		 *		data = The data the AsyncTask has been creating.
		 * Date: April 22, 2014
		 */
		void onTaskFinish(T data);
}
