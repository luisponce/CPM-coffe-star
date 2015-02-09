#SimuProc 1.4.2.0
 ;
 ; Uso manual de la memoria
 ; ---------------------------------------------
 ; DIR = DESCRIPTION
 ; ---------------------------------------------
 ; EEO = 0 CONST
 ; EE1 = 1 CONST
 ; EE2 = 2 CONST
 ; EE3 = 3 CONST
 ; EE4 = Cantidad de empleados (16 bits)
 ; EE5 = Sueldo basico empleados (32 bits)
 ; EE6 = Reservado
 ; EE7 = Total pago a empleado de grupo (32 bits)
 ; EE8 = Reservado
 ; EE9 = Sueldo (32 bits)
 ; EEA = Reservado
 ; EEB = SMLMV (32 bits)
 ; EEC = Reservado
 ; EED = Numero salarios minimos (16 bits)
 ; EEE = Flag de salario minimo no entero (0 si es entero, 1 si es por ejm 2.4)
 ; EEF =
 ; EEG = Reservado
 ;

 ; Home de la aplicacion

 MSG Nomina CoffeeStar
 MSG ------------------------------------------
 MSG OPCIONES:
 MSG   1. Ingresar nomina
 MSG   2. Ver totales
 MSG   3. Salir
 LDT INGRESE LA OPCION:

 CMP EE1 	; Compara AX con 1
 JEQ 010	; Si son iguales salta a ingresar nomina
 CMP EE2 	; Compara AX con 2
 JEQ 02B	; Si son iguales salta a totales
 CMP EE3 	; Compara AX con 3
 JEQ 00F 	; Si son iguales salta a terminar programa
 MSG Ingrese una opcion valida
 JMP 006 	; Salta a ingresar opcion

 HLT 		; Terminar programa

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
 LDF EE5     	; Pasar de Sueldo basico empleados a Ax-Bx 32bits
 DIVF EEB    	; Ax-Bx dividido SMLMV (32bits) y almacena en Ax en 32bits
 FTOI       	; Pasa de flotante de 32bits a Entero de 16bits
 MOV EED,AX     ; Guarda lo que esta en AX en Numero salarios minimos en 16bits
 MOV AX, CX
 CMP EE0        ; comparar si el reciduo de la div es cero
 JEQ 021         ; SI es cero salte a setFlag
 MOV EEE, EE1    ; SINO carga 1 en El flag de salario minimo no entero
 JMP 022         ; salta a fin si
 MOV EEE, EE0    ; ENTONCES SetFlag, pone el flag de salario minimo no entero en cero
 NOP ; FIN SI
 
 ; subsidio de transporte
 MOV AX, EE2     ; Guarda 2 en AX
 CMP EED         ; Compara el numero de salarios minimos con 2
 JME             ; SI el numero de salarios minimos es menor que 2 ir a calcular subsidio
 JEQ             ; SINO SI es igual a dos ir a comparar flag
 JMP ; FIN SI
 
 ; compar flag
 CLA             ; AX=0
 CMP EEE         ; compara el flag con 0 para saber si tiene decimales
 JEQ             ; SI tiene decimales ir a calcular subsidio
 JMP ; Fin si
 
 ; calcular subsidio
 LDF EE4         ; Guarda el sueld basico en AX
 MULF EEF
 
 
 
 
 
 

 MSG Valor a pagar:
 LDF EE7 	; Cargar total pago a empleado del grupo
 OUT 1,AX 	; Escribir total pago a empleado del grupo
 NOP
 
 MSG ------------------------------------------
 MSG Desea ingresar otro?
 MSG  1. SI
 MSG  2. NO
 LDT

 CMP EE1
 JEQ 010 	; Si es 1 salta a Ingresar nomina
 CMP EE2
 JEQ 000 	; Si es 2 salta a home
 MSG Ingrese una opcion valida
 JMP 01F 	; Si no ingresa una opcion valida

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
 
#EEF
 0011110101001100
 1100110011000000
 
