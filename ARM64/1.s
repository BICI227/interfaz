
    // Programa: Conversion Celsius a Fahrenheit
    // Descripción: Convierte una temperatura de Celsius a Fahrenheit.
    // Autor: Daniel Ivan Ruiz Pacheco

    .data
celsius:    .float 25.0      // Valor en grados Celsius que se va a convertir
factor9_5:  .float 1.8       // Factor de multiplicación (9/5)
offset:     .float 32.0      // Offset para sumar después de la multiplicación
result:     .float 0.0       // Variable para almacenar el resultado en Fahrenheit

    .text
    .global _start

_start:
    // Cargar el valor en Celsius en un registro de punto flotante
    LDR    X0, =celsius       // Cargar la dirección de celsius en X0
    LDR    S0, [X0]           // Cargar el valor de celsius en S0
    LDR    X1, =factor9_5     // Cargar la dirección de factor9_5 en X1
    LDR    S1, [X1]           // Cargar el valor de factor9_5 en S1
    LDR    X2, =offset        // Cargar la dirección de offset en X2
    LDR    S2, [X2]           // Cargar el valor de offset en S2

    // Realizar la conversión: Fahrenheit = (Celsius * 9/5) + 32
    FMUL   S0, S0, S1         // S0 = Celsius * (9/5)
    FADD   S0, S0, S2         // S0 = Celsius * (9/5) + 32

    // Guardar el resultado en Fahrenheit
    LDR    X3, =result        // Cargar la dirección de result en X3
    STR    S0, [X3]           // Guarda el valor de S0 en result

    // Llamada al sistema para salir
    MOV    X0, #0             // Código de salida 0
    MOV    X8, #93            // Número de syscall para salir en ARM64
    SVC    0                  // Llamada al sistema para salir
