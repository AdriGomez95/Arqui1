include macro4.asm  ;incluimos la macro
.model small
.stack 



;========================================= SEGMENTO DE DATOS =========================================
.data


    ;------------- MENSAJES DEL MENU PRINCIPAL -------------
    saludo1 db 0ah, 0dh, '   UNIVERSIDAD DE SAN CARLOS DE GUATEMALA ','$'
    saludo2 db 0ah, 0dh, '   ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 B','$'
    saludo3 db 0ah, 0dh, '   Adriana Marie Gomez Davila 201504236','$'
    saludo4 db 0ah, 0dh, '   Practica 4','$'
    saludo5 db 0ah, 0dh, '>> INGRESE x SI DESEA CERRAR EL PROGRAMA','$'
    imprimenter db 0ah, 0dh, ' ','$'
    err db 0ah, 0dh, '*** ERROR COMANDO NO IDENTIFICADO ***','$'

    ;texto db "diptongos -> ai au ei eu oi ou / ia ie io ua ue uo / iu ui", "$"
    ;texto db "hiatos -> aa ae ao / ea eo ee / ii / oo oa oe / uu ", "$"
    ;texto db "triptongos -> iai iau iei ieu ioi / uai uau uei", "$"
    ;hola adriana (verde)diptongos -> ai au ei eu oi ou / ia ie io ua ue uo / iu ui       (rojo)hiatos -> aa ae ao / ea eo ee / ii / oo oa oe / uu                        (amarillo)triptongos -> iai iau iei ieu ioi / uai uau uei
    
    texto db "diptongos -> ai au ei eu oi ou / ia ie io ua ue uo / iu ui          verde       hiatos -> aa ae ao / ea eo ee / ii / oo oa oe / uu                  rojo        triptongos -> iai iau iei ieu ioi / uai uau uei                     amarillo", "$"

    saludo db 0ah, 0dh, 'Analizando texto...','$'
    fin db 0ah, 0dh, 'Finalizando el programa...','$'



    ;------------- MENSAJES Y VARIABLES PARA ABRIR RUTA DE ARCHIVO -------------
    bufferentrada db 500 dup('$')
    handlerentrada dw ?
    bufferInformacion db 500 dup('$')
    ingreseruta db 0ah,0dh, 'Ingrese una ruta de archivo' , 0ah,0dh, 'Ejemplo: entrada.txt' , '$'
    enc2 db 0ah,0dh, '1.) Mostrar informacion' , 0ah,0dh, '2.) Cerrar archivo' , '$'
    op db 0ah,0dh, 'Elija una opcion:' , '$'
    err1 db 0ah,0dh, 'Error al abrir el archivo puede que no exista' , '$'
    err2 db 0ah,0dh, 'Error al cerrar el archivo' , '$'
    err3 db 0ah,0dh, 'Error al escribir en el archivo' , '$'
    err4 db 0ah,0dh, 'Error al crear en el archivo' , '$'
    err5 db 0ah,0dh, 'Error al leer en el archivo' , '$'
    E1 db 0ah,0dh, '*************************************************************************************************' , '$'
    E2 db 0ah,0dh, '*****************************************    REPORTE    *****************************************' , '$'
    E3 db 0ah,0dh, '------> CONTADORES:' , '$'




    ;------------- VARIABLES DEL MODO MEMORIA PARA PINTAR PALABRAS -------------
    fila db 0
    columna db 0
    auxHiato db 0, '$'      ;auxiliar para saber si es hiato
    auxTriptongo db 0, '$'  ;auxiliar para saber si es triptongo



    ;------------- CONTADORES PARA CONTAR EL TIPO DE PALABRA SEGUN EL COMANDO -------------
    arregloComando db 20 dup('$'), '$'   ;arreglo que recibira el comando 
    contadorDip dw 0   
    contadorHia dw 0
    contadorTrip dw 0
    cont dw 0, '$'
    t1 db 0ah, 0dh, ' Total de diptongos: ','$'
    t2 db 0ah, 0dh, ' Total de hiatos: ','$'
    t3 db 0ah, 0dh, ' Total de triptongos: ','$'    
    Cantidades db 5 dup('$'),('$')   



    ;------------- CONTADORES PARA CONTAR LA MEDIA DE CADA TIPO -------------
    mediaDip dw 0   
    mediaHia dw 0
    mediaTrip dw 0
    palabrasTotales dw 0
    palabrasTotales2 db 0, '$'      ;auxiliar para saber si es hiato
    palabrasTotales3 db 0, '$'      ;auxiliar para saber si es hiato
    m11 db 0ah, 0dh, ' Total de palabras: ','$'
    m1 db 0ah, 0dh, ' Media de diptongos: ','$'
    m2 db 0ah, 0dh, ' Media de hiatos: ','$'
    m3 db 0ah, 0dh, ' Media de triptongos: ','$'    








;=========================================== SEGMENTO DE CODIGO =========================================
.code 
main proc

        Inicio:
            xor si, si
            xor di, di
            print imprimenter
            print saludo1
            print saludo2
            print saludo3
            print saludo4
            print imprimenter
            print saludo5
            print imprimenter

		    ObtenerTexto arregloComando
            cmp arregloComando[0], 120   ;si es x
            je salir
            cmp arregloComando[0], 99   ;si es c
            je Ce
            cmp arregloComando[0], 97   ;si es a
            je AbrirArchivo
            cmp arregloComando[0], 112  ;si es p
            je Pe
            cmp arregloComando[0], 114  ;si es r
            je Reporte
            jmp Error
        
        Pe:
            cmp arregloComando[5], 100  ;si es d
            je CalculaMediaDip
            cmp arregloComando[5], 104  ;si es h
            je CalculaMediaHia
            cmp arregloComando[5], 116  ;si es t
            je CalculaMediaTrip
            jmp Error

        Ce:
            cmp arregloComando[6], 97   ;si es a -> colorear
            je comColorear
            cmp arregloComando[6], 95   ;si es _ -> contar_d|h|t
            je comContar
            jmp Error



;------------------------------------------- COMANDO "REPORTE" ------------------------------------------------
        Reporte:
            print imprimenter
            print ingreseruta
            print imprimenter
            limpiar bufferentrada, SIZEOF bufferentrada,24h
            obtenerRuta bufferentrada
            crear bufferentrada, handlerentrada
            jmp EscribirArchivo

        EscribirArchivo:
            print imprimenter
            limpiar bufferInformacion, SIZEOF bufferInformacion,24h
            escribir  handlerentrada, E1, SIZEOF E1
            escribir  handlerentrada, E2, SIZEOF E2
            escribir  handlerentrada, E3, SIZEOF E3

            escribir  handlerentrada, m11, SIZEOF m11
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString palabrasTotales, Cantidades  
            escribir  handlerentrada, Cantidades, SIZEOF Cantidades

            escribir  handlerentrada, t1, SIZEOF t1
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString contadorDip, Cantidades  
            escribir  handlerentrada, Cantidades, SIZEOF Cantidades

            escribir  handlerentrada, t2, SIZEOF t2
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString contadorHia, Cantidades  
            escribir  handlerentrada, Cantidades, SIZEOF Cantidades

            escribir  handlerentrada, t3, SIZEOF t3
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString contadorTrip, Cantidades  
            escribir  handlerentrada, Cantidades, SIZEOF Cantidades

            escribir  handlerentrada, E1, SIZEOF E1
            escribir  handlerentrada, E1, SIZEOF E1
            cerrar handlerentrada
            print imprimenter          
            jmp Inicio
            


;------------------------------------------- COMANDO "PROP_DIPTONGO|HIATO|TRIPTONGO" ------------------------------------------------
        CalculaMediaDip: ;media = (100 * palabrasTotales) / contadorDip  
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString palabrasTotales, Cantidades  
            print m11
            print Cantidades
            print imprimenter    
            xor ax, ax
            xor bx, bx  
            mov al, Cantidades  ;al = 77
            mov bl, 100
            MUL bl      ;al = (100 * Cantidades)
            mov Cantidades, al
            print m1
            print Cantidades
            print imprimenter
            jmp Inicio
        
        CalculaMediaHia:
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString palabrasTotales, Cantidades  
            print m11
            print Cantidades
            print imprimenter    
            xor ax, ax
            xor bx, bx  
            mov al, Cantidades  ;al = 77
            mov bl, 100
            MUL bl      ;al = (100 * Cantidades)
            mov Cantidades, al
            print m2
            print Cantidades
            print imprimenter
            jmp Inicio

        CalculaMediaTrip:
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString palabrasTotales, Cantidades  
            print m11
            print Cantidades
            print imprimenter    
            xor ax, ax
            xor bx, bx  
            mov al, Cantidades  ;al = 77
            mov bl, 100
            MUL bl      ;al = (100 * Cantidades)
            mov Cantidades, al
            print m3
            print Cantidades
            print imprimenter
            jmp Inicio



;------------------------------------------- COMANDO "ABRIR_RUTA" ------------------------------------------------
        AbrirArchivo: 
            print imprimenter
            print ingreseruta
            print imprimenter
            limpiar bufferentrada, SIZEOF bufferentrada,24h ;limpiamos el arreglo bufferentrada con $
            obtenerRuta bufferentrada ;obtenemos la ruta en buffer de entrada
            abrir bufferentrada,handlerentrada  ;le mandamos la ruta y el handler,que será la referencia al fichero 
            limpiar bufferInformacion, SIZEOF bufferInformacion,24h  ;limpiamos la variable donde guardaremos los datos del archivo 
            leer handlerentrada, bufferInformacion, SIZEOF bufferInformacion ;leemos el archivo 

        AbrirArchivo2:	
            print imprimenter
            print enc2
            print imprimenter
            print op
            getChar
            cmp al,31h
            je MostrarInformacion
            cmp al,32h
            je CerrarArchivo
            jmp AbrirArchivo

        MostrarInformacion:
            print imprimenter
            print bufferInformacion
            print imprimenter
            jmp AbrirArchivo2

        CerrarArchivo:
            cerrar handlerentrada
            jmp Inicio

        Error1:
            print imprimenter
            print err1
            getChar
            jmp Inicio

        Error2:
            print imprimenter
            print err2
            getChar
            jmp Inicio
        
        Error3:
            print imprimenter
            print err3
            getChar
            jmp Inicio
        
        Error4:
            print imprimenter
            print err4
            getChar
            jmp Inicio

        Error5:
            print imprimenter
            print err5
            getChar
            jmp Inicio



;------------------------------------------- COMANDO "CONTAR_DIPTONGO|HIATO|TRIPTONGO" ------------------------------------------------
        comContar:
            cmp arregloComando[7], 100  ;si es d
            je contarDip
            cmp arregloComando[7], 104  ;si es h
            je contarHia
            cmp arregloComando[7], 116  ;si es t
            je contarTrip
            jmp Error

        contarDip:
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString contadorDip, Cantidades
            print t1
            print Cantidades
            print imprimenter
            jmp Inicio
            
        contarHia:
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString contadorHia, Cantidades
            print t2
            print Cantidades
            print imprimenter
            jmp Inicio
            
        contarTrip:
            Limpiar Cantidades, SIZEOF Cantidades, 24h
            IntToString contadorTrip, Cantidades
            print t3
            print Cantidades
            print imprimenter
            jmp Inicio





;------------------------------------------- COMANDO "COLOREAR" ------------------------------------------------
        comColorear:
            print imprimenter
            ;con esto entramos al modo video
            mov ah, 0
            mov al, 03h
            int 10h

            imprimir bufferInformacion
            imprimir imprimenter
            imprimir imprimenter
            
            ;con esto le decimos que imprima en la posicion 3 despues
            mov ah, 03h
            mov bh, 00h
            int 10h ;dh guarda el valor de la ult.pos. de fila y dl guarda el valor de la ult.pos. de columna 

            mov fila, dh
            mov columna, dl
            mov si, 0
            mov di, 0
        


;------------------------------------ POSICIONAR EL CURSOR EN LA MATRIZ ------------------------------------------
        ciclo1:

            posicionarCursor fila, columna
            
            
            ;hacemos un if, para verificar si en la 3era posicion es una vocal, es un triptongo
            cmp bufferInformacion[si + 2], 105  ;letra i
            je esTrip
            cmp bufferInformacion[si + 2], 117  ;letra u
            je esTrip
            jmp esA


            esA:
                cmp bufferInformacion[si], 97   ;letra a
                jne esE

                cmp bufferInformacion[si + 1], 97   ;letra a
                je esHia
                cmp bufferInformacion[si + 1], 101  ;letra e
                je esHia
                cmp bufferInformacion[si + 1], 111  ;letra o
                je esHia
                jmp esDip

            esE:
                cmp bufferInformacion[si], 101  ;letra e
                jne esO

                cmp bufferInformacion[si + 1], 97   ;letra a
                je esHia
                cmp bufferInformacion[si + 1], 101  ;letra e
                je esHia
                cmp bufferInformacion[si + 1], 111  ;letra o
                je esHia
                jmp esDip

            esO:
                cmp bufferInformacion[si], 111  ;letra o
                jne esII

                cmp bufferInformacion[si + 1], 97   ;letra a
                je esHia
                cmp bufferInformacion[si + 1], 101  ;letra e
                je esHia
                cmp bufferInformacion[si + 1], 111  ;letra o
                je esHia
                jmp esDip

            esII:
                cmp bufferInformacion[si], 105  ;letra i
                jne esU

                cmp bufferInformacion[si + 1], 105  ;letra i
                je esHia
                jmp esDip

            esU:
                cmp bufferInformacion[si], 117  ;letra u
                jne esDip

                cmp bufferInformacion[si + 1], 117  ;letra u
                je esHia
                jmp esDip






            esDip:
                ;-----> para diptongos
                esDiptongo bufferInformacion[si], bufferInformacion[si + 1]
                cmp al, 0
                je letra
                ;pintamos el diptongo
                imprimirVideo bufferInformacion[si], 0010b  ;verde 
                inc columna                     ;aumenta la posicion del cursor
                inc si         
                posicionarCursor fila, columna 
                imprimirVideo bufferInformacion[si], 0010b  ;verde
                jmp siguiente

            esHia:
                ;-----> para hiatos
                esHiato bufferInformacion[si], bufferInformacion[si + 1]
                cmp auxHiato, 0
                je letra
                ;pintamos el hiato
                imprimirVideo bufferInformacion[si], 0100b  ;rojo 
                inc columna                     ;aumenta la posicion del cursor
                inc si            
                posicionarCursor fila, columna 
                imprimirVideo bufferInformacion[si], 0100b  ;rojo 
                jmp siguiente

            esTrip:
                ;-----> para triptongos
                esTriptongo bufferInformacion[si], bufferInformacion[si + 1], bufferInformacion[si + 2]
                cmp auxTriptongo, 0
                je letra
                ;pintamos el triptongo
                imprimirVideo bufferInformacion[si], 1110b  ;amarillo 
                inc columna                     ;aumenta la posicion del cursor
                inc si      

                posicionarCursor fila, columna 
                imprimirVideo bufferInformacion[si], 1110b  ;amarillo 
                inc columna                     ;aumenta la posicion del cursor
                inc si    
                
                posicionarCursor fila, columna 
                imprimirVideo bufferInformacion[si], 1110b  ;amarillo 
                jmp siguiente




            letra:
                imprimirVideo bufferInformacion[si], 1111b ;blanco     
                jmp siguiente

            
            siguiente:  
               

            inc columna ;aumenta la posicion del cursor
            inc si

            cmp bufferInformacion[si], 32d ;espacio en blanco
            jne NoAumentar
                mov di, palabrasTotales
                inc di
                mov palabrasTotales, di
                inc palabrasTotales2
            NoAumentar: 

            cmp columna, 80d ;solo soporta 80 caracteres y 25 filas (d de decimal)
            jl noSalto
                mov columna, 0
                inc fila
            noSalto:
            
            cmp bufferInformacion[si], 36d ;signo $
            jne ciclo1

            mov di, palabrasTotales
            inc di
            mov palabrasTotales, di
            inc palabrasTotales2
            inc fila
            mov ah, 02h
            mov dh, fila
            mov dl, 0
            mov bh, 0
            int 10h
            jmp Inicio









        Error:
            print imprimenter
            print err
            print imprimenter
;------------------------------------ SALIR DEL PROGRAMA ------------------------------------------
        salir:
            mov ah, 4ch ;numero de funcion para salir del programa
            xor aL, aL
            int 21h
    
main endp
end main