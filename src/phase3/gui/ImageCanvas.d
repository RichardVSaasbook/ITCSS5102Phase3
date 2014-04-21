module phase3.gui.ImageCanvas;

import phase3.listeners.PixelClickListener;
import phase3.color.ColorManager;
import phase3.color.RGBColor;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;

/**
 * The ImageCanvas stores and displays all of the pixels
 * in the current image.
 *
 * Authors: Zachery Burris (zburris@uncc.edu) and Richard Voelker (rvoelker@uncc.edu)
 * Date: April 20, 2014
 */
class ImageCanvas : Canvas {
	public:
		/**
		 * Creates a new ImageCanvas.
		 *
		 * Params:
		 *		parent = The Composite that contains this ImageCanvas.
		 * Date: April 20, 2014
		 */
		this(Composite parent, ColorManager colorManager, Color gridColor, uint width, uint height, uint pixelWidth, uint pixelHeight, bool showGrid) {
			super(parent, SWT.NONE);
			
			this.colorManager = colorManager;
			this.gridColor = gridColor;
			this.width = width;
			this.height = height;
			this.pixelWidth = pixelWidth;
			this.pixelHeight = pixelHeight;
			this.showGrid = showGrid;
			
			GridData gridData = new GridData();
			gridData.widthHint = width;
			gridData.heightHint = height;
			setLayoutData(gridData);
			
			pixelColors = new RGBColor[][](width, height);
			for (int i = 0; i < width; i++) {
				for (int j = 0; j < height; j++) {
					pixelColors[i][j] = new RGBColor(255, 255, 255);
				}
			}
			
			addMouseListener(new class MouseListener {
				public:
					override void mouseDoubleClick(MouseEvent e) {}
					override void mouseUp(MouseEvent e) {}
					
					override void mouseDown(MouseEvent e) {
						if (pixelClickListener !is null) {
							pixelClickListener.onPixelClick(e.x / pixelWidth, e.y / pixelHeight);
						}
					}
			});
			
			addPaintListener(new class PaintListener {
				public:
					override void paintControl(PaintEvent e) {
						if (e.x == 0) {
							for (int x = 0; x < width; x++) {
								for (int y = 0; y < height; y++) {
									fillPixel(e.gc, x * pixelWidth, y * pixelHeight);
								}
							}
						}
						else {
							fillPixel(e.gc, e.x, e.y);
						}
					}
			});
		}
		
		/**
		 * Params:
		 *		pixelClickListener = The PixelClickListener to be fired whenever
		 *				a pixel in this ImageCanvas is clicked.
		 * Date: April 20, 2014
		 */
		void setPixelClickListener(PixelClickListener pixelClickListener) {
			this.pixelClickListener = pixelClickListener;
		}
		
		/**
		 * Params:
		 *		x = The x-coordinate of the pixel.
		 *		y = The y-coordinate of the pixel.
		 * Returns: The pixel RGBColor at the given x and y coordinates.
		 * Date: April 20, 2014
		 */
		RGBColor getPixelColor(int x, int y) {
			return pixelColors[x][y];
		}
		
		/**
		 * Params:
		 *		color = The RGBColor to change the pixel to.
		 *		x = The x-coordinate of the pixel.
		 *		y = The y-coordinate of the pixel.
		 * Date: April 20, 2014
		 */
		void setPixelColor(RGBColor color, int x, int y) {
			lastChangedColor = pixelColors[x][y];
		
			pixelColors[x][y] = color;
			redraw(x * pixelWidth, y * pixelHeight, pixelWidth, pixelHeight, false);
		}
		
	private:
		ColorManager colorManager;
		Color gridColor;
		uint width, height,
			pixelWidth, pixelHeight;
		bool showGrid;
		PixelClickListener pixelClickListener;
		RGBColor[][] pixelColors;
		RGBColor lastChangedColor;
		
		/*
		 * Fills a particular pixel when a redraw is necessary.
		 */
		void fillPixel(GC gc, int x, int y) {
			RGBColor newColor = pixelColors[x / pixelWidth][y / pixelHeight];
			
			if (lastChangedColor !is null) {
				colorManager.removeRef(lastChangedColor.getRGB());
			}
			
			colorManager.addRef(newColor.getRGB());
			
			// Fill pixel
			gc.setBackground(colorManager.getColor(newColor.getRGB()));
			gc.fillRectangle(x, y, pixelWidth, pixelHeight);
			
			// Draw grid, if present
			if (showGrid) {
				gc.setForeground(gridColor);
				gc.drawLine(x, y + pixelHeight - 1, x + pixelWidth - 1, y + pixelHeight - 1);
				gc.drawLine(x + pixelWidth - 1, y, x + pixelWidth - 1, y + pixelHeight - 1);
			}
		}
}
