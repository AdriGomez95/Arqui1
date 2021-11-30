include macro2.asm  
.model small
.stack 



;========================================= SEGMENTO DE DATOS =========================================
.data
    ;------------- MENSAJES DEL MENU PRINCIPAL -------------
    saludo1 db 0ah, 0dh,    '   *** ADRIANA GOMEZ - 201504236 *** ','$'
    saludo2 db 0ah, 0dh,    ' NOTA: este programa no calcula decimales','$'
    saludo3 db 0ah, 0dh,    '       y solo puedes ingresar numeros de 2 digitos','$'
    saludo4 db 0ah, 0dh,    ' EJEMPLO: 02 ','$'
    termina db 0ah, 0dh,    ' DESEA CONTINUAR? SI[1]/NO[0] -> ','$'
    msgN1 db 0ah, 0dh,      ' Ingrese un numero:  ','$'
    msgOP db 0ah, 0dh,      ' Ingrese un operador:  ','$'
    msgN2 db 0ah, 0dh,      ' Ingrese otro numero:  ','$'
    msgRESUL db 0ah, 0dh,   ' Resultado:  ','$'
    imprimenter db 0ah, 0dh, ' ','$'

    ;VARIABLES    
    u db "$$$$$$$$"         ;unidades numero 1
    d db "$$$$$$$$"         ;decenas numero 1
    numero db "$$$$$$$$"    ;numero 1 completo convertido
    u2 db "$$$$$$$$"        ;unidades numero 2
    d2 db "$$$$$$$$"        ;decenas numero 2
    numero2 db "$$$$$$$$"   ;numero 2 completo convertido
    resultado db "$$$$$$$$" 
    operador db "$$$$$$$$"
    imprimir db "$$$$$$$$"
    msgerrC db 0ah, 0dh, '  ERROR: solo se aceptan divisiones :( ','$'












;=========================================== SEGMENTO DE CODIGO =========================================
.code 

main proc
;------------------------------------------- MOSTRANDO EL MENU ------------------------------------------------
        MenuPrincipal:
            print imprimenter
            print saludo1
            print saludo2
            print saludo3
            print saludo4
            print imprimenter
        
        ModoCalculadora:
            print msgN1                             ;mensaje numero 1            
            ConversorCadenaNumero u, d, numero      ;pide el numero 1 y lo manda al conversor

            print msgOP                             ;mensaje operador aritmetico 
            mov ah, 01h                             ;pide el caracter
            int 21h                             
            mov operador, aL                        ;guarda el operador 

            print msgN2                             ;mensaje numero 2
            ConversorCadenaNumero u2, d2, numero2   ;pide el numero 2 y lo manda al conversor

            ;comparar el operador con el codigo hexa
            cmp operador, 2Fh       ;/
            je EsDiv2
            
            print imprimenter
            print msgerrC
            print imprimenter
            jmp MenuPrincipal       ;de lo contrario, vuelve al menu principal




            EsDiv2:
                mov aL, numero      ;movemos a aL el numero1
                mov bl, numero2     ;movemos a bl el numero2
                div bl              ;multiplicamos bl por el destino al

                mov resultado, aL                
                xor ax, ax          ;limpio de registro


                jmp ImprimirResultado



            ImprimirResultado:
                print msgRESUL      ;mensaje Resultado:
                xor ax, ax          ;limpio de registro
                mov aL, resultado
                CALL ConversorNumeroCadena

                print imprimenter
                print termina           ;¿DESEA CONTINUAR? SI[1]/NO[0]                
                getChar 
                cmp al, 48              ;si es 0 sale del programa, sino, continua
                je salir
            
                jmp MenuPrincipal



;------------------------------------ SALIR DEL PROGRAMA  ------------------------------------------
        salir:
            mov ah, 4ch ;numero de funcion para salir del programa
            xor aL, aL
            int 21h
    

;------------- PROCEDIMIENTO PARA CONVERTIR NUMERO A CADENA (llamada desde el modo calculadora) -------------
ConversorNumeroCadena proc 
    ;ah guarda el residuo
    ;aL guarda el cociente
    mov si, 0
    mov imprimir[si], 64        ;copia una @ a imprimir
    inc si                      ;incrementa el contador

    HacerDecimal:
        mov dh, 0ah             ;aL lo divide con dh que vale 10
        idiv dh                 ;divide dos numeros con signo
        mov imprimir[si], ah    ;copia el residuo
        inc si                  ;incrementa contador
        mov ah, 0h              ;copia 0 a ah
        cmp aL, 0h              ;compara aL con 0
        jne HacerDecimal        ;si no es igual a 0
        je comprobar            ;si es 0 el cociente comprobar

    comprobar:
        mov dl, imprimir[si]    ;copiar al dl el imprimir[si]
        cmp dl, 64              ;compara si es @
        jne imprimeDecimal      ;si no es @ imprime decimal

    imprimeDecimal:
        dec si
        mov dl, imprimir[si]
        cmp dl, 64              ;si es @ sale a mensaje de salida
        je MensajeSalida
        add dl, 30h             ;sino le agrega 30h
        mov ah, 2h              ;funcion para imprimir caracter
        int 21h
        jmp imprimeDecimal

    MensajeSalida:
        print imprimenter
    ret
ConversorNumeroCadena endp


main endp
end main