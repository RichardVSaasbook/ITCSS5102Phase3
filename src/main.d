import org.eclipse.swt.widgets.Display;
import phase3.gui.MainShell;

void main () {
	Display display = new Display;
	MainShell shell = new MainShell(display);

	while (!shell.isDisposed) {
		if (!display.readAndDispatch()) {
			display.sleep();
		}
	}

	display.dispose();
}
