#SimuProc 1.4.2.0
 ; Se cargan los valores 0, 1, 2 y 3 en momeria para
 ; comparaciones

 ; CLA ; Limpiar AX, AX=0
 ; MOV FFF,AX ; Pone FFF como AX
 ; INC AX ; Incrementa en 1 AX , AX=1
 ; MOV FFE,AX
 ; INC AX ; AX=2
 ; MOV FFD,AX
 ; INC AX ; AX=3
 ; MOV FFC,AX

 ;
 ; EEO = 0
 ; EE1 = 1
 ; EE2 = 2
 ; EE3 = 3
 ; EE4 = Cantidad de empleados
 ; EE5 = Sueldo basico empleados
 ; EE6 = N/A
 ; EE7 = Total pago a empleado de grupo
 ; EE8 = N/A
 ; EE9 = Sueldo
 ; EEA = N/A
 ; EEB = SMLMV
 ; EEC = N/A
 ; EED = Numero salarios minimos
 ; EEE = N/A
 ;

 ; Home de la aplicacion

 MSG Nomina CoffeeStar
 MSG ------------------------------------------
 MSG OPCIONES:
 MSG   1. Ingresar nomina
 MSG   2. Ver totales
 MSG   3. Salir
 LDT INGRESE LA OPCION:

 CMP EE1 ; Compara AX con 1
 JEQ 010; Si son iguales salta a
 CMP EE2 ; Compara AX con 2
 JEQ 02A; Si son iguales salta a
 CMP EE3 ; Compara AX con 3
 JEQ 00F ; Si son iguales salta a
 MSG Ingrese una opcion valida
 JMP 006 ; Salta a ingresar opcion

 HLT ; Terminar programa

 ; Futura implementacion

 MSG ------------------------------------------
 MSG Ingresar nomina
 MSG __________________________________________
 LDT Cantidad de empledos:
 MOV EE4,AX
 MSG Sueldo emplados:
 IN AX,1
 STF EE5

 ; OPERACIONES
 LDF EE5     ;Pasar de memoria a Ax-Bx 32bits
 DIVF EEB    ;Ax dividido la posicion de memoria y almacena en AX en 32bits
 FTOI       ; Pasae de real de 32bits a registro de 16bits
 MOV EED,AX     ;Guarda lo que esta en AX en la posicion de memoria en 32bits

 MSG Valor a pagar:
 MOV AX,EE6
 EAP ; Imprimir el auxiliar
 MSG ------------------------------------------
 MSG Desea ingresar otro?
 MSG  1. SI
 MSG  2. NO
 LDT

 CMP EE1
 JEQ 010
 CMP EE2
 JEQ 000
 MSG Ingrese una opcion valida
 JMP 01F

 MSG Totales
 MOV AX,EED
 EAP
 JMP 002

 ; Constantes 0, 1, 2, 3
#EE0
 0000000000000000
 0000000000000001
 0000000000000010
 0000000000000011
 
 ; SMLMV En 32bits
#EEB
 0100100100011101
 0100111111100000

 ; Constantes temporales
#EE6
 0000000000001010
