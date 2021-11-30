


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







imprimir macro buffer
push ax
push dx

    ;esto para imprimir una palabra en modo video
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    mov dx, offset buffer
    int 21h

pop dx
pop ax
endm



;------------- MACRO PARA ESCRIBIR UN VALOR DIRECTO -------------
escribirChar macro char 
    mov ah, 02h
    mov dl, char
    int 21h
endm



;------------- MACRO PARA POSICIONAR CURSOR -------------
posicionarCursor macro x, y 
    mov ah, 02h
    mov dh, x
    mov dl, y
    mov bh, 0
    int 10h
endm



;------------- MACRO PARA IMPRIMIR MODO VIDEO -------------
imprimirVideo macro caracter, color 
    mov ah, 09h
    mov al, caracter   ;al guarda el valor que vamos a escribir
    mov bh, 0           ;posicion actual es la 0
    mov bl, color       ;pinta rojo (b de binario)
            
    mov cx, 1
    int 10h
endm




;------------- MACRO PARA DIPTONGOS -------------
esDiptongo macro caracter1, caracter2 
LOCAL salida, esA, esE, esO, Diptongo, esII, esU
;en el registro al va a tener un 1 si es diptongo o un 0 si no lo es 
    mov al, 0

    esA:
        cmp caracter1, 97   ;letra a
        jne esE

        cmp caracter2, 105  ;letra i
        je Diptongo
        cmp caracter2, 117  ;letra u
        je Diptongo
        jmp salida

    esE:
        cmp caracter1, 101  ;letra e
        jne esO

        cmp caracter2, 105  ;letra i
        je Diptongo
        cmp caracter2, 117  ;letra u
        je Diptongo
        jmp salida

    esO:
        cmp caracter1, 111  ;letra o
        jne esII

        cmp caracter2, 105  ;letra i
        je Diptongo
        cmp caracter2, 117  ;letra u
        je Diptongo
        jmp salida

    esII:
        cmp caracter1, 105  ;letra i
        jne esU

        cmp caracter2, 97   ;letra a
        je Diptongo
        cmp caracter2, 101  ;letra e
        je Diptongo
        cmp caracter2, 111  ;letra o
        je Diptongo
        cmp caracter2, 117  ;letra u
        je Diptongo
        jmp salida

    esU:
        cmp caracter1, 117  ;letra u
        jne salida

        cmp caracter2, 97   ;letra a
        je Diptongo
        cmp caracter2, 101  ;letra e
        je Diptongo
        cmp caracter2, 105  ;letra i
        je Diptongo
        cmp caracter2, 111  ;letra o
        je Diptongo
        jmp salida



    Diptongo:
       ; inc contadorDip  ;***************************************************************************************
        mov di, contadorDip
        inc di
        mov contadorDip, di 
        mov al, 1 

    jmp salida

    salida:
endm




;------------- MACRO PARA HIATOS -------------
esHiato macro caracter1, caracter2 
LOCAL salida, esA, esE, esO, Hiato, esII, esU
;auxHiato va a tener un 1 si es hiato o un 0 si no lo es 
    mov auxHiato, 0

    esA:
        cmp caracter1, 97   ;letra a
        jne esE

        cmp caracter2, 97   ;letra a
        je Hiato
        cmp caracter2, 101  ;letra e
        je Hiato
        cmp caracter2, 111  ;letra o
        je Hiato
        jmp salida

    esE:
        cmp caracter1, 101  ;letra e
        jne esO

        cmp caracter2, 97   ;letra a
        je Hiato
        cmp caracter2, 101  ;letra e
        je Hiato
        cmp caracter2, 111  ;letra o
        je Hiato
        jmp salida

    esO:
        cmp caracter1, 111  ;letra o
        jne esII

        cmp caracter2, 97   ;letra a
        je Hiato
        cmp caracter2, 101  ;letra e
        je Hiato
        cmp caracter2, 111  ;letra o
        je Hiato
        jmp salida

    esII:
        cmp caracter1, 105  ;letra i
        jne esU

        cmp caracter2, 105  ;letra i
        je Hiato
        jmp salida

    esU:
        cmp caracter1, 117  ;letra u
        jne salida

        cmp caracter2, 117  ;letra u
        je Hiato
        jmp salida



    Hiato:
        mov di, contadorHia
        inc di
        mov contadorHia, di
        mov auxHiato, 1

    jmp salida

    salida:
endm




;------------- MACRO PARA TRIPTONGOS -------------
esTriptongo macro caracter1, caracter2, caracter3 
LOCAL salida, esA, esE, esO, Triptongo, esII, esU
;auxTriptongo va a tener un 1 si es triptongo o un 0 si no lo es 
    mov auxTriptongo, 0


    esII:
        cmp caracter1, 105  ;letra i
        jne esU

        cmp caracter2, 97   ;letra a
        je esA
        cmp caracter2, 101  ;letra e
        je esE
        cmp caracter2, 111  ;letra o
        je esO
        jmp salida

    esU:
        cmp caracter1, 117  ;letra u
        jne salida

        cmp caracter2, 97   ;letra a
        je esA
        cmp caracter2, 101  ;letra e
        je esE
        jmp salida



    esA:
        cmp caracter2, 97   ;letra a
        jne esE

        cmp caracter3, 105  ;letra i
        je Triptongo
        cmp caracter3, 117  ;letra u
        je Triptongo
        jmp salida

    esE:
        cmp caracter2, 101  ;letra e
        jne esO

        cmp caracter3, 105  ;letra i
        je Triptongo
        cmp caracter3, 117  ;letra u
        je Triptongo
        jmp salida

    esO:
        cmp caracter2, 111  ;letra o
        jne salida

        cmp caracter3, 105  ;letra i
        je Triptongo
        jmp salida



    Triptongo:
        mov di, contadorTrip
        inc di
        mov contadorTrip, di
        mov auxTriptongo, 1

    jmp salida

    salida:
endm








;------------- MACRO PARA LLENAR ARREGLO DEL COMANDO INGRESADO EN EL MENU PRINCIPAL -------------
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











IntToString macro num, number ; ax 1111 1111 1111 1111 -> 65535
LOCAL Inicio,Final,Mientras,MientrasN,Cero,InicioN
    push si
    push di
    Limpiar number,SIZEOF number,24h  ; '$'
    mov ax,num ; ax = numero entero a convertir 23
    cmp ax,0 
    je Cero
    xor di,di
    xor si,si
    jmp Inicio

    ;ax = 123

    Inicio:
        
        cmp ax,0 ;ax = 0
        je Mientras
        mov dx,0 
        mov cx,10 
        div cx ; 1/10 = ax = 0 dx = 2
        mov bx,dx 
        add bx,30h ; 1 + 48 = ascii 
        push bx 
        inc di	; di = 3
        jmp Inicio

    Mientras:
        ;si = 0 , di = 3
        cmp si,di 
        je Final
        pop bx 
        mov number[si],bl 
        inc si 
        ;si = 2 di = 3
        jmp Mientras

    Cero:
    mov number[0],30h
    jmp Final

    Final:
    pop di
    pop si
endm






;****************************************************************************************************
;****************************************************************************************************
;**************** MACROS PARA LA LECTURA Y ABIERTA DE ARCHIVOS EN LA RUTA INDICADA ******************
;****************************************************************************************************
;****************************************************************************************************








;------------- MACRO PARA LIMPIAR EL ARREGLO -------------
;en el macro limpiar vamos a limpiar el arreglo con $
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


leer macro handler,buffer, numbytes
	
	mov ah,3fh ;interrupción para leer 
	mov bx,handler ;copiamos en bx el handler,referencia al fichero
	mov cx,numbytes ;numero de bytes a leer, tamaño del arreglo que guarda el contenido 
	lea dx,buffer ;carga la dirección de la variable buffer a dx
	int 21h
	jc  Error5
	;en el buffer se guarda la información

endm


cerrar macro handler
	
	mov ah,3eh
	mov bx, handler
	int 21h
	jc Error2
	mov handler,ax

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