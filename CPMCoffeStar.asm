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
 ; EE4 =
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
 ; EEF = CONST Subsidio de transporte (32 bits)
 ; EF0 = Reservado
 ; EF1 = Temporal
 ; EF2 = Aportes de salud empleado
 ; EF3 = Reservado
 ; EF4 = Total Aportes salud empleados
 ; EF5 = Reservado
 ; EF6 = Aportes salud empresa
 ; EF7 = Reservado
 ; EF8 = Total Aportes salud empresa
 ; EF9 = Reservado
 ; EFA = 0.04  CONST
 ; EFB = Reservado
 ; EFC = 0.045 CONST
 ; EFD = Reservado
 ; EFE = 0.08 CONST
 ; EFF = Reservado
 ; F00 = Cantidad de empleados (32 bits)
 ; F01 = Reservado
 ; F02 = Aportes a pensiones empleado
 ; F03 = Reservado
 ; F04 = Total aportes a pensiones empleados
 ; F05 = Reservado
 ; F06 = Aportes a pension empresa
 ; F07 = Reservado
 ; F08 = Total aportes a pensiones empresa
 ; F09 = Reservado

 ; Home de la aplicacion

 MSG Nomina CoffeeStar
 MSG ------------------------------------------
 MSG OPCIONES:
 MSG   1. Ingresar nomina
 MSG   2. Ver totales
 MSG   3. Salir
 LDT INGRESE LA OPCION:

 CMP EE1        ; Compara AX con 1
 JEQ 010        ; Si son iguales salta a ingresar nomina
 CMP EE2        ; Compara AX con 2
 JEQ 02B        ; Si son iguales salta a totales
 CMP EE3        ; Compara AX con 3
 JEQ 00F        ; Si son iguales salta a terminar programa
 MSG Ingrese una opcion valida
 JMP 006        ; Salta a ingresar opcion

 HLT            ; Terminar programa

 ; Futura implementacion

 MSG ------------------------------------------
 MSG Ingresar nomina
 MSG __________________________________________
 MSG Cantidad de empledos:
 IN AX,1
 STF F00
 MSG Sueldo emplados:
 IN AX,1
 STF EE5

 ; OPERACIONES
 LDF EE5        ; Pasar de Sueldo basico empleados a Ax-Bx 32bits
 
 STF EE9        ; Guardar sueldo basico en sueldo
 DIVF EEB       ; Ax-Bx dividido SMLMV (32bits) y almacena en Ax en 32bits
 MOV EF1,CX     ; Pasa el decimal a un temporal
 FTOI           ; Pasa de flotante de 32bits a Entero de 16bits
 MOV EED,AX     ; Guarda lo que esta en AX en Numero salarios minimos en 16bits
 MOV AX,EF1
 CMP EE0         ; comparar si el reciduo de la div es cero
 JEQ 024         ; SI es cero salte a ENTONCES
 MOV AX,EE1      ; SINO carga 1 en AX
 MOV EEE,AX     ; Pone el flag en 1 (tiene decimales)
 JMP 026         ; salta a fin si
 
 MOV AX,EE0     ; ENTONCES SetFlag, pone AX en cero
 MOV EEE,AX     ; carga 0 en el flag (no tiene decimales)
 NOP             ; FIN SI
 
 ; subsidio de transporte
 MOV AX,EE2     ; Guarda 2 en AX
 CMP EED         ; Compara el numero de salarios minimos con 2
 JMA 030         ; SI el numero de salarios minimos es menor que 2 ir a calcular subsidio
 JEQ 02C         ; SINO SI es igual a dos ir a comparar flag
 JMP 034         ; FIN SI
 
 ; compar flag
 MOV AX,EE1      ; AX=0
 CMP EEE         ; compara el flag con 1 para saber si tiene decimales
 JEQ 030         ; SI tiene decimales ir a calcular subsidio
 JMP 034         ; Fin si
 
 ; calcular subsidio
 LDF EEF         ; Carga el subsidio de transporte
 ADDF EE9        ; Suma al sueldo actual el subsidio de transporte
 STF EE9         ; Actualiza el sueldo actual en el espacio de memoria correspondiente

 ; Aportes salud empleados
 LDF EFA         ; Carga 0.04
 MULF EE5        ; multiplica 0.04 por el sueldo basico
 STF EF2         ; guarda el Aportes de la salud del empleado en memoria
 
 LDF EE9         ; Carga el sueldo actual en AX-BX
 SUBF EF2        ; Resta al sueldo actual el Aportes de la salud
 STF EE9         ; Actualiza el sueldo actual
 
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF EF2        ; multiplica lo que paga un empleado de salud por la cantidad de empleados
 ADDF EF4        ; Suma al total de salud de empleados del grupo con el total acumulado
 STF EF4         ; guarda el total de salud de empleados en memoria
 
 ; Aportes salud empresa
 LDF EFC         ; carga 0.045
 MULF EE5        ; multiplica 0.045 por el sueldo basico
 STF EF6         ; guarda el Aportes de la salud de la empresa en memoria
 
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF EF6        ; multiplica lo que paga la empresa de saludo por un empleado por la cantidad de empleados
 ADDF EF8        ; Suma al total de salud de la empresa del grupo con el total acumulado
 STF EF8         ; guarda el total de salud de la empresa en memoria
 
 ; Aporte de pensiones empleado
 LDF EFA          ; Carga 0.04
 MULF EE5         ; multiplica 0.04 por el sueldo basico
 STF F02          ; guarda el valores de aportes a pension en memoria
 
 LDF EE9          ; Carga el sueldo actual en AX-BX
 SUBF F02         ; resta los aportes a pensiones del sueldo actual
 STF EE9          ; actualiza el sueldo actual
 
 LDF F00          ; Carga el numero de empleados en AX-BX
 MULF F02         ; multiplica lo que paga un empleado de pensiones por la cantidad de empleados
 ADDF F04         ; Suma al total de pensiones de empleado del grupo con el total acumulado
 STF F04          ; guarda el total de pensiones de empleados en memoria
 
 ; Aporte de pensiones empresa
 LDF EFE          ; Cargar 0.08 en AX-BX
 MULF EE5         ; multiplica 0.08 por el sueldo basico
 STF F06          ; guarda el total de pensiones de empleados en memoria
 
 LDF F00          ; Cargar en AX-BX el numero de empleados
 MULF F06         ; Multiplicar el numero de empleados por el total de pensiones empresa
 ADDF F08         ; Suma al total de pensiones de la empresa del grupo con el total acumulado
 STF F08          ; guardar el total de pensiones de empresa en memoria
 
 

 MSG Valor a pagar:
 LDF EE7        ; Cargar total pago a empleado del grupo
 OUT 1,AX       ; Escribir total pago a empleado del grupo
 NOP
 
 MSG ------------------------------------------
 MSG Desea ingresar otro?
 MSG  1. SI
 MSG  2. NO
 LDT

 CMP EE1
 JEQ 010        ; Si es 1 salta a Ingresar nomina
 CMP EE2
 JEQ 000        ; Si es 2 salta a home
 MSG Ingrese una opcion valida
 JMP 03B        ; Si no ingresa una opcion valida

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
 0100011110010000
 1000100000000000

#EFA
 0011110100100011
 1101011100000000
 0011110100111000
 0101000111100000
 0011110110100011
 1101011100001000
