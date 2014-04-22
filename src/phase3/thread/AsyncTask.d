module phase3.thread.AsyncTask;

import java.lang.Thread;
import java.lang.Runnable;

import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

import phase3.gui.ProgressDialog;
import phase3.listeners.TaskFinishListener;

/**
 * Interface for a large task to be run in the background. It
 * displays a ProgressDialog and should update the progress
 * regularly.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 21, 2014
 */
abstract class AsyncTask(T) {
	public:
		/**
		 * Creates a new AsyncTask and starts running the task.
		 *
		 * Params:
		 *		display = The main Display of the application.
		 *		mainShell = The Shell to parent the ProgressDialog
		 *				to.
		 *		showProgress = Whether or not to show the
		 *				Progress Dialog.
		 * Date: April 21, 2014
		 */
		this(Display display, Shell mainShell, bool showProgress) {
			this.display = display;
			
			if (showProgress) {
				progressDialog = new ProgressDialog(mainShell);
			}
			
			(new Thread(new class Runnable {
				public:
					override void run() {
						doInBackground();
					}
			})).start();
		}
		
		/**
		 * Sets the TaskFinishListener to be called when
		 * the task finishes.
		 *
		 * Params:
		 *		taskFinishListener = The TaskFinishListener.
		 * Date: April 22, 2014
		 */
		void setTaskFinishListener(TaskFinishListener!T taskFinishListener) {
			this.taskFinishListener = taskFinishListener;
		}
		
	protected:
		/*
		 * Method that should perform the large task. When
		 * progress is made, a call to updateProgress can
		 * be made and when the task is finished, pass the
		 * data to the finish method.
		 */
		abstract void doInBackground();
		
		/*
		 * Once the task is done, send the data to the Listener.
		 */
		void finish(T data) {
			display.asyncExec(new class Runnable {
				public:
					override void run() {
						if (taskFinishListener !is null) {
							taskFinishListener.onTaskFinish(data);
						};
						
						progressDialog.dispose();
					}
			});
		}
		
		/*
		 * Updates the ProgressDialog.
		 */
		void updateProgress(int progress) {
			display.syncExec(new ProgressUpdater(progress));
		}
		
	private:
		Display display;
		ProgressDialog progressDialog;
		TaskFinishListener!T taskFinishListener;
		
		/*
		 * Helper class to update the ProgressDialog's progress on
		 * the main thread.
		 */
		class ProgressUpdater : Runnable {
			public:
				this(int progress) {
					this.progress = progress;
				}
				
				override void run() {
					progressDialog.setProgress(progress);
				}
			private:
				int progress;
		}
}
