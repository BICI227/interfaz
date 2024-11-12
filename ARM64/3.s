// Autor: Daniel Ivan Ruiz Pacheco
// Programa en ARM64 para restar dos números


// Equivalente en C:
// int num1 = 10;
// int num2 = 7;
// int suma = num1 + num2;





.section .data
num1: .word 10        // Primer número a sumar
num2: .word 7         // Segundo número a sumar

.section .text
.global _start

_start:
    // Cargar los números en registros
    LDR w0, =num1       // Cargar num1 en el registro w0
    LDR w1, =num2       // Cargar num2 en el registro w1

    // Realizar la suma
    SUB w2, w0, w1      // Sumar w0 y w1, guardar en w2

    // Finalizar el programa
    MOV w8, #93         // Código para salir en Linux
    SVC #0              // Llamada al sistema para salir
