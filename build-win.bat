dmd -ofphase3 -D -op -odbin -Dddoc src\main.d src\phase3\gui\MainShell.d ^
src\phase3\color\RGBColor.d src\phase3\color\HSLColor.d ^
-Isrc\dwt\imp -Jsrc\dwt\org.eclipse.swt.win32.win32.x86\res -L+src\dwt\lib\ ^
-L+org.eclipse.swt.win32.win32.x86.lib -L+dwt-base.lib -L/SUBSYSTEM:WINDOWS:4.0
