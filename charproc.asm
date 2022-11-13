


target TGT_PETBV2    

export loadnewchar
export nexpixchr

; CONSTANTES
conbit=8       ; 8 pixels por byte
ifdef TGT_PETBV2
stride=40  ; ancho pantalla
mempan = $8000  ;
tiempoajuste=10000
;tiempoajuste=13333
tiempopframe=16666
;tiempoajuste=16000
;tiempopframe=20000
endif
ifdef TGT_VIC20
stride=25  ; ancho pantalla
mempan = $1C00 ;
vic=$9000
datvid=127 ; 254
endif
copiacar=$1FF0 ;

stride1=stride-1  ; ancho pantalla
; Direcciones
ifdef TGT_PETBV2
TIMERLOW=$E844 ; si timer 1, E848 si timer 2
TIMERHIGH=$E845 ; si timer 1, E849 si timer 2
VIAACR=$E84B
VIAIFR=$E84D
VIAIER=$E84E

IRQBASV1=$219
IRQBASV2=$90
banraster=$EF

endif


; PET seguras $A2, $ED a $F7, $FF not used
; PET quiza
;     temporales $54 - $5D, $5E - $63, $66 - $6B
; VIC seguras    $FB - $FE, $00 - $06
;     temporales $57 - $60, $61 - $66, $69 - $6E

; CONTROL
; conrephor         1    2    3    4
; columnas x char   4    8   12   16 
; conrepver         1    2    3    4
; filas x char      8   12   16   20 

ifdef TGT_PETBV2
conrephor=$F6       ; el pixel horizontal se repetira 1, 2, 3 o 4 veces
conrepver=$F7
endif
ifdef TGT_VIC20
conrephor=$FD ; puntero al grafico
conrepver=$FE
endif

; ES DE CONTROL DESDE BASIC PERO ES TEMPORAL DESDE ASEMBLER x ESO REHUTILICIAR
ifdef TGT_PETBV2
banfincha=$F0
copachar=$F1        ; codigo pantalla caracter
endif
ifdef TGT_VIC20
banfincha=$00
copachar=$01        ; codigo pantalla caracter
endif

; ESTADO
ifdef TGT_PETBV2
; persistente
indconbit=$F2
indconrephor=$F3
endif
ifdef TGT_VIC20
; persistente
indconbit=$02
indconrephor=$03
endif

; PUNTEROS
ifdef TGT_PETBV2
; persistente
pungra=$F4 ; puntero al grafico
; temporales
punpix2=$55
puncha2=$57
punpix1=$59
; punteros
punscrn1=$5B
endif
ifdef TGT_VIC20
; persistente
pungra=$FB ; puntero al grafico
; temporales
punpix2=$58
puncha2=$5A
punpix1=$5C
; punteros
punscrn1=$5E
endif

puncha3=puncha2


; LOCALES
ifdef TGT_PETBV2
conbyte=$5D
indfila=$5D
confilas=$5E
numfila=$5F
endif
ifdef TGT_VIC20
conbyte=$60
indfila=$60
confilas=$61
numfila=$62
endif



mempan0=mempan
mempan1=mempan0+stride
mempan2=mempan1+stride
mempan3=mempan2+stride
mempan4=mempan3+stride
mempan5=mempan4+stride
mempan6=mempan5+stride
mempan7=mempan6+stride
mempan8=mempan7+stride
mempan9=mempan8+stride
mempan10=mempan9+stride
mempan11=mempan10+stride
mempan12=mempan11+stride
mempan13=mempan12+stride
mempan14=mempan13+stride
mempan15=mempan14+stride
mempan16=mempan15+stride
mempan17=mempan16+stride
mempan18=mempan17+stride
mempan19=mempan18+stride
mempan20=mempan19+stride
mempan21=mempan20+stride
mempan22=mempan21+stride
mempan23=mempan22+stride
mempan24=mempan23+stride


*=$1960 ; 6496

ifdef TGT_PETBV2
bacharset word $1100
adfidain word $1C50 
endifload
ifdef TGT_VIC20
bacharset word $8800 
adfidain word $1740 
endif

;
; TABLAS

; CODIGOS PESCI
;                00   01   10   11
tabcodcarme byte 32, 225,  97, 160
;                00   00   00   00   01   01   01   01   10   10   10   10   11   11   11   11   
;                00   01   10   11   00   01   10   11   00   01   10   11   00   01   10   11   
;                0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111
tabcodcarcu byte  32, 108, 123,  98, 124, 225, 255, 254, 126, 127,  97, 252, 226, 251, 236, 160

;; punteros filas datos intermedios
;tapufidainlo byte <fidain0, <fidain1, <fidain2, <fidain3, <fidain4, <fidain5, <fidain6, <fidain7

;; punteros filas datos caracteres graficos medios
;tapuficamelo byte <fidame0, <fidame1, <fidame2, <fidame3, <fidame4, <fidame5, <fidame6, <fidame7

;; punteros filas datos intermedios
;tapufidainhi byte >fidain0, >fidain1, >fidain2, >fidain3, >fidain4, >fidain5, >fidain6, >fidain7

;; punteros filas datos caracteres graficos medios
;tapuficamehi byte >fidame0, >fidame1, >fidame2, >fidame3, >fidame4, >fidame5, >fidame6, >fidame7

; punteros filas datos intermedios (low)
tapufidainlo bytes 8 ; de 1700 a 17C7

; punteros filas de caracteres graficos rectangulitos (low)
tapuficamelo bytes 8 ; de 17C8 a 188F

; punteros filas de caracteres graficos cuadritos (low)
tapuficaculo bytes 4 ; de 1890 a 18F3

; punteros filas datos intermedios (high)
tapufidainhi bytes 8

; punteros filas de caracteres graficos rectangulitos (high)
tapuficamehi bytes 8

; punteros filas de caracteres graficos cuadritos (high)
tapuficacuhi bytes 4


; esto son 20*stride bytes 800 en PET y 500 en VIC parte pordira estar en el bufer caset?
; o al menos fuera de lo que carga


; visualizacion

; x 0 filas 21-24, bloque 8,9,10,11
; x 1 filas  6-13, bloque 0,1,2,3,4,5,6,7
; x 2 filas  4-15, bloque 0,8,1,2,9,3,4,10,5,6,11,7
; x 3 filas  2-17, bloque 0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7
; x 4 filas  0-19, bloque 0,0,8,1,1,2,2,9,3,3,4,4,10,5,5,6,6,11,7,7
;tabconfilas byte 8, 12, 16, 20
;tabindfilas byte 0, 8, 20, 36
;tabfilainic byte 6, 4, 2, 0 

;tabindfilacha byte 0,1,2,3,4,5,6,7, 0,8,1,2,9,3,4,10,5,6,11,7, 0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7, 0,0,8,1,1,2,2,9,3,3,4,4,10,5,5,6,6,11,7,7

tabconfilas byte 8, 12, 16, 20, 24
tabindfilas byte 0, 8, 20, 36, 56
tabfilainic byte 8, 6, 4, 2, 0 
tabindfilacha byte 0,1,2,3,4,5,6,7, 0,8,1,2,9,3,4,10,5,6,11,7, 0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7, 0,0,8,1,1,2,2,9,3,3,4,4,10,5,5,6,6,11,7,7, 0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7

; CODIGO

loadnewchar ; load new char pointer, init bit counter
; calcular puntero al grafico del caracter, inicializar contador bits
calcpunchar
        lda copachar
        asl
        rol pungra+1
        asl
        rol pungra+1
        asl
        rol pungra+1
        clc
        adc bacharset
        sta pungra
        lda pungra+1
        and #7
        adc bacharset+1
        sta pungra+1

        ldy #0
        sty banfincha
@copcar
        lda (pungra),y
        sta copiacar,y
        iny
        cpy #8                  ; copiar 8 bytes
        bne @copcar
        sty indconbit           ; restablecer copiar 8 bits


        ldy #0
@scrola lda mempan24+1,y 
        sta mempan24,y
        iny
        cpy #stride1
        bne @scrola
        lda copachar
        sta mempan24+stride1

        ldx #0
        bpl calcodchar          ; BRA

nexpixchr ; 1A3F check next and get pixel column in char
; comprobar que la columna de pixels no fue la ultima del caracter
; el pixel horizontal se repetira 1,2,3 o 4 veces
; cuando toque desplayar los bytes del char se activa la bandera banfinpix
; esta bandera se limpia aqui mismo
        ldx #0
        dec indconbit
        bne @fincha
; cuando haya hecho ultimo bit salir y requerir otro caracter
        inc banfincha
        rts
@fincha
;        ldy conrephor
; aqui empieza a procesar caracteres
@finpix

; recuperar columna de pixels y pasarla al espacio intermedio
calcodchar
; aqui visualizar
ifdef TGT_VIC20
        lda datvid
@waxca1 cmp vic+4
        bcc @waxca1
endif
ifdef TGT_PETBV2
@waitra lda $E840
        and #$20
        bne @waitra
;@waitra lda banraster
;        beq @waitra
;        lda #$0
;        sta banraster
endif
        lda #<mempan ; tabpunscrnlo,y
        sta punscrn1
        lda #>mempan ; tabpunscrnhi,y
        sta punscrn1+1

        ldy conrepver
; provisu
        lda tabconfilas,y       ; 8, 12, 16, 20
        sta confilas
        lda tabindfilas,y       ; 4, 12, 24, 40
        sta indfila

        ldx tabfilainic,y       ; 6, 4, 2, 0
        beq @txtext
; tercio superior
        jsr delrows

; tercio letras
@txtext
        ldy indfila
        ldx tabindfilacha,y
        lda tapuficamelo,x
        sta puncha2
        lda tapuficamehi,x
        sta puncha2+1

        ldy #stride1
@txtint
        lda (puncha2),y
        sta (punscrn1),y
        dey
        bpl @txtint
;addpsc1 clc
        lda #stride
        clc
        adc punscrn1
        sta punscrn1
;        sta puncol 
        bcc @txtove          ; salta si CC comprobacion byte HI
        inc punscrn1+1
@txtove 
        inc indfila
        dec confilas
        bne @txtext

        lda #24
        ldy conrepver
        sec
        sbc tabconfilas,y       ; 8, 12, 16, 20
        sbc tabfilainic,y       ; 6, 4, 2, 0
        tax
        beq @finvis
; tercio inferior
        jsr delrows


@finvis

        ldy conrephor
@burege
        dey
        sty indconrephor

; aqui desplaza las filas con pixels de medio caracter
        ldy #7
@buexin sty conbyte
        lda tapufidainlo,y
        sta punpix2
        lda tapufidainhi,y
        sta punpix2+1
        lda copiacar,y
        asl
        ldx indconrephor
        bne @finpix
        sta copiacar,y
@finpix
        ldy #stride1
@buinin
        lda (punpix2),y
        rol 
        cmp #4    ; 2 bits por byte
        bcc @nexbit
        sbc #4    ; quitar el bit 2 pero dejar CS
@nexbit sta (punpix2),y
        dey
        bpl @buinin
        ldy conbyte
        dey
        bpl @buexin

; procesar filas graficos
; aqui calcula caracteres de las 8 filas con pixels de medio caracter
        ldx #8
@buexme
        stx conbyte
        lda tapufidainlo-1,x
        sta punpix2
        lda tapufidainhi-1,x
        sta punpix2+1
        lda tapuficamelo-1,x
        sta puncha2
        lda tapuficamehi-1,x
        sta puncha2+1

        ldy #stride1
@buinme
        lda (punpix2),y
        tax
        lda tabcodcarme,x
        sta (puncha2),y
        dey
        bpl @buinme
        ldx conbyte
        dex
        bne @buexme

; aqui calcula las 4 filas con pixels de un cuarto de caracter
        ldx #4
@buexcu
        stx conbyte
        txa
        asl
        tay
        jsr copipun1


        ldy #stride1
@buincu
        lda (punpix1),y
        asl
        asl
        ora (punpix2),y
        tax
        lda tabcodcarcu,x
        sta (puncha3),y
        dey
        bpl @buincu
        ldx conbyte
        dex
        bne @buexcu
        ldy indconrephor
        bne @burege
        rts

copipun1
        lda tapufidainlo-2,y
        sta punpix1
        lda tapufidainhi-2,y
        sta punpix1+1
        lda tapuficaculo-1,x
        sta puncha3
        lda tapuficacuhi-1,x
        sta puncha3+1
;copipun2
        lda tapufidainlo-1,y
        sta punpix2
        lda tapufidainhi-1,y
        sta punpix2+1
        rts

; reg.X numero filas a borrar
delrows
; tercio inferior
@higext
        lda #32
        ldy #stride1
@higint
        sta (punscrn1),y
        dey
        bpl @higint
        lda #stride
        clc
        adc punscrn1
        sta punscrn1
;        sta puncol 
        bcc @higbyo          ; salta si CC comprobacion byte HI
        inc punscrn1+1
@higbyo 
        dex
        bne @higext
        rts


*=$1B6E

initpet 

; filltab
        ldy #0
        lda adfidain+1
        sta pungra+1
        lda adfidain
        sta pungra

@nexdir sty conbyte
        lda #0
        ldy #stride1
@bufill sta (pungra),y
        dey
        bpl @bufill

        ldy conbyte
        lda pungra+1
        tax
        sta tapufidainhi,y
        lda pungra
        sta tapufidainlo,y
        clc
        adc #stride        ; ancho columnas
        bcc @inbyhi
        inx
@inbyhi
        stx pungra+1
        sta pungra
        iny
        cpy #20
        bne @nexdir
; inicializar conrepver, conrephor, 
        ldx #1
        stx conrepver
        inx
        stx conrephor
;        rts

; cambiar irq
        sei
        ldx #<interup1
        ldy #>interup1
        lda IRQBASV2+1
        cmp #$E0
        bcc @basic1
        sta oldirq+1
        lda IRQBASV2
        sta oldirq
        stx IRQBASV2
        sty IRQBASV2+1
        bcs @verbas
@basic1
        lda IRQBASV1+1
        sta oldirq+1
        lda IRQBASV1
        sta oldirq
        stx IRQBASV1
        sty IRQBASV1+1
@verbas cli
        rts

interup1
; sincronizar con VBLANK para arrancar retraso
        lda $E840
        and #$20
        bne @salida
        lda #%00000000 ; TIMER 1 ONE SHOT
        sta VIAACR
        ldx #>tiempoajuste
        lda #<tiempoajuste
        sta TIMERLOW
        stx TIMERHIGH
        lda #%11000000 ; ENABLE TIMER1
        sta VIAIER
;        sei
        ldx #<interup2
        ldy #>interup2
        jsr auxinterup
;        lda oldirq+1
;        cmp #$E0
;        bcc @basic1
;        stx IRQBASV2
;        sty IRQBASV2+1
;        bcs @verbas
;@basic1
;        stx IRQBASV1
;        sty IRQBASV1+1
;@verbas 
;        cli
@salida 
        jmp (oldirq)

interup2
        bit VIAIFR
        bvs @inter1 ; deberia pasar siempre qe esta interrupcionantes del siginete blank
        jmp (oldirq)
@inter1
        lda #%01000000 ; TIMER 1 CONTINUOUS
        sta VIAACR
        ldx #>tiempopframe
        lda #<tiempopframe
        sta TIMERLOW
        stx TIMERHIGH
;        sei
        ldx #<interup3
        ldy #>interup3
        jsr auxinterup
;        lda oldirq+1
;        cmp #$E0
;        bcc @basic1
;        stx IRQBASV2
;        sty IRQBASV2+1
;        bcs @verbas
;@basic1
;        stx IRQBASV1
;        sty IRQBASV1+1
;@verbas 
;        cli
        jmp salinter

interup3 
        bit VIAIFR
        bvs @inter3
;        lda VIAIFR
;        and #$40
;        bne @inter3
        jmp (oldirq)
@inter3
        lda TIMERLOW
        inc banraster
salinter
        pla
        tay
        pla
        tax
        pla
        rti

auxinterup
        sei
        lda oldirq+1
        cmp #$E0
        bcc @basic1
        stx IRQBASV2
        sty IRQBASV2+1
        bcs @verbas
@basic1
        stx IRQBASV1
        sty IRQBASV1+1
@verbas 
        cli
        rts

oldirq bytes 2