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
 ; EE7 =
 ; EE8 =
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
 ; EF4 =
 ; EF5 =
 ; EF6 = Aportes salud empresa
 ; EF7 = Reservado
 ; EF8 =
 ; EF9 =
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
 ; F04 =
 ; F05 =
 ; F06 = Aportes a pension empresa
 ; F07 = Reservado
 ; F08 =
 ; F09 =
 ; F0A = 0.01 CONST
 ; F0B = Reservado
 ; F0C = 0.012 CONST
 ; F0D = Reservado
 ; F0E = 0.014 CONST
 ; F0F = Reservado
 ; F10 = 0.016 CONST
 ; F11 = Reservado
 ; F12 = 0.018 CONST
 ; F13 = Reservado
 ; F14 = 0.02 CONST
 ; F15 = Reservado
 ; F16 = 3 CONST
 ; F17 = 4 CONST
 ; F18 = 15 CONST
 ; F19 = 16 CONST
 ; F1A = 17 CONST
 ; F1B = 18 CONST
 ; F1C = 19 CONST
 ; F1D = Fondo de solidaridad de un empleado
 ; F1E = Reservado
 ; F20 = 150 CONST (16 bits)
 ; F21 = 360 CONST (16 bits)
 ; F22 = Impuesto Laboral Gravado (ILG)
 ; F23 = Reservado
 ; F24 = Base Gravable
 ; F25 = Reservado
 ; F26 = 0.25 CONST
 ; F27 = Reservado
 ; F28 = 25% de ILG
 ; F29 = Reservado
 ; F2A = valor UVT CONST
 ; F2B = Reservado
 ; F2C = Flag rangos UVT
 ; F2D = Numero de UVT
 ; F2E = 150 CONST
 ; F2F = Reservado
 ; F30 = 95 CONST (16 bits)
 ; F31 = 0.19 CONST
 ; F32 = Reservado
 ; F33 = 0.28 CONST
 ; F34 = Reservado
 ; F35 = 0.33 CONST
 ; F36 = Reservado
 ; F37 = 95 CONST
 ; F38 = Reservado
 ; F39 = Impuesto
 ; F3A = Reservado
 ; F3B = 69 CONST
 ; F3C = Reservado
 ; F3D = 10 CONST
 ; F3E = Reservado
 ; F3F = Total sueldo
 ; F40 = Reservado
 ; F41 = Total salud empleados
 ; F42 = Reservado
 ; F43 = Total salud empresa
 ; F44 = Reservado
 ; F45 = Total pension empleados
 ; F46 = Reservado
 ; F47 = Total pension empresa
 ; F48 = Reservado
 ; F49 = Total fondo de solidaridad
 ; F4A = Reservado
 ; F4B = Total impuestos
 ; F4C = Reservado
 ; F4D = UVTs en 32bits
 ; F4E = Reservado
 ; F4F = 360 CONST
 ; F50 = Reservado
 
 
 
 

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
 JEQ 100        ; Si son iguales salta a totales
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
 MOV AX,EF1      ; Carga temporal
 CMP EE0         ; comparar si el reciduo de la div es cero
 JEQ 025         ; SI es cero salte a ENTONCES
 MOV AX,EE1      ; SINO carga 1 en AX
 MOV EEE,AX     ; Pone el flag en 1 (tiene decimales)
 JMP 027         ; salta a fin si
 
 MOV AX,EE0     ; ENTONCES SetFlag, pone AX en cero
 MOV EEE,AX     ; carga 0 en el flag (no tiene decimales)
 NOP             ; FIN SI
 
 ; subsidio de transporte
 MOV AX,EE2      ; Guarda 2 en AX
 CMP EED         ; Compara el numero de salarios minimos con 2
 JMA 031         ; SI el numero de salarios minimos es menor que 2 ir a calcular subsidio
 JEQ 02D         ; SINO SI es igual a dos ir a comparar flag
 JMP 034         ; FIN SI
 
 ; compar flag
 MOV AX,EE0      ; AX=0
 CMP EEE         ; compara el flag con 0 para saber si tiene decimales
 JEQ 031         ; SI tiene decimales ir a calcular subsidio
 JMP 034         ; Fin si
 
 ; calcular subsidio
 LDF EEF         ; Carga el subsidio de transporte
 ADDF EE9        ; Suma al sueldo actual el subsidio de transporte
 STF EE9         ; Actualiza el sueldo actual en el espacio de memoria correspondiente

 ; Aportes salud empleados
 LDF EFA         ; Carga 0.04 ...Fin Si
 MULF EE5        ; multiplica 0.04 por el sueldo basico
 STF EF2         ; guarda el Aportes de la salud del empleado en memoria
 
 LDF EE9         ; Carga el sueldo actual en AX-BX
 SUBF EF2        ; Resta al sueldo actual el Aporte de la salud
 STF EE9         ; Actualiza el sueldo actual
 
 NOP
 NOP
 NOP
 NOP
 
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
 
 ; Aportes al fondo de solidaridad
 MOV AX,EED       ; Cargar numero de SMLMV
 CMP F17          ; Compara con 4
 JME 087          ; Si es menor que 4 Salta a END
 CMP F16          ; Compara con 3
 JMA 066          ; Si es mayor que 3 ir a 1%
 CMP F18          ; Compara con 15
 JMA 06B          ; Si es mayor que 15 ir a 1.2%
 CMP F19          ; Compara con 16
 JMA 070          ; Si es mayor que 16 ir a 1.4%
 CMP F1A          ; Compara con 17
 JMA 075          ; Si es mayor que 17 ir a 1.6%
 CMP F1B          ; Compara con 18
 JMA 07A          ; Si es mayor que 18 ir a 1.8%
 CMP F1C          ; Compara con 19
 JMA 07F          ; Si es mayor que 19 ir a 2%
 JMP 084          ; ir a END
 
 ; Asignar 1% fondo de solidaridad
 LDF EE5          ; Cargar salario basico
 MULF F0A         ; Multiplica por 1%
 STF F1D          ; Guarda aporte fondo de solidaridad
 MOV AX,EED          ; Carga numero de SMLMV
 JMP 05B          ; Salta a 1.2% - Compara con 15
 
 ; Asignar 1.2% fondo de solidaridad
 LDF EE5          ; Cargar salario basico
 MULF F0C         ; Multiplica por 1.2%
 STF F1D          ; Guarda aporte fondo de solidaridad
 MOV AX,EED          ; Carga numero de SMLMV
 JMP 05D          ; Salta a 1.4% - Compara con 16
 
 ; Asignar 1.4% fondo de solidaridad
 LDF EE5          ; Cargar salario basico
 MULF F0E         ; Multiplica por 1.4%
 STF F1D          ; Guarda aporte fondo de solidaridad
 MOV AX,EED          ; Carga numero de SMLMV
 JMP 05F          ; Salta a 1.6% - Compara con 17
 
 ; Asignar 1.6% fondo de solidaridad
 LDF EE5          ; Cargar salario basico
 MULF F10         ; Multiplica por 1.6%
 STF F1D          ; Guarda aporte fondo de solidaridad
 MOV AX,EED          ; Carga numero de SMLMV
 JMP 061          ; Salta a 1.8% - Compara con 18
 
 ; Asignar 1.8% fondo de solidaridad
 LDF EE5          ; Cargar salario basico
 MULF F12         ; Multiplica por 1.8%
 STF F1D          ; Guarda aporte fondo de solidaridad
 MOV AX,EED          ; Carga numero de SMLMV
 JMP 063          ; Salta a 2% - Compara con 19
 
 ; Asignar 2% fondo de solidaridad
 LDF EE5          ; Cargar salario basico
 MULF F14         ; Multiplica por 2%
 STF F1D          ; Guarda aporte fondo de solidaridad
 MOV AX,EED          ; Carga numero de SMLMV
 JMP 084          ; Salta a END
 
 ; Restar aporte fondo de solidaridad
 LDF EE9          ; Carga sueldo
 SUBF F1D         ; Resta aporte fondo de solidaridad
 STF EE9          ; Guarda nuevo sueldo

 ; ILG
 LDF EE5          ; Carga sueldo basico -- END
 SUBF EF2         ; Resta al sueldo basico los aportes a la salud
 SUBF F02         ; Resta los aportes a la pension
 SUBF F1D         ; Resta aportes de solidaridad
 STF F22          ; Guarda ILG en memoria
 
 ; Base Gravable
 LDF F22          ; Carga ILG
 MULF F26         ; Multiplica por 0.25 (25% de ILG)
 STF F28          ; Guarda 25% de ILG en memoria
 
 LDF F22          ; Carga ILG
 SUBF F28         ; Resta 25%
 STF F24          ; Guarda Base Gravable en memoria
 
 ; UVT
 LDF F24          ; Carga Base Gravable
 DIVF F2A         ; Divide por UVT
 STF F4D          ; Guarda numero de UVTs en 32bits
 MOV EF1,CX       ; Guarda los decimales en un temporal
 FTOI             ; Pasa a entero
 MOV F2D,AX       ; Guarda el numero de UVT en memoria
 MOV AX,EF1       ; Carga temporal
 CMP EE0          ; comparar si el reciduo de la div es cero
 JEQ 09E          ; Si es cero, ir a poner cero en flag
 MOV AX,EE1       ; Carga 1
 MOV F2C,AX       ; Pone Flag de UVT en 1
 JMP 0A1          ; END
 
 ; Poner cero en flag
 MOV AX,EE0       ; Carga 0
 MOV F2C,AX       ; Pone Flag de UVT en 0
 JMP 0A1          ; ir a END
 
 NOP  ;END
 
 ; Impuesto
 MOV AX,F2D       ; ***Numero de UVT
 CMP F30          ; Compara con 95
 JME 0AD          ; SI es menor de 95
 JEQ 0B2          ; SI es 95 (Preguntar por flag)
 
 CMP F20          ; Compara con 150
 JME 0B5          ; Si es menor de 150
 JEQ 0BC          ; SI es 150 (Preguntar por flag)
 
 CMP F21          ; Compara con 360
 JME 0BF          ; Si es menor de 360
 JEQ 0C7          ; SI es 360 (Preguntar por flag)
 JMA 0CA          ; Si es mayor de 360
 
 ; Operaciones
 ; Si es menor de 95
 MOV AX,EE0       ; Carga 0 (Si es menor de 95)
 ITOF             ; De 16bits a 32bits
 STF F39          ; Guarda el 0 en el impuesto
 LDF F4D          ; Carga numero de UVT
 JMP 0D1          ; Ir a END
 
 ; Si es igual de 95
 MOV AX,EE0       ; Carga 0
 CMP F2C          ; Compara flag con 0
 JEQ 0AD          ; ir a menor de 95
 
 ; Si es menor de 150
 LDF F4D          ; Numero de UVT
 SUBF F37         ; Se resta 95 UVT
 NOP
 MULF F31         ; Multiplicar por 19%
 MULF F2A         ; Multiplicar por valor UVT
 STF F39          ; Guardar impuesto
 JMP 0D1          ; Saltar a END
 
 ; Si es igual a 150
 MOV AX,EE0       ; Carga 0
 CMP F2C          ; Compara Flag con 0
 JEQ 0B5          ; Ir a menor de 150
 
 ; Si es menor de 360
 LDF F4D          ; Numero de UVT
 SUBF F2E         ; Se resta 150 UVT
 NOP
 MULF F33         ; Multiplicar por 28%
 ADDF F3D         ; Sumar 10
 MULF F2A         ; Multiplicar por valor UVT
 STF F39          ; Guardar impuesto
 JMP 0D1          ; Saltar a end
 
 ; Si es igual a 360
 LDB EE0          ; Carga 0
 CMP F2C          ; Compara Flag con 0
 JEQ 0BF          ; saltar a menor de 360
 
 ; Si es mayor de 360
 LDF F4D          ; carga Numero de UVT
 SUBF F4F         ; Se resta 360 UVT
 NOP
 MULF F35         ; Multiplicar por 33%
 ADDF F3B         ; Sumar 69
 MULF F2A         ; Multiplicar por valor UVT
 STF F39          ; Guardar impuesto

 NOP ; END
 
 ; Restar impuesto
 LDF EE9          ; Cargar el sueldo
 SUBF F39         ; Restar el impuesto
 STF EE9          ; Guardar el nuevo sueldo
 
 ; TOTALES
 ; Total pago grupo
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF EE9        ; multiplica el sueldo de un empleado por la cantidad de empleados
 ADDF F3F        ; Suma al total de sueldo de empleados con el total acumulado
 STF F3F         ; guarda el total de sueldo en memoria
 
 ; Total Aportes a Salud Empleados
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF EF2        ; multiplica lo que paga un empleado de salud por la cantidad de empleados
 ADDF F41        ; Suma al total de salud de empleados del grupo con el total acumulado
 STF F41         ; guarda el total de salud de empleados en memoria
 
 ; Total Aportes a Pension Empleados
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF F02        ; multiplica lo que paga un empleado de pension por la cantidad de empleados
 ADDF F45        ; Suma al total de pension de empleados con el total acumulado
 STF F45         ; guarda el total de pension de empleados en memoria

 ; Total Aportes a Fondo de Solidaridad
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF F1D        ; multiplica lo que paga un empleado de solidaridad por la cantidad de empleados
 ADDF F49        ; Suma al total de solidaridad de empleados con el total acumulado
 STF F49         ; guarda el total de solidaridad de empleados en memoria

 ; Total Aportes a Salud Empresa
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF EF6        ; multiplica lo que paga la empresa de salud por la cantidad de empleados
 ADDF F43        ; Suma el total de salud de empresa con el total acumulado
 STF F43         ; guarda el total de salud de empresa en memoria
 
 ; Total Aportes a Pension Empresa
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF F06        ; multiplica lo que paga la empresa de pension por la cantidad de empleados
 ADDF F47        ; Suma el total de pension de empresa con el total acumulado
 STF F47         ; guarda el total de pension de empresa en memoria
 
 ; Total Impuestos
 LDF F00         ; Carga el numero de empleados en AX-BX
 MULF F39        ; multiplica lo que paga un empleado de impuestos por la cantidad de empleados
 ADDF F4B        ; Suma al total de impuestos de empleados con el total acumulado
 STF F4B         ; guarda el total de impuestos de empleados en memoria

 
; Salida
 MSG Valor a pagar:
 LDF EE9        ; Cargar total pago a empleado del grupo
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
 MSG ------------------------------------------
 MSG Totales de los empleados:
 MSG 1. Sueldo a Pagar
 LDF F3F
 OUT 1,AX
 MSG 2. Aportes a Salud
 LDF F41
 OUT 1,AX
 MSG 3. Aportes a Pension
 LDF F45
 OUT 1,AX
 MSG 4. Aportes Fondo solidaridad
 LDF F49
 OUT 1,AX
 MSG -
 MSG Totales de la empresa
 MSG 1. Aportes a Salud
 LDF F43
 OUT 1,AX
 MSG 2. Aportes a Pension
 LDF F47
 OUT 1,AX
 MSG -
 MSG Total DIAN (Ret. fuente)
 LDF F4B
 OUT 1,AX
 LDT Ingrese cualquier valor para continuar
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
 
#F0A
 0011110000100011
 1101011100000000
 0011110001000100
 1001101110000000
 0011110001100101
 0110000001000000
 0011110010000011
 0001001001100000
 0011110010010011
 0111010010100000
 0011110010100011
 1101011100000000
 
 
#F16
 0000000000000011
 0000000000000100
 0000000000001111
 0000000000010000
 0000000000010001
 0000000000010010
 0000000000010011

#F20
 0000000010010110
 0000000101101000
 
#F26
 0011111010000000
 0000000000000000
 
#F2A
 0100011011011100
 1110111000000000
 
#F30
 0000000001011111
 
#F31
 0011111001000010
 1000111101011100
 0011111010001111
 0101110000101000
 0011111010101000
 1111010111000010

#F3B
 0100001010001010
 0000000000000000
 0100000100100000
 0000000000000000
 
#F3F
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 0000000000000000
 
#F37
 0100001010111110
 0000000000000000
 
#F2E
 0100001100010110
 0000000000000000
 
#F4F
 0100001110110100
 0000000000000000
