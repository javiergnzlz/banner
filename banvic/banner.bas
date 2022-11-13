100 ifa=1then150
110 ifa=2then230
120 b=23:ifpeek(44)=18thenb=25
130 poke51,64:poke52,b:poke55,64:poke56,b:poke643,64:poke644,b:clr
140 a=1:c=peek(184):load"mc",c,1
150 ifpeek(44)<>18then240
160 poke6498,0:poke6499,48
170 ifc=1then240
180 open15,8,15,"r0:charset=charset"
190 input#15,e,e$,t,s
200 close15
!-210 ife<>63then240
210 ife=62then240
220 a=2:load"charset",8,1
!-230 poke6528,peek(195):poke6529,peek(196)
230 poke6496,0:poke6497,32
240 sys7034
250 a$="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod"
260 a$=a$+" tempor incididunt ut labore et dolore magna aliqua. Ut enim ad "
270 a$=a$+"minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
280 a$=a$+"aliquip ex ea commodo consequat. "
290 i=1:goto320
300 i=i+1:ifi>len(a$)theni=1
320 c=asc(mid$(a$,i,1))
330 ifc=255thenc=94:goto400
340 ifc>191thenc=c-128:goto400
350 ifc>159thenc=c-64:goto400
360 ifc>127thenc=c+64:goto400
370 ifc>95thenc=c-32:goto400
380 ifc>63thenc=c-64:goto400
390 ifc<32thenc=c+128
400 poke1,c
410 sys6655:goto500
430 sys6719
440 if peek(0)<>0then300
500 getb$:ifb$=""then430
510 ifb$="q"thensys7143:stop
520 b=asc(b$):ifb<49then430
530 ifb<53thenpoke253,b-48:goto430
540 ifb<65then430
550 ifb<70thenpoke254,b-65:goto430 
560 goto430