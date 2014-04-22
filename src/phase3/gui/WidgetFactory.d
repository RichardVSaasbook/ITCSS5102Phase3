module phase3.gui.WidgetFactory;

import org.eclipse.swt.custom.ScrolledComposite;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.SWT;

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
		 * 		numColumns = The number of columns for the GridLayout.
		 *		makeColumnsEqualWidth = Whether or not to make
		 *					the columns equal width.
		 * Returns: The GridLayout.
		 * Date: April 10, 2014
		 */
		static GridLayout createGridLayout(int numColumns, bool makeColumnsEqualWidth) {
			GridLayout gridLayout = new GridLayout(numColumns, makeColumnsEqualWidth);
			
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
		 * Params:
		 *		colSpan = The number of columns the GridData
		 *				should span.
		 * Returns: The GridData.
		 * Date: April 10, 2014
		 */
		static GridData createGridData(int colSpan) {
			GridData gridData = new GridData();
			
			gridData.horizontalAlignment = GridData.FILL;
			gridData.horizontalSpan = colSpan;
			
			return gridData;
		}
		
		/**
		 * Creates a new ScrolledComposite that will scroll
		 * horizontally and vertically, has a border, and
		 * fills its parents space.
		 *
		 * Params:
		 *		parent = The Composite that the new
		 *				ScrolledComposite will be a child of.
		 * Returns: The ScrolledComposite.
		 * Date: April 16, 2014
		 */
		static ScrolledComposite createScrolledComposite(Composite parent) {
			ScrolledComposite sc = new ScrolledComposite(parent, SWT.HORIZONTAL | SWT.VERTICAL | SWT.BORDER);
			sc.setExpandHorizontal(true);
			sc.setExpandVertical(true);
			sc.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true));
			sc.setMinWidth(50);
			sc.setMinHeight(50);
			sc.setMinSize(sc.computeSize(SWT.DEFAULT, SWT.DEFAULT));
			
			return sc;
		}
}
