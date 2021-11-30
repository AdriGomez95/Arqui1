
         MenuPrincipal:

            ;con esto entramos al modo video
            mov ah, 0
            mov al, 03h
            int 10h
            
            
            imprimir imprimenter
            imprimir saludo1
            imprimir saludo2
            imprimir saludo3
            imprimir saludo4
            imprimir saludo5
            imprimir imprimenter
        ;------------- LEYENDO LA OPCION ELEGIDA EN EL TECLADO (del 1-5) -------------
            getChar
            ;cmp aL, 31h ;codigo ascii del 1 en hexa, nos dirige a cargar archivo
            ;je ModoLectura
            ;cmp aL, 32h ;codigo ascii del 2 en hexa, nos dirige a ordenar
            ;je ModoCalculadora
            ;cmp aL, 33h ;codigo ascii del 3 en hexa, nos dirige a generar reporte
            ;je ModoFactorial
            cmp aL, 78h ;codigo ascii de la x en hexa para salir del programa
            je salir

            print imprimenter
            jmp MenuPrincipal ;si no cumple ninguna, regresa al menu de nuevo













;------------- MACRO PARA IMPRIMIR -------------
print macro buffer
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    mov dx, offset buffer
    int 21h
endm



;------------- MACRO PARA LEER CARACTER OBTENIDO -------------
getChar macro
    mov ah, 01h 
    int 21h
    ;al registro AL se le manda el codigo ascii recibido, en codigo hexadecimal
endm



;------------- MACRO PARA LIMPIAR PANTALLA -------------
LimpiarConsola macro
    mov ax, 0600h
    mov bh, 89h
    mov cx, 0000h
    mov dx, 184Fh
    int 10h
endm



;------------- MACRO PARA LLENAR ARREGLO DEL NOMBRE DEL JUGADOR -------------
ObtenerTexto macro cadena ;macro para recibir una cadena, varios caracteres 
    LOCAL ObtenerChar, endTexto
    ;si, cx, di  registros que usualmente se usan como contadores 
        xor si,si  ; => mov si, 0  reinica el contador

        ObtenerChar:
            getChar  ;llamamos al método de obtener caracter 
            cmp al, 0dh ; como se guarda en al, comparo si al es igual a salto de línea, ascii de salto de linea en hexadecimal o 10en ascii
            je endTexto ;si es igual que el salto de línea, nos vamos a la etiqueta endTexto, donde agregamos el $ de dolar a la entrada 
            mov cadena[si],al ; mov destino, fuente.  Vamos copiando el ascii del caracter que se guardó en al, al vector cadena en la posicion del contador si
            inc si ; => si = si+1
            jmp ObtenerChar

        endTexto:
            mov al, 36 ;ascii del signo $ o en hexadecimal 24h
            mov cadena[si],al  ;copiamos el $ a la cadena
endm 





;------------- MACRO PARA IMPRIMIR EL ENCABEZADO DE LETRAS DEL TABLERO -------------
ImprimeLetrasTablero macro arr 
LOCAL whil, endwhil
push si
push di
xor si, si
mov si, 1
xor di, di

    whil:
        cmp si, 10 ;9 posiciones
        je endwhil

            mov al, arr[si]
            mov aux2, al
            print aux2

            mov aux2, 32 ;espacio en blanco
            print aux2

            inc di
            inc si
        jmp whil

    endwhil:
    print imprimenter
    mov nua, 49 ;le asigno #1 a la variable
    print nua
    mov nua, 32 ;espacio en blanco
    print nua
pop di
pop si
endm

;------------- MACRO PARA IMPRIMIR EL TABLERO -------------
ImprimeTablero macro arreglo
LOCAL mientras, finMientras, imprimirSalto, imprimirSalto1
;   si = 1
;   cx = 0
;   while( si <= 17 ){
;       print tablero[si]
;       print " "
;       si++
;       if( cx == 3 ){
;           print "\n"
;           cx = 0
;       }
;       cx++
;   }
push si
push di
xor si, si
mov si, 1
xor di, di
mov nua, 50 ;le asigno #2 a la variable

    mientras:
        cmp si, 65 ;65 posiciones
        je finMientras

            mov al, arreglo[si]
            mov aux, al
            print aux

            cmp di, 7
            je imprimirSalto

            mov aux, 32 ;espacio en blanco
            print aux

            inc di
            inc si
        jmp mientras

    imprimirSalto:
        cmp nua, 57 ;verifica que no sea 9
        je finMientras 
        jmp imprimirSalto1

    imprimirSalto1:
        xor di, di
        print imprimenter
        print nua   ;imprime el numero de fila
        inc nua     ;incrementa el numero
        mov aux, 32 ;espacio en blanco
        print aux   

        inc si
        jmp mientras

    finMientras:
        print imprimenter
pop di
pop si
endm


MacroMueveJ1 macro
LOCAL PintaJugadaJ1, PintaJugadaRJ1, MovInvalido, sale2, MensajeError, PunteaFicha, pinta, PunteaFicha2, pinta2, Mueve, Mueve1, Mueve3, Mueve5, Mueve7, Mueve10, Mueve12, Mueve14, Mueve16, Mueve17, Mueve19, Mueve21, Mueve23, Mueve26, Mueve28, Mueve30, Mueve32, Mueve33, Mueve35, Mueve37, Mueve39, Mueve42, Mueve44, Mueve46, Mueve48, Mueve49, Mueve51, Mueve53, Mueve55


        cmp al, 110 ;compara si es n
        je Mueve
        cmp al, 78  ;compara si es N
        je PintaJugadaRJ1
        jmp MensajeError

    Mueve:
        cmp si, 1h ;1 en hexa
        je Mueve1
        cmp si, 3h ;3 en hexa
        je Mueve3
        cmp si, 5h ;5 en hexa
        je Mueve5
        cmp si, 7h ;7 en hexa
        je Mueve7
        cmp si, 0Ah ;10 en hexa
        je Mueve10
        cmp si, 0Ch ;12 en hexa
        je Mueve12
        cmp si, 0Eh ;14 en hexa
        je Mueve14
        cmp si, 10h ;16 en hexa
        je Mueve16
        cmp si, 11h ;17 en hexa
        je Mueve17
        cmp si, 13h ;19 en hexa
        je Mueve19
        cmp si, 15h ;21 en hexa
        je Mueve21
        cmp si, 17h ;23 en hexa
        je Mueve23
        cmp si, 1Ah ;26 en hexa
        je Mueve26
        cmp si, 1Ch ;28 en hexa
        je Mueve28
        cmp si, 1Eh ;30 en hexa
        je Mueve30
        cmp si, 20h ;32 en hexa
        je Mueve32
        cmp si, 21h ;33 en hexa
        je Mueve33
        cmp si, 23h ;35 en hexa
        je Mueve35
        cmp si, 25h ;37 en hexa
        je Mueve37
        cmp si, 27h ;39 en hexa
        je Mueve39
        cmp si, 2Ah ;42 en hexa
        je Mueve42
        cmp si, 2Ch ;44 en hexa
        je Mueve44
        cmp si, 2Eh ;46 en hexa
        je Mueve46
        cmp si, 30h ;48 en hexa
        je Mueve48
        cmp si, 31h ;49 en hexa
        je Mueve49
        cmp si, 33h ;51 en hexa
        je Mueve51
        cmp si, 35h ;53 en hexa
        je Mueve53
        cmp si, 37h ;55 en hexa
        je Mueve55
    
    Mueve1:
        cmp di, 0Ah ;10 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
    
    Mueve3:
        cmp di, 0Ah ;10 en hexa
        je PintaJugadaJ1
        cmp di, 0Ch ;12 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
    
    Mueve5:
        cmp di, 0Ch ;12 en hexa
        je PintaJugadaJ1
        cmp di, 0Eh ;14 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
    
    Mueve7:
        cmp di, 0Eh ;14 en hexa
        je PintaJugadaJ1
        cmp di, 10h ;16 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
    
    Mueve10:
        cmp di, 11h ;17 en hexa
        je PintaJugadaJ1
        cmp di, 13h ;19 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
    
    Mueve12:
        cmp di, 13h ;19 en hexa
        je PintaJugadaJ1
        cmp di, 15h ;21 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
    
    Mueve14:
        cmp di, 15h ;21 en hexa
        je PintaJugadaJ1
        cmp di, 17h ;23 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
    
    Mueve16:
        cmp di, 17h ;23 en hexa
        je PintaJugadaJ1
        jmp MovInvalido

    Mueve17:
        cmp di, 1Ah ;26 en hexa
        je PintaJugadaJ1
        jmp MovInvalido

    Mueve19:
        cmp di, 1Ah ;26 en hexa
        je PintaJugadaJ1
        cmp di, 1Ch ;28 en hexa
        je PintaJugadaJ1
        jmp MovInvalido

    Mueve21:
        cmp di, 1Ch ;28 en hexa
        je PintaJugadaJ1
        cmp di, 1Eh ;30 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve23:
        cmp di, 1Eh ;30 en hexa
        je PintaJugadaJ1
        cmp di, 20h ;32 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve26:
        cmp di, 21h ;33 en hexa
        je PintaJugadaJ1
        cmp di, 23h ;35 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve28:
        cmp di, 23h ;35 en hexa
        je PintaJugadaJ1
        cmp di, 25h ;37 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve30:
        cmp di, 25h ;37 en hexa
        je PintaJugadaJ1
        cmp di, 27h ;39 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve32:
        cmp di, 27h ;39 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve33:
        cmp di, 2Ah ;42 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve35:
        cmp di, 2Ah ;42 en hexa
        je PintaJugadaJ1
        cmp di, 2Ch ;44 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve37:
        cmp di, 2Ch ;44 en hexa
        je PintaJugadaJ1
        cmp di, 2Eh ;46 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve39:
        cmp di, 2Eh ;46 en hexa
        je PintaJugadaJ1
        cmp di, 30h ;48 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve42:
        cmp di, 31h ;49 en hexa
        je PintaJugadaJ1
        cmp di, 33h ;51 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve44:
        cmp di, 33h ;51 en hexa
        je PintaJugadaJ1
        cmp di, 35h ;53 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve46:
        cmp di, 35h ;53 en hexa
        je PintaJugadaJ1
        cmp di, 37h ;55 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve48:
        cmp di, 37h ;55 en hexa
        je PintaJugadaJ1
        jmp MovInvalido
        
    Mueve49:
        cmp di, 3Ah ;58 en hexa
        je PintaJugadaRJ1
        jmp MovInvalido
        
    Mueve51:
        cmp di, 3Ah ;58 en hexa
        je PintaJugadaRJ1
        cmp di, 3Ch ;60 en hexa
        je PintaJugadaRJ1
        jmp MovInvalido
        
    Mueve53:
        cmp di, 3Ch ;60 en hexa
        je PintaJugadaRJ1
        cmp di, 3Eh ;62 en hexa
        je PintaJugadaRJ1
        jmp MovInvalido
        
    Mueve55:
        cmp di, 3Eh ;62 en hexa
        je PintaJugadaRJ1
        cmp di, 40h ;64 en hexa
        je PintaJugadaRJ1
        jmp MovInvalido
        


    PintaJugadaJ1:
        cmp tablero[di], 98 ;letra b
        je PunteaFicha
        cmp tablero[di], 95 ;letra _
        je pinta
        jmp sale2

    PintaJugadaRJ1:
        cmp tablero[di], 98 ;letra b
        je PunteaFicha2
        cmp tablero[di], 95 ;letra _
        je pinta2
        jmp sale2

        
    PunteaFicha:
        inc punteoJ1
        print bandera
        jmp pinta
    pinta:
        mov tablero[si], 95 ;pinta en el tablero un _
        mov tablero[di], 110 ;pinta en el tablero la ficha anterior n
        jmp sale2


    PunteaFicha2:
        inc punteoJ1
        print bandera
        jmp pinta2
    pinta2:
        mov tablero[si], 95 ;pinta en el tablero un _
        mov tablero[di], 78 ;pinta en el tablero la reina N
        jmp sale2

        
    MovInvalido:
        print imprimenter
        print MovimientoInvalido
        jmp sale2

    MensajeError:
        print imprimenter
        print MensajeOponente
        jmp sale2
        
    sale2:
endm

MacroMueveJ2 macro
LOCAL PintaJugadaJ2, PintaJugadaRJ2, MovInvalido, sale3, MensajeError, PunteaFicha, pinta, PunteaFicha2, pinta2, MueveJ2, Mueve64, Mueve62, Mueve60, Mueve58, Mueve55J, Mueve53J, Mueve51J, Mueve49J, Mueve48J, Mueve46J, Mueve44J, Mueve42J, Mueve39J, Mueve37J, Mueve35J, Mueve33J, Mueve32J, Mueve30J, Mueve28J, Mueve26J, Mueve23J, Mueve21J, Mueve19J, Mueve17J, Mueve16J, Mueve14J, Mueve12J, Mueve10J, Mueve7J, Mueve5J, Mueve3J, Mueve1J


        cmp al, 98  ;compara si es b
        je MueveJ2
        cmp al, 66  ;compara si es N
        je PintaJugadaRJ2
        jmp MensajeError

    MueveJ2:
        cmp si, 40h ;64 en hexa
        je Mueve64
        cmp si, 3Eh ;62 en hexa
        je Mueve62
        cmp si, 3Ch ;60 en hexa
        je Mueve60
        cmp si, 3Ah ;58 en hexa
        je Mueve58
        cmp si, 37h ;55 en hexa
        je Mueve55J
        cmp si, 35h ;53 en hexa
        je Mueve53J
        cmp si, 33h ;51 en hexa
        je Mueve51J
        cmp si, 31h ;49 en hexa
        je Mueve49J
        cmp si, 30h ;48 en hexa
        je Mueve48J
        cmp si, 2Eh ;46 en hexa
        je Mueve46J
        cmp si, 2Ch ;44 en hexa
        je Mueve44J
        cmp si, 2Ah ;42 en hexa
        je Mueve42J
        cmp si, 27h ;39 en hexa
        je Mueve39J
        cmp si, 25h ;37 en hexa
        je Mueve37J
        cmp si, 23h ;35 en hexa
        je Mueve35J
        cmp si, 21h ;33 en hexa
        je Mueve33J
        cmp si, 20h ;32 en hexa
        je Mueve32J        
        cmp si, 1Eh ;30 en hexa
        je Mueve30J
        cmp si, 1Ch ;28 en hexa
        je Mueve28J
        cmp si, 1Ah ;26 en hexa
        je Mueve26J
        cmp si, 17h ;23 en hexa
        je Mueve23J
        cmp si, 15h ;21 en hexa
        je Mueve21J
        cmp si, 13h ;19 en hexa
        je Mueve19J
        cmp si, 11h ;17 en hexa
        je Mueve17J        
        cmp si, 10h ;16 en hexa
        je Mueve16J
        cmp si, 0Eh ;14 en hexa
        je Mueve14J
        cmp si, 0Ch ;12 en hexa
        je Mueve12J
        cmp si, 0Ah ;10 en hexa
        je Mueve10J
        
    Mueve64:
        cmp di, 37h ;55 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve62:
        cmp di, 35h ;53 en hexa
        je PintaJugadaJ2
        cmp di, 37h ;55 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve60:
        cmp di, 33h ;51 en hexa
        je PintaJugadaJ2
        cmp di, 35h ;53 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve58:
        cmp di, 31h ;49 en hexa
        je PintaJugadaJ2
        cmp di, 33h ;51 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve55J:
        cmp di, 2Eh ;46 en hexa
        je PintaJugadaJ2
        cmp di, 30h ;48 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve53J:
        cmp di, 2Ch ;44 en hexa
        je PintaJugadaJ2
        cmp di, 2Eh ;46 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve51J:
        cmp di, 2Ah ;42 en hexa
        je PintaJugadaJ2
        cmp di, 2Ch ;44 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve49J:
        cmp di, 2Ah ;42 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve48J:
        cmp di, 27h ;39 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve46J:
        cmp di, 25h ;37 en hexa
        je PintaJugadaJ2
        cmp di, 27h ;39 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve44J:
        cmp di, 23h ;35 en hexa
        je PintaJugadaJ2
        cmp di, 25h ;37 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve42J:
        cmp di, 21h ;33 en hexa
        je PintaJugadaJ2
        cmp di, 23h ;35 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve39J:
        cmp di, 1Eh ;30 en hexa
        je PintaJugadaJ2
        cmp di, 20h ;32 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve37J:
        cmp di, 1Ch ;28 en hexa
        je PintaJugadaJ2
        cmp di, 1Eh ;30 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve35J:
        cmp di, 1Ah ;26 en hexa
        je PintaJugadaJ2
        cmp di, 1Ch ;28 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve33J:
        cmp di, 1Ah ;26 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve32J:
        cmp di, 17h ;23 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve30J:
        cmp di, 15h ;21 en hexa
        je PintaJugadaJ2
        cmp di, 17h ;23 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve28J:
        cmp di, 13h ;19 en hexa
        je PintaJugadaJ2
        cmp di, 15h ;21 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve26J:
        cmp di, 11h ;17 en hexa
        je PintaJugadaJ2
        cmp di, 13h ;19 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve23J:
        cmp di, 0Eh ;14 en hexa
        je PintaJugadaJ2
        cmp di, 10h ;16 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve21J:
        cmp di, 0Ch ;12 en hexa
        je PintaJugadaJ2
        cmp di, 0Eh ;14 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve19J:
        cmp di, 0Ah ;10 en hexa
        je PintaJugadaJ2
        cmp di, 0Ch ;12 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve17J:
        cmp di, 0Ah ;10 en hexa
        je PintaJugadaJ2
        jmp MovInvalido
        
    Mueve16J:
        cmp di, 7h ;7 en hexa
        je PintaJugadaRJ2
        jmp MovInvalido
        
    Mueve14J:
        cmp di, 5h ;5 en hexa
        je PintaJugadaRJ2
        cmp di, 7h ;7 en hexa
        je PintaJugadaRJ2
        jmp MovInvalido
        
    Mueve12J:
        cmp di, 3h ;3 en hexa
        je PintaJugadaRJ2
        cmp di, 5h ;5 en hexa
        je PintaJugadaRJ2
        jmp MovInvalido
        
    Mueve10J:
        cmp di, 1h ;1 en hexa
        je PintaJugadaRJ2
        cmp di, 3h ;3 en hexa
        je PintaJugadaRJ2
        jmp MovInvalido




    PintaJugadaJ2:
        cmp tablero[di], 110 ;letra n
        je PunteaFicha
        cmp tablero[di], 95 ;letra _
        je pinta
        jmp sale3
    PintaJugadaRJ2:
        cmp tablero[di], 110 ;letra n
        je PunteaFicha2
        cmp tablero[di], 95 ;letra _
        je pinta2
        jmp sale3

        
    PunteaFicha:
        inc punteoJ2
        print bandera2
        jmp pinta
    pinta:
        mov tablero[si], 95 ;pinta en el tablero un _
        mov tablero[di], 98 ;pinta en el tablero la ficha anterior b
        jmp sale3


    PunteaFicha2:
        inc punteoJ2
        print bandera
        jmp pinta2
    pinta2:
        mov tablero[si], 95 ;pinta en el tablero un _
        mov tablero[di], 66 ;pinta en el tablero la reina B
        jmp sale3







    MovInvalido:
        print imprimenter
        print MovimientoInvalido
        jmp sale3

    MensajeError:
        print imprimenter
        print MensajeOponente
        jmp sale3
        
    sale3:
endm





;------------- MACRO PARA RECIBIR COMANDO DEL TABLERO -------------
AnalizarComando macro comando   ;A1:B2  arreglo1 = [A][1]  arreglo2 = [B][2]
LOCAL ComparaJugadaJ1, ComparaJugadaJ2, sale

mov al, comando[0]
mov posInicial[0], al

mov al, comando[1]
mov posInicial[1], al

mov al, comando[3]
mov posFinal[0], al

mov al, comando[4]
mov posFinal[1], al

ConvierteCoordenada posInicial  ;convierte la coordenada y la guarda en al
xor si, si 
mov si, ax ;ax tiene al y ah

ConvierteCoordenada posFinal    
xor di, di
mov di, ax ;ax tiene al y ah


;aqui validar todos los movimientos

xor ax, ax
mov al, tablero[si]
cmp juegaJ1, 49
je  ComparaJugadaJ1
cmp juegaJ2, 49
je  ComparaJugadaJ2


    ComparaJugadaJ1:
        MacroMueveJ1
        jmp sale

    ComparaJugadaJ2:
        MacroMueveJ2
        jmp sale


    ;ComparaJugadaJ2:
    ;    cmp al, 98  ;compara si es b
    ;    je PintaJugadaJ2

    ;PintaJugadaJ2:
    ;    mov tablero[si], 95 ;pinta en el tablero un _
    ;    mov tablero[di], al ;pinta en el tablero la ficha anterior
    ;    jmp sale



    sale:
endm






;------------- MACROS PARA CONVERTIR LA COORDENADA INGRESADA -------------
ConvierteCoordenada macro coordenada
; A1 -> (Valor letras) + (n-1)*8
; columna = valor letras
; fila = n
; (columna) + (fila-1)*8

mov al, coordenada[0]   ;al = A (valor ascii de A = 65)
mov columna, al
ConvierteColumna columna

mov al, coordenada[1]   ;al = n (1 segun el ejemplo A1, ascii de 1 = 49)
mov fila, al
ConvierteFila fila 

xor ax, ax
xor bx, bx
mov al, fila ;fila-1
SUB al, 1
mov bl, 8
MUL bl      ;al = (fila-1)*8

xor bx, bx
mov bl, columna
ADD al, bl  ;al = (columna)+(fila-1)*8
endm


ConvierteColumna macro valor ;valor = valor - 64
mov al, valor
sub al, 64
mov valor, al 
endm


ConvierteFila macro valor ;valor = valor - 48
mov al, valor
sub al, 48
mov valor, al 
endm












;------------- MACROS PARA LIMPIAR EL ARREGLO CON $ -------------
limpiar macro buffer, numbytes, caracter
LOCAL Repetir
	xor si,si ; colocamos en 0 el contador si
	xor cx,cx ; colocamos en 0 el contador cx
	mov	cx,numbytes ;le pasamos a cx el tamaño del arreglo a limpiar 

	Repetir:
		mov buffer[si], caracter ;le asigno el caracter que le estoy mandando 
		inc si ;incremento si = si++;
		Loop Repetir ;se va a repetir hasta que cx sea 0 
endm

obtenerTexto2 macro buffer
LOCAL ObtenerChar, endTexto
	xor si,si ; xor si,si =	mov si,0
	
	ObtenerChar:
		getChar
		cmp al,0dh ; ascii de salto de linea en hexa
		je endTexto
		mov buffer[si],al ;mov destino, fuente
		inc si ; si = si + 1
		jmp ObtenerChar

	endTexto:
		mov al,24h ; asci del signo dolar $
		mov buffer[si], al  
endm

obtenerRuta macro buffer
LOCAL ObtenerChar, endTexto
	xor si,si ; xor si,si =	mov si,0
	
	ObtenerChar:
		getChar
		cmp al,0dh ; ascii de salto de linea en hexa
		je endTexto
		mov buffer[si],al ;mov destino, fuente
		inc si ; si = si + 1
		jmp ObtenerChar

	endTexto:
		mov al,00h ; asci del caracter nulo
		mov buffer[si], al  
endm

abrir macro buffer,handler

	mov ah,3dh ;funcion para abrir fichero 
	mov al,02h ;010b Acceso de lectura/escritura. 010b 
	lea dx,buffer ;carga la dirección de la fuente (buffer) a dx 
	int 21h ;ejecutamos la interrupción 
	jc Error1 ;salta si el flag de acarreo = 1
	mov handler,ax ;sino hay error  en ax devuelve un handle para acceder al fichero 

endm

cerrar macro handler
	
	mov ah,3eh
	mov bx, handler
	int 21h
	jc Error2
	mov handler,ax

endm

leer macro handler,buffer, numbytes
	
	mov ah,3fh ;interrupción para leer 
	mov bx,handler ;copiamos en bx el handler,referencia al fichero
	mov cx,numbytes ;numero de bytes a leer, tamaño del arreglo que guarda el contenido 
	lea dx,buffer ;carga la dirección de la variable buffer a dx
	int 21h
	jc  Error5
	;en el buffer se guarda la información

endm

crear macro buffer, handler
	
	mov ah,3ch ;función para crear fichero
	mov cx,00h ;fichero normal 
	lea dx,buffer ;carga la dirección de la variable buffer a dx
	int 21h
	jc Error4
	mov handler, ax ;sino hubo error nos devuelve el handler 

endm

escribir macro handler, buffer, numbytes

	mov ah, 40h ;función de escritura del archivo 
	mov bx, handler ;en bx copiamos el handler, 
	mov cx, numbytes ;numero de bytes a escribir 
	sub cx, 1 
	lea dx, buffer ;carga la dirección de la variable buffer a dx
	int 21h ;ejecutamos la interrupción 
	jc Error3

endm





