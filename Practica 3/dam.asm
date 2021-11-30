include macro5.asm  ;incluimos la macro


.model small
.stack 

;========================================= SEGMENTO DE DATOS =========================================
.data
    ;------------- PARA LOS REPORTES -------------
    bufferentrada db 50 dup('$')
    handlerentrada dw ?
    bufferInformacion db 200 dup('$')
    
    br db 0ah, 0dh, '<br>','$'
    bj1 db 0ah, 0dh, ' Blancas ','$'
    nj2 db 0ah, 0dh, ' Negras ','$'
    html db 0ah, 0dh, '<html><body><center>','$'
    encabezado db 0ah, 0dh,  '<h1><br><br> Reporte del Juego </h1><br><br> <table>','$'
    ttr1 db 0ah, 0dh, '<tr><td>Jugadores</td><td>Fichas</td><td>Punteo</td></tr>','$'
    ttr db 0ah, 0dh, '<tr>','$'
    ttd db 0ah, 0dh, '<td>','$'
    ttdc db 0ah, 0dh, '</td>','$'
    ttrc db 0ah, 0dh, '</tr>','$'
    encabezado2 db 0ah, 0dh,  '<h3> <br><br>Tablero actual del juego </h3>','$'
              
    table2 db 0ah, 0dh, '<table border=1>','$'
    table2c db 0ah, 0dh, '</table>','$'
    tab db 0ah, 0dh, '<td></td><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td>','$'        

    n1 db 49, '$'      
    n2 db 50, '$'   
    n3 db 51, '$'   
    n4 db 52, '$'   
    n5 db 53, '$'   
    n6 db 54, '$'   
    n7 db 55, '$'   
    n8 db 56, '$'   
    aux11 db 0, '$'
    siEsRepoJ1 db 0, '$'                      
    siEsRepoJ2 db 0, '$'                      

    htmlc db 0ah, 0dh, '</table></center></body></html>','$'


    ;------------- MENSAJES DEL MENU PRINCIPAL -------------
    saludo1 db 0ah, 0dh, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'
    saludo2 db 0ah, 0dh, 'FACULTAD DE INGENIERIA','$'
    saludo3 db 0ah, 0dh, 'ESCUELA DE CIENCIAS Y SISTEMAS','$'
    saludo4 db 0ah, 0dh, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 B','$'
    saludo5 db 0ah, 0dh, 'PRIMER SEMESTRE 2021','$'
    saludo6 db 0ah, 0dh, 'Adriana Marie Gomez Davila','$'
    saludo7 db 0ah, 0dh, '201504236','$'
    saludo8 db 0ah, 0dh, 'Primera practica Assembler','$'
    imprimenter db 0ah, 0dh, ' ','$'
    opcion1 db 0ah, 0dh, ' -->  1.- Crear Jugadores','$'
    opcion2 db 0ah, 0dh, ' -->  2.- Jugar','$'
    opcion3 db 0ah, 0dh, ' -->  3.- Salir','$'


    opcion4 db 0ah, 0dh, ' -->  4.- Crear reporte','$'
    ingreseruta db 0ah,0dh, 'Ingrese una ruta de archivo' , 0ah,0dh, 'Ejemplo: entrada.txt' , '$'
    ing2 db 0ah,0dh, 'Ingrese texto a escribir' , '$'   
    err1 db 0ah,0dh, 'Error al abrir el archivo puede que no exista' , '$'
    err2 db 0ah,0dh, 'Error al cerrar el archivo' , '$'
    err3 db 0ah,0dh, 'Error al escribir en el archivo' , '$'
    err4 db 0ah,0dh, 'Error al crear en el archivo' , '$'
    err5 db 0ah,0dh, 'Error al leer en el archivo' , '$'


    ;------------- MENSAJES DENTRO DEL JUEGO -------------
    jugador db 0ah, 0dh, ' --> Jugador: ','$'
    FJ1 db 0ah, 0dh, ' --> Fichas: negras','$'
    FJ2 db 0ah, 0dh, ' --> Fichas: blancas','$'
    punteo db 0ah, 0dh, ' --> Punteo: ','$'
    punteoJ1 db 0, '$'              
    punteoJ2 db 0, '$'              
    termina db 0ah, 0dh, '** DESEA CONTINUAR? SI[1]/NO[0] **','$'
    repo db 0ah, 0dh, '** DESEA CREAR REPORTE? SI[1]/NO[0] **','$'
    repocomando db 0ah, 0dh, '>> ','$'
    pideComando db 0ah, 0dh, 'Ingrese su jugada: ','$'

    pideJ1 db 0ah, 0dh, ' --> Ingrese nombre del jugador 1: ','$'
    pideJ2 db 0ah, 0dh, ' --> Ingrese nombre del jugador 2: ','$'


    ;------------- VARIABLES Y ARREGLOS A UTILIZAR -------------
    arregloJugador db 10 dup('$'), '$'  ;solo recibe un nombre de jugador de 10 caracteres
    arregloJugador2 db 10 dup('$'), '$' ;solo recibe un nombre de jugador de 10 caracteres

    LetrasTablero db 10 dup('$'), '$' 
    aux2 db 0, '$'              
    tablero db 65 dup('$'), '$' ;tablero de 8x8 = 64 posiciones 65->llena64
    aux db 0, '$'               ;auxiliar para imprimir tablero
    nua db 0, '$'              

    posInicial db 2 dup('$'), '$'       ;recibe posicion donde se encuentra la ficha
    posFinal db 2 dup('$'), '$'         ;recibe posicion donde terminara la ficha
    arregloComando db 5 dup('$'), '$'   ;arreglo que recibira el comando A1:B2 para convertir en la macro

    resultado db 0, '$'         ;para la conversion de la coordenada
    columna db 0, '$'           ;para la conversion de la coordenada
    fila db 0, '$'              ;para la conversion de la coordenada
    numero db 2 dup('$'), '$'   ;para la conversion de la coordenada
    

    juegaJ1 db 0, '$'           ;para validar el turno en que esta y no mueva las fichas oponentes
    juegaJ2 db 0, '$'           ;para validar el turno en que esta y no mueva las fichas oponentes
    juegaJ22 db 0, '$'          ;para validar mensaje error en el turno 2 y mostrarlo en turno 1 porque limpia pantalla
    MensajeOponente db 0ah, 0dh, '>> MOVIMIENTO NO PERMITIDO, MOVISTE FICHAS OPONENTES','$'
    MovimientoInvalido db 0ah, 0dh, '>> CASILLAS INVALIDAS PARA MOVER','$'


    bandera db 0ah, 0dh, '           bandera 1           ','$'
    bandera2 db 0ah, 0dh, '           bandera 2           ','$'


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
            print saludo5
            print saludo6
            print saludo7
            print saludo8
            print imprimenter
            print opcion1
            print opcion2
            print opcion3
            print opcion4
            print imprimenter

            
            ;llenamos el tablero
            mov LetrasTablero[0], 0    ;caracter nulo
            mov LetrasTablero[1], 0    ;caracter nulo
            mov LetrasTablero[2], 65   ;A
            mov LetrasTablero[3], 66   ;B
            mov LetrasTablero[4], 67   ;C
            mov LetrasTablero[5], 68   ;D
            mov LetrasTablero[6], 69   ;E
            mov LetrasTablero[7], 70   ;F
            mov LetrasTablero[8], 71   ;G
            mov LetrasTablero[9], 72   ;H
            mov tablero[0], 0   ;caracter nulo
            mov tablero[1], 110 ;n
            mov tablero[2], 95  ;_
            mov tablero[3], 110 ;n
            mov tablero[4], 95  ;_
            mov tablero[5], 110 ;n
            mov tablero[6], 95  ;_
            mov tablero[7], 110 ;n
            mov tablero[8], 95  ;_
            mov tablero[9], 95  ;_
            mov tablero[10], 110 ;n
            mov tablero[11], 95  ;_
            mov tablero[12], 110 ;n
            mov tablero[13], 95  ;_
            mov tablero[14], 110 ;n
            mov tablero[15], 95  ;_
            mov tablero[16], 110 ;n
            mov tablero[17], 110 ;n
            mov tablero[18], 95  ;_
            mov tablero[19], 110 ;n
            mov tablero[20], 95  ;_
            mov tablero[21], 110 ;n
            mov tablero[22], 95  ;_
            mov tablero[23], 110 ;n
            mov tablero[24], 95  ;_
            mov tablero[25], 95  ;_
            mov tablero[26], 95  ;_
            mov tablero[27], 95  ;_
            mov tablero[28], 95  ;_
            mov tablero[29], 95  ;_
            mov tablero[30], 95  ;_
            mov tablero[31], 95  ;_
            mov tablero[32], 95  ;_
            mov tablero[33], 95  ;_
            mov tablero[34], 95  ;_
            mov tablero[35], 95  ;_
            mov tablero[36], 95  ;_
            mov tablero[37], 95  ;_
            mov tablero[38], 95  ;_
            mov tablero[39], 95  ;_
            mov tablero[40], 95  ;_
            mov tablero[41], 95  ;_
            mov tablero[42], 98  ;b
            mov tablero[43], 95  ;_
            mov tablero[44], 98  ;b
            mov tablero[45], 95  ;_
            mov tablero[46], 98  ;b
            mov tablero[47], 95  ;_
            mov tablero[48], 98  ;b
            mov tablero[49], 98  ;b
            mov tablero[50], 95  ;_
            mov tablero[51], 98  ;b
            mov tablero[52], 95  ;_
            mov tablero[53], 98  ;b
            mov tablero[54], 95  ;_
            mov tablero[55], 98  ;b
            mov tablero[56], 95  ;_
            mov tablero[57], 95  ;_
            mov tablero[58], 98  ;b
            mov tablero[59], 95  ;_
            mov tablero[60], 98  ;b
            mov tablero[61], 95  ;_
            mov tablero[62], 98  ;b
            mov tablero[63], 95  ;_
            mov tablero[64], 98  ;b



        ;------------- LEYENDO LA OPCION ELEGIDA EN EL TECLADO (1-3) -------------
            getChar
            cmp aL, 31h ;codigo ascii del 1 en hexa, nos dirige a crear jugadores
            je CrearJugadores
            cmp aL, 32h ;codigo ascii del 2 en hexa, nos dirige al juego
            je ModoJuego
            cmp aL, 33h ;codigo ascii del 3 en hexa, nos dirige a factorial
            je salir
            cmp aL, 34h ;codigo ascii del 3 en hexa, nos dirige a factorial
            je Reportes






;------------------------------------ CREAR JUGADORES (opcion #1 del menu principal) ------------------------------------------
        CrearJugadores:
            LimpiarConsola
            print pideJ1
		    ObtenerTexto arregloJugador 
            print pideJ2
		    ObtenerTexto arregloJugador2   

            jmp MenuPrincipal



;------------------------------------ JUGAR DAMAS (opcion #2 del menu principal) ------------------------------------------
        ModoJuego:
            LimpiarConsola
            mov punteoJ1, 48
            mov punteoJ2, 48
            Turno1:
            mov siEsRepoJ2, 48  ;setea 0
            mov juegaJ1, 49     ;setea 1
            mov juegaJ2, 48     ;setea 0
            print imprimenter
            print jugador           ; --> Jugador:
            print arregloJugador    
            print FJ1               ;--> Fichas: negras
            print punteo            ;--> Punteo:
            print punteoJ1
            print imprimenter
            print imprimenter
            
            ImprimeLetrasTablero LetrasTablero
            ImprimeTablero tablero

            print termina           ;¿DESEA CONTINUAR? SI[1]/NO[0]                
            getChar 
            cmp al, 48              ;si es 0 regresa al menu principal, sino, continua
            je MenuPrincipal

            print imprimenter
            print pideComando
		    ObtenerTexto arregloComando
            cmp arregloComando[0], 82   ;compara si es R que es 'REP'
            mov siEsRepoJ1, 49
            je Reportes
            AnalizarComando arregloComando 
            jmp Turno2

            Turno2:
            mov siEsRepoJ1, 48  ;setea 0
            mov juegaJ1, 48     ;setea 0
            mov juegaJ2, 49     ;setea 1
            print imprimenter
            print imprimenter
            print jugador           ; --> Jugador:
            print arregloJugador2    
            print FJ2               ;--> Fichas: blancas
            print punteo            ;--> Punteo:
            print punteoJ2
            print imprimenter
            print imprimenter
            
            ImprimeLetrasTablero LetrasTablero
            ImprimeTablero tablero

            print termina           ;¿DESEA CONTINUAR? SI[1]/NO[0]                
            getChar 
            cmp al, 48              ;si es 0 regresa al menu principal, sino, continua
            je MenuPrincipal

            print imprimenter
            print pideComando
		    ObtenerTexto arregloComando
            cmp arregloComando[0], 82   ;compara si es R que es 'REP'
            mov siEsRepoJ2, 49
            je Reportes
            LimpiarConsola
            AnalizarComando arregloComando 
            jmp Turno1
            jmp MenuPrincipal



;------------------------------------ SALIR DEL PROGRAMA (opcion #3 del menu principal) ------------------------------------------
        salir:
            mov ah, 4ch ;numero de funcion para salir del programa
            xor aL, aL
            int 21h
            







;------------------------------------ REPORTES (opcion #4 del menu principal) ------------------------------------------
        Reportes:
        
            print imprimenter
            print ingreseruta
            print imprimenter
            limpiar bufferentrada, SIZEOF bufferentrada,24h
            obtenerRuta bufferentrada
            crear bufferentrada, handlerentrada
            jmp EscribirArchivo

        Error1:
            print imprimenter
            print err1
            getChar
            jmp MenuPrincipal

        Error2:
            print imprimenter
            print err2
            getChar
            jmp MenuPrincipal
        
        Error3:
            print imprimenter
            print err3
            getChar
            jmp MenuPrincipal
        
        Error4:
            print imprimenter
            print err4
            getChar
            jmp MenuPrincipal

        Error5:
            print imprimenter
            print err5
            getChar
            jmp MenuPrincipal

    
     ;   EscribirArchivo:
      ;      print imprimenter
       ;     limpiar bufferInformacion, SIZEOF bufferInformacion,24h
        ;    print ing2
         ;   escribir  handlerentrada, tablero, SIZEOF tablero
          ;  cerrar handlerentrada
           ; print imprimenter          
            ;jmp MenuPrincipal
    

        EscribirArchivo:
            print imprimenter
            limpiar bufferInformacion, SIZEOF bufferInformacion,24h
            print ing2
            escribir  handlerentrada, html, SIZEOF html
            escribir  handlerentrada, encabezado, SIZEOF encabezado
            escribir  handlerentrada, ttr1, SIZEOF ttr1
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, arregloJugador, SIZEOF arregloJugador
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, nj2, SIZEOF nj2
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, punteoJ1, SIZEOF punteoJ1
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, arregloJugador2, SIZEOF arregloJugador2
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, bj1, SIZEOF bj1
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, punteoJ2, SIZEOF punteoJ2
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            escribir  handlerentrada, table2c, SIZEOF table2c
            
            escribir  handlerentrada, br, SIZEOF br
            escribir  handlerentrada, br, SIZEOF br
            escribir  handlerentrada, br, SIZEOF br
            escribir  handlerentrada, encabezado2, SIZEOF encabezado2
            escribir  handlerentrada, table2, SIZEOF table2
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, tab, SIZEOF tab
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n1, SIZEOF n1         ;********************* 1
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[1]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[2]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[3]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[4]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[5]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[6]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[7]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[8]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n2, SIZEOF n2         ;********************* 2
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[9]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[10]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[11]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[12]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[13]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[14]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[15]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[16]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n3, SIZEOF n3         ;********************* 3
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[17]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[18]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[19]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[20]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[21]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[22]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[23]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[24]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n4, SIZEOF n4         ;********************* 4
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[25]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[26]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[27]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[28]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[29]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[30]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[31]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[32]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n5, SIZEOF n5         ;********************* 5
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[33]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[34]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[35]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[36]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[37]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[38]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[39]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[40]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n6, SIZEOF n6         ;********************* 6
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[41]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[42]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[43]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[44]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[45]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[46]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[47]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[48]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n7, SIZEOF n7         ;********************* 7
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[49]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[50]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[51]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[52]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[53]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[54]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[55]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[56]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc
            
            escribir  handlerentrada, ttr, SIZEOF ttr
            escribir  handlerentrada, ttd, SIZEOF ttd
            escribir  handlerentrada, n8, SIZEOF n8         ;********************* 8
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[57]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[58]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[59]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[60]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[61]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[62]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[63]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttd, SIZEOF ttd
            mov al, tablero[64]
            mov aux11, al
            escribir  handlerentrada, aux11, SIZEOF aux11
            escribir  handlerentrada, ttdc, SIZEOF ttdc
            escribir  handlerentrada, ttrc, SIZEOF ttrc


            escribir  handlerentrada, htmlc, SIZEOF htmlc

            cerrar handlerentrada
            print imprimenter  
            cmp siEsRepoJ1, 49
            je Turno1        
            cmp siEsRepoJ2, 49
            je Turno2   

            jmp ModoJuego

main endp
end main
