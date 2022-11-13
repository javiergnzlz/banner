Banner para PET 40COL - pasar por pantalla un mensaje de texto ampliado

La carpeta code contiene un fichero con el listado BASIC y otro fichero con el listado en ensamblador con sintaxis cbmprg

La carpeta bin contiene los archivos binarios ejecutables del programa BASIC, del programa en lenguaje máquina que será cargado por el anterior y del juego de caracteres mayúsculas/minúsculas. También contiene el binario del juego de caracteres mayúsculas/gráficos, pero o bien se renombra o bien se modifica el listado BASIC (se puede hacer esto desde el mismo editor del interprete de BASIC en la máquina real o en el ensamblador).

El fichero d64 contiene la imagen en formato de disketera 1541 (equivalente a CBM2031 en PET) con los 3 archivos binarios ya preparados. Montada la imagen de disco el programa se ejecuta con LOAD"BANPET",8 y después RUN.
