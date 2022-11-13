# banner
Muestra un mensaje de texto desplazandose por la pantalla. Para VIC20 o PET 40 columnas con BASIC 2/4

Mirar la imagen banpet.gif para ver el funcionamiento

Es un programa representativo de lo que son las máquinas de Commodore que he subido con una intención algo didáctica. Sin embargo considero que no es lo suficientemente sencillo para ser introductorio

Para cambiar el factor de ampliación horizontal de los caracteres pulsar las teclas 1,2,3 o 4. Para cambiar el factor de ampliación vertical de los caracteres pulsar las teclas A,B,C,D,E.

El documento "banner bas pdf" explica cómo funciona este programa, o sea, describe:
- El proceso para formar caracteres de texto ampliados a partir de los de 16 caracteres del juego de caracteres PETSCII que están formados por cuadraditos de 4x4 pixels.
- El proceso para hacer "scroll" de derecha a izquierda, del mensaje de texto ampliado
- Lo que hacen los listados BASIC para VIC20 y para Commodore PET
- Lo que hace el listado en lenguaje máquina.

Hay dos carpetas, banpet para PET y banvic para VIC20. Cada una contiene una imagen de disco d64 preparada para ser ejecutada en emulador o volcada a disquetera o emulador de disquetera. 

También contiene una carpeta con los los listados BASIC y en ensamblador con sintaxis cbmprg y otra carpeta con los archivos binarios del programa principal, del programa en lenguaje de máquina que es cargado por el programa anterior, y de los juegos de caracteres mayúscula/minúsculas y mayúsculas/gráficos.

Los ficheros de los juegos de caracteres son idénticos para VIC20 y PET40COL excepto por la dirección por defecto de carga.
