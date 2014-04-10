module phase3.gui.WidgetFactory;

import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;

import phase3.gui.Dimen;

/**
 * Allows for the easy creation of tedious SWT Widgets and Layouts.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 10, 2014
 */
class WidgetFactory {
	public:
		/**
		 * Creates a new GridLayout with dimensions from the
		 * Dimen class.
		 *
		 * Params:
		 * 		direction = The direction the GridLayout is
		 *					going in. SWT.VERTICAL or
		 *					SWT.HORIZONTAL.
		 * Returns: The GridLayout.
		 * Date: April 10, 2014
		 */
		static GridLayout createGridLayout(int columns) {
			GridLayout gridLayout = new GridLayout();
			
			gridLayout.numColumns = columns;
			gridLayout.makeColumnsEqualWidth = true;
			gridLayout.marginWidth = Dimen.MARGIN;
			gridLayout.marginHeight = Dimen.MARGIN;
			gridLayout.horizontalSpacing = Dimen.SPACING;
			gridLayout.verticalSpacing = Dimen.SPACING;
			
			return gridLayout;
		}
		
		/**
		 * Creates a new GridData item with the specified
		 * column span.
		 *
		 * Returns: The GridData.
		 * Date: April 10, 2014
		 */
		static GridData createGridData(int colSpan) {
			GridData gridData = new GridData();
			
			gridData.horizontalAlignment = GridData.FILL;
			gridData.horizontalSpan = colSpan;
			
			return gridData;
		}
}
