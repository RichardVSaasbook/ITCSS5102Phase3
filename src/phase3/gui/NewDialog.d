module phase3.gui.NewDialog;

import std.conv;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;

import phase3.gui.WidgetFactory;
import phase3.listeners.CreateNewImageListener;

/**
 * The NewDialog pops up whenever the user is creating
 * a new image.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 21, 2014
 */
class NewDialog : Shell {
	public:
		/**
		 * Creates a new NewDialog.
		 *
		 * Params:
		 *		parent = The parent Composite.
		 * Date: April 21, 2014
		 */
		this(Shell parent) {
			super(parent, SWT.APPLICATION_MODAL);
			setLayout(WidgetFactory.createGridLayout(2, false));
			createChildren();
			addListeners();
			open();
		}
		
		void setCreateNewImageListener(CreateNewImageListener createNewImageListener) {
			this.createNewImageListener = createNewImageListener;
		}
		
	private:
		Text widthText,
			heightText;
		Button confirmButton,
			cancelButton;
		CreateNewImageListener createNewImageListener;
		
		/*
		 * Creates all of this dialog's children.
		 */
		void createChildren() {
			widthText = createTextBoxWithLabel("Width");
			heightText = createTextBoxWithLabel("Height");
			confirmButton = createButton("Create Image");
			cancelButton = createButton("Cancel");
			
			pack();
		}
		
		/*
		 * Creates a Label with the given text and a neighboring
		 * Text.
		 */
		Text createTextBoxWithLabel(string text) {
			createLabel(text);
			return createTextBox();
		}
		
		/*
		 * Creates a Label with the given text.
		 */
		void createLabel(string text) {
			Label label = new Label(this, SWT.PUSH);
			label.setText(text);
		}
		
		/*
		 * Creates and returns a Text.
		 */
		Text createTextBox() {
			Text text = new Text(this, SWT.PUSH);
			text.setEditable(true);
			return text;
		}
		
		/*
		 * Creates and returns a Button.
		 */
		Button createButton(string text) {
			Button button = new Button(this, SWT.PUSH);
			button.setText(text);
			return button;
		}
		
		/*
		 * Adds EventListeners to the Buttons.
		 */
		void addListeners() {
			confirmButton.addMouseListener(new class MouseListener {
				public:
					override void mouseDoubleClick(MouseEvent e) {}
					override void mouseUp(MouseEvent e) {}
					
					override void mouseDown(MouseEvent e) {
						if (createNewImageListener !is null) {
							try {
								int width = to!int(widthText.getText());
								int height = to!int(heightText.getText());
								
								if (width <= 0) {
									width = 1;
								}
								
								if (height <= 0) {
									height = 1;
								}
							
								createNewImageListener.onCreateNewImage(width, height);
							}
							catch (Exception e) {
								// Numbers not entered, just send a 1-by-1 image.
								createNewImageListener.onCreateNewImage(1, 1);
							}
						}
					}
			});
		
			cancelButton.addMouseListener(new class MouseListener {
				public:
					override void mouseDoubleClick(MouseEvent e) {}
					override void mouseUp(MouseEvent e) {}
					
					override void mouseDown(MouseEvent e) {
						dispose();
					}
			});
		}
}
