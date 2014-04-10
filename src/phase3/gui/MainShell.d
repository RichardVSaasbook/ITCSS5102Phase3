module phase3.gui.MainShell;

import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.SWT;

import phase3.gui.ColorSelector;
import phase3.gui.WidgetFactory;

/**
 * The MainShell class is the Shell window that runs the
 * entire program.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 9, 2014
 */
class MainShell : Shell {
	public:
		/**
		 * Create, setup, and display the MainShell.
		 *
		 * Params:
		 * 		display = The display to draw the Shell from.
		 * Date: April 9, 2014
		 */
		this(Display display) {
			super(display);
			setText("Phase 3: Simple Image Viewer and Editor");
			setMenuBar(createMenuBar());
			setLayout(WidgetFactory.createGridLayout(2));
			new ColorSelector(this, display.getCurrent());
	
			open();
		}
	
	private:
		/**
		 * Creates the MainShell's Menu bar.
		 *
		 * Returns: The MainShell's Menu bar.
		 * Date: April 9, 2014
		 */
		Menu createMenuBar() {
			Menu menuBar = new Menu(this, SWT.BAR);
			
			// File Menu.
			Menu fileMenu = new Menu(this, SWT.DROP_DOWN);
			
			MenuItem fileItem = new MenuItem(menuBar, SWT.CASCADE);
			fileItem.setText("&File");
			fileItem.setMenu(fileMenu);
			
			MenuItem newItem = new MenuItem(fileMenu, SWT.PUSH);
			newItem.setText("&New Image");
			newItem.addSelectionListener(new class SelectionAdapter {
				public:
					override void widgetSelected(SelectionEvent e) {
						// TODO: open new image dialog.
					}
			});
			
			MenuItem openItem = new MenuItem(fileMenu, SWT.PUSH);
			openItem.setText("&Open Image");
			openItem.addSelectionListener(new class SelectionAdapter {
				public:
					override void widgetSelected(SelectionEvent e) {
						// TODO: open open image file dialog.
					}
			});
			
			MenuItem saveItem = new MenuItem(fileMenu, SWT.PUSH);
			saveItem.setText("&Save Image");
			saveItem.addSelectionListener(new class SelectionAdapter {
				public:
					override void widgetSelected(SelectionEvent e) {
						// TODO: open save image file dialog.
					}
			});
			
			// Edit Menu.
			Menu editMenu = new Menu(this, SWT.DROP_DOWN);
			
			MenuItem editItem = new MenuItem(menuBar, SWT.CASCADE);
			editItem.setText("&Edit");
			editItem.setMenu(editMenu);
			editItem.addSelectionListener(new class SelectionAdapter {
				public:
					override void widgetSelected(SelectionEvent e) {
						// TODO: invert all colors in the image.
					}
			});
			
			MenuItem invertItem = new MenuItem(editMenu, SWT.PUSH);
			invertItem.setText("&Invert Image");
			
			return menuBar;
		}
}
