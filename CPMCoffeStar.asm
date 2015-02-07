#SimuProc 1.4.2.0
 ; Se cargan los valores 0, 1, 2 y 3 en memoria para
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
 ; EE4 = Cantidad de empleados (16 bits)
 ; EE5 = Sueldo basico empleados (32)
 ; EE6 = N/A
 ; EE7 = Total pago a empleado de grupo (32)
 ; EE8 = N/A
 ; EE9 = Sueldo (32)
 ; EEA = N/A
 ; EEB = SMLMV (32)
 ; EEC = N/A
 ; EED = Numero salarios minimos (16)
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
 JEQ 010; Si son iguales salta a ingresar nomina
 CMP EE2 ; Compara AX con 2
 JEQ 02B; Si son iguales salta a totales
 CMP EE3 ; Compara AX con 3
 JEQ 00F ; Si son iguales salta a terminar programa
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
 LDF EE5     ;Pasar de Sueldo basico empleados a Ax-Bx 32bits
 DIVF EEB    ;Ax-Bx dividido SMLMV (32bits) y almacena en Ax en 32bits
 FTOI       ; Pasa de flotante de 32bits a Entero de 16bits
 MOV EED,AX     ;Guarda lo que esta en AX en Numero salarios minimos en 16bits

 MSG Valor a pagar:
 LDF EE7 ;cargar total pago a empleado del grupo
 OUT 1,AX ;escribir total pago a empleado del grupo
 NOP
 
 MSG ------------------------------------------
 MSG Desea ingresar otro?
 MSG  1. SI
 MSG  2. NO
 LDT

 CMP EE1
 JEQ 010 ;si es 1 salta a Ingresar nomina
 CMP EE2
 JEQ 000 ;si es 2 salta a home
 MSG Ingrese una opcion valida
 JMP 01F ;si no ingresa una opcion valida

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
