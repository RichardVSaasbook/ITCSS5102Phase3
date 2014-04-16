module phase3.gui.ColorSelector;

import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.ColorDialog;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.SWT;

import phase3.color.ColorManager;
import phase3.gui.WidgetFactory;

/**
 * The ColorSelector is a Composite that holds to simple
 * Widgets, a Label and a Canvas. Clicking on the Canvas
 * will open a Dialog that will all the user to change
 * the color.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 10, 2014
 */
class ColorSelector : Composite {
	public:
		/**
		 * Creates a new ColorSelector.
		 *
		 * Params:
		 *		parent = The Shell containing this ColorSelector.
		 *		display = The Display the Shell is on.
		 * Date: April 10, 2014
		 */
		this(Shell parent, ColorManager colorManager) {
			super(parent, SWT.NO_BACKGROUND);
			this.parent = parent;
			this.colorManager = colorManager;
			
			setLayout(WidgetFactory.createGridLayout(2, false));
			setLayoutData(WidgetFactory.createGridData(2));
			setupWidgets();
			changeColor(new RGB(255, 255, 255));
		}
		
		/**
		 * Returns: The active Color being used.
		 * Date: April 16, 2014
		 */
		Color getActiveColor() {
			return activeColor;
		}
		
	private:
		Shell parent;
		Color activeColor;
		ColorManager colorManager;
		Canvas canvas;
		
		/**
		 * Changes the color to the given color.
		 */
		void changeColor(RGB rgb) {
			if (activeColor !is null) {
				colorManager.removeRef(rgb);
			}
			
			activeColor = colorManager.getColor(rgb);
			colorManager.addRef(rgb);
			canvas.redraw();
		}
	
		/**
		 * Sets up Widgets for the Shell.
		 */
		void setupWidgets() {
			// Label
			Label colorLabel = new Label(this, SWT.PUSH);
			colorLabel.setText("Color");
			
			// Canvas
			canvas = new Canvas(this, SWT.NO_BACKGROUND | SWT.BORDER | SWT.PUSH);
			GridData gridData = new GridData();
			gridData.widthHint = 100;
			gridData.heightHint = 24;
			canvas.setLayoutData(gridData);
			canvas.addMouseListener(new class MouseListener {
				public:
					override void mouseDoubleClick(MouseEvent e) {}
					override void mouseUp(MouseEvent e) {}
					
					override void mouseDown(MouseEvent e) {
						// Open up a ColorDialog.
						ColorDialog colorDialog = new ColorDialog(parent);
						colorDialog.setRGB(activeColor.getRGB());
						RGB rgb = colorDialog.open();
						
						if (rgb !is null) {
							changeColor(rgb);
						}
					}
			});
			canvas.addPaintListener(new class PaintListener {
				public:
					override void paintControl(PaintEvent e) {
						Rectangle clientArea = canvas.getClientArea();
					
						e.gc.setBackground(activeColor);
						e.gc.fillRectangle(clientArea);
					}
			});
		}
}
