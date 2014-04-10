module phase3.gui.ColorSelector;

import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Device;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.SWT;

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
		this(Shell parent, Device device) {
			super(parent, SWT.NO_BACKGROUND);
			this.device = device;
			
			changeColor(new HSLColor(60, 1, 0.5));
			setLayout(WidgetFactory.createGridLayout(2));
			setupWidgets();
		}
		
	private:
		Device device;
		Color color;
		
		void changeColor(HSLColor hslColor) {
			if (color !is null) {
				color.dispose();
			}
			
			color = hslColor.toSWTColor(device);
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
						e.gc.setBackground(color);
						e.gc.fillRectangle(canvas.getClientArea());
					}
			});
		}
}
