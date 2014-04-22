module phase3.gui.MainShell;

import org.eclipse.swt.custom.ScrolledComposite;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.SWT;

import phase3.color.ColorManager;
import phase3.color.RGBColor;
import phase3.gui.ColorSelector;
import phase3.gui.ImageCanvas;
import phase3.gui.NewDialog;
import phase3.gui.WidgetFactory;
import phase3.listeners.CreateNewImageListener;
import phase3.listeners.PixelClickListener;
import phase3.listeners.TaskFinishListener;
import phase3.thread.InvertColorsAsyncTask;
import phase3.thread.RemoveRefsAsyncTask;

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
		this(Display display, ColorManager colorManager) {
			super(display);
			
			this.display = display;
			this.colorManager = colorManager;
			mainShell = this;
			
			setText("Phase 3: Simple Image Viewer and Editor");
			setMenuBar(createMenuBar());
			setLayout(WidgetFactory.createGridLayout(2, true));
			colorSelector = new ColorSelector(this, colorManager);
			editor = WidgetFactory.createScrolledComposite(this);
			preview = WidgetFactory.createScrolledComposite(this);
			
			setupCanvases(1, 1);
			
			open();
		}
	
	private:
		Display display;
		ColorManager colorManager;
		Shell mainShell;
		ScrolledComposite editor,
			preview;
		ColorSelector colorSelector;
		ImageCanvas editCanvas,
			previewCanvas;
	
		/**
		 * Creates the MainShell's Menu bar.
		 *
		 * Returns: The MainShell's Menu bar.
		 * Date: April 9, 2014
		 */
		Menu createMenuBar() {
			MainShell mainShell = this;
		
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
						NewDialog newDialog = new NewDialog(mainShell);
						newDialog.setCreateNewImageListener(new class CreateNewImageListener {
							public:
								override void onCreateNewImage(int width, int height) {
									new RemoveRefsAsyncTask(display, colorManager, editCanvas.getPixelColors());
									
									editCanvas.dispose();
									previewCanvas.dispose();
									
									setupCanvases(width, height);
									newDialog.dispose();
								}
						});
					}
			});
			
			MenuItem openItem = new MenuItem(fileMenu, SWT.PUSH);
			openItem.setText("&Open Image");
			openItem.addSelectionListener(new class SelectionAdapter {
				public:
					override void widgetSelected(SelectionEvent e) {
						FileDialog f = new FileDialog(mainShell, SWT.APPLICATION_MODAL);
						string filename = f.open();
						
						openImage(filename);
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
			
			MenuItem invertItem = new MenuItem(editMenu, SWT.PUSH);
			invertItem.setText("&Invert Image");
			invertItem.addSelectionListener(new class SelectionAdapter {
				public:
					override void widgetSelected(SelectionEvent e) {
						InvertColorsAsyncTask invertColorsAsyncTask = new InvertColorsAsyncTask(display, mainShell, editCanvas.getPixelColors());
						invertColorsAsyncTask.setTaskFinishListener(new class TaskFinishListener!(RGBColor[][]) {
							public:
								override void onTaskFinish(RGBColor[][] data) {
									editCanvas.setPixelColors(data);
									previewCanvas.setPixelColors(data);
								}
						});
					}
			});
			
			return menuBar;
		}
		
		/*
		 * Sets up the edit and preview canvases.
		 */
		void setupCanvases(int width, int height) {
			editCanvas = new ImageCanvas(editor, colorManager, display.getSystemColor(SWT.COLOR_GRAY), width, height, 25, 25, true);
			editor.setContent(editCanvas);
			
			previewCanvas = new ImageCanvas(preview, colorManager, display.getSystemColor(SWT.COLOR_GRAY), width, height, 1, 1, false);
			preview.setContent(previewCanvas);
			
			editCanvas.setPixelClickListener(new class PixelClickListener {
				public:
					override void onPixelClick(int x, int y) {
						Color activeColor = colorSelector.getActiveColor();
						RGBColor rgbColor = new RGBColor(cast(ubyte) activeColor.getRed(), cast(ubyte) activeColor.getGreen(), cast(ubyte) activeColor.getBlue());
						
						editCanvas.setPixelColor(rgbColor, x, y);
						previewCanvas.setPixelColor(rgbColor, x, y);
					}
			});
		}
		
		/*
		 * Opens up an image.
		 */
		void openImage(string filename) {
		
		}
}
