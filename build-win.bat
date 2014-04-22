dmd -ofphase3 -D -op -odbin -Dddoc src\main.d src\phase3\gui\MainShell.d ^
src\phase3\gui\Dimen.d src\phase3\gui\WidgetFactory.d src\phase3\gui\ColorSelector.d ^
src\phase3\gui\ImageCanvas.d src\phase3\gui\NewDialog.d src\phase3\gui\ProgressDialog.d ^
src\phase3\listeners\PixelClickListener.d src\phase3\listeners\TaskFinishListener.d ^
src\phase3\listeners\CreateNewImageListener.d ^
src\phase3\color\ColorManager.d src\phase3\color\RGBColor.d ^
src\phase3\thread\AsyncTask.d src\phase3\thread\InvertColorsAsyncTask.d ^
src\phase3\thread\RemoveRefsAsyncTask.d ^
-Isrc\dwt\imp -Jsrc\dwt\org.eclipse.swt.win32.win32.x86\res -L+src\dwt\lib\ ^
-L+org.eclipse.swt.win32.win32.x86.lib -L+dwt-base.lib -L/SUBSYSTEM:WINDOWS:4.0
