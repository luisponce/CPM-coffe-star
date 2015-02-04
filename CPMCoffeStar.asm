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
 
 ; Home de la aplicacion
 
 MSG Nomina CoffeeStar
 MSG   le estamos poniendo el alma
 MSG ------------------------------------------
 MSG OPCIONES:
 MSG   1. Ingresar nomina
 MSG   2. Ver totales
 MSG   3. Salir
 LDT INGRESE LA OPCION:

 CMP EE1 ; Compara AX con 1
 JEQ 011; Si son iguales salta a
 CMP EE2 ; Compara AX con 2
 JEQ 011; Si son iguales salta a
 CMP EE3 ; Compara AX con 3
 JEQ 010 ; Si son iguales salta a
 MSG Ingrese una opcion valida
 JMP 007 ; Salta a ingresar opcion

 HLT ; Terminar programa

 ; Futura implementacion

 MSG FUTURO
 JMP 003

#EE0
 0000000000000000
 0000000000000001
 0000000000000010
 0000000000000011
