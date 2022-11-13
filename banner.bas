100 ifa=1then150
110 ifa=2then230
120 poke59468,14:b=17
130 poke48,0:poke49,b:poke52,0:poke53,b:clr
140 a=1:c=peek(212):load"mc",c,1 !-es F1 en vez de D4 en basic 1 (241 en vez de 212)
150 ifc=1then220
170 open15,8,15,"r0:charset=charset"
180 input#15,e,e$,t,s
190 close15
210 ife=62thenstop
220 a=2:load"charset",c,1
!-230 poke6528,peek(195):poke6529,peek(196)
230 sys7022
250 a$="Lorem ipsum dolor sit amet, consectetur adipiscing elit "
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
400 poke241,c
410 sys6655:goto500
430 sys6719
440 if peek(240)<>0then300
500 getb$:ifb$=""then430
510 ifb$="q"thenstop
520 b=asc(b$):ifb<49then430
530 ifb<53thenpoke246,b-48:goto430
540 ifb<65then430
550 ifb<70thenpoke247,b-65:goto430 
560 goto430