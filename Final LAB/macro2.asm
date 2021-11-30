



;------------- MACRO PARA IMPRIMIR EN PANTALLA -------------
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



;------------- MACRO PARA CONVERTIR CADENA A NUMERO -------------
ConversorCadenaNumero macro d, u, numero
    mov ah, 01h         ;primer caracter
    int 21h
    sub aL, 30h         ;convierte de hexa a decimal
    ;cmp aL, 2Dh
    mov d, aL           ;guarda aL en decenas

    mov ah, 01h         ;segundo caracter
    int 21h
    sub aL, 30h         ;convierte de hexa a decimal
    mov u, aL           ;guarda aL en unidades

    mov aL, d           ;copia a aL las decenas
    mov bl, 0ah         ;copia a bl el 10 en hexa

    mul bl              ;el resultado de la mul. se queda en la parte alta
    add aL, u           ;se suman las unidades a aL para obtener el numero completo
    mov numero, aL      ;guarda el numero completo en la variable
endm
