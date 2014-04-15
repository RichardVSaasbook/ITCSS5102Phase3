import org.eclipse.swt.widgets.Display;

import phase3.color.ColorManager;
import phase3.gui.MainShell;

void main () {
	Display display = new Display;
	ColorManager colorManager = new ColorManager(display.getCurrent());
	MainShell shell = new MainShell(display, colorManager);

	while (!shell.isDisposed) {
		if (!display.readAndDispatch()) {
			display.sleep();
		}
	}

	colorManager.disposeColors();
	display.dispose();
}
