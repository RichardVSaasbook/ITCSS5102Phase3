module phase3.gui.ColorSelector;

import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.SWT;

import phase3.color.ColorManager;
import phase3.color.HSLColor;
import phase3.color.RGBColor;
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
			this.colorManager = colorManager;
			
			changeColor(new HSLColor(60, 1, 0.5));
			setLayout(WidgetFactory.createGridLayout(2));
			setupWidgets();
		}
		
	private:
		Color activeColor;
		ColorManager colorManager;
		
		/**
		 * Changes the color to the given color.
		 */
		void changeColor(HSLColor hslColor) {
			activeColor = colorManager.getColor(hslColor);
		}
	
		void setupWidgets() {
			// Label
			Label colorLabel = new Label(this, SWT.PUSH);
			colorLabel.setText("Color");
			
			// Canvas
			Canvas canvas = new Canvas(this, SWT.NO_BACKGROUND | SWT.PUSH);
			GridData gridData = new GridData();
			gridData.widthHint = 100;
			gridData.heightHint = 24;
			canvas.setLayoutData(gridData);
			canvas.addPaintListener(new class PaintListener {
				public:
					override void paintControl(PaintEvent e) {
						Rectangle clientArea = canvas.getClientArea();
					
						// Draw background color
						e.gc.setBackground(activeColor);
						e.gc.fillRectangle(clientArea);
						
						// Draw border
						e.gc.setForeground(display.getSystemColor(SWT.COLOR_GRAY));
						e.gc.drawLine(0, 0, clientArea.width - 1, 0);
						e.gc.drawLine(0, 0, 0, clientArea.height - 2);
						
						e.gc.setForeground(display.getSystemColor(SWT.COLOR_DARK_GRAY));
						e.gc.drawLine(0, clientArea.height - 1, clientArea.width - 1, clientArea.height - 1);
						e.gc.drawLine(clientArea.width - 1, 1, clientArea.width - 1, clientArea.height - 2);
					}
			});
		}
}
