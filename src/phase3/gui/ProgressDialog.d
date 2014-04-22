module phase3.gui.ProgressDialog;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.ProgressBar;
import org.eclipse.swt.widgets.Shell;

/**
 * A simple dialog which displays a ProgressBar.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 21, 2014
 */
class ProgressDialog : Shell {
	public:
		/**
		 * Creates a new ProgressDialog.
		 *
		 * Params:
		 *		parent = The parent Shell of this dialog.
		 * Date: April 21, 2014
		 */
		this(Shell parent) {
			super(parent, SWT.APPLICATION_MODAL);
			
			progressBar = new ProgressBar(this, SWT.NONE);
			progressBar.setMaximum(1000);
			
			pack();
			open();
		}
		
		/**
		 * Sets the progress of the ProgressBar.
		 *
		 * Params:
		 *		progress = The progress (from 0 - 1000) of the
		 *				ProgressBar.
		 * Date: April 21, 2014
		 */
		void setProgress(int progress) {
			progressBar.setSelection(progress);
		}
	private:
		ProgressBar progressBar;
}
