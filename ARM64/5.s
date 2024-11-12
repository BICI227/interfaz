// Autor: Daniel Ivan Ruiz Pacheco
// Programa en ARM64 para dividir dos números


// Equivalente en C:
// int num1 = 4;
// int num2 = 5;
// int suma = num1 / num2;





.section .data
num1: .word 4        // Primer número a dividir
num2: .word 5         // Segundo número a dividir

.section .text
.global _start

_start:
    // Cargar los números en registros
    LDR w0, =num1       // Cargar num1 en el registro w0
    LDR w1, =num2       // Cargar num2 en el registro w1

    // Realizar la suma
    SDIV w2, w0, w1      // Multiplicar w0 y w1, guardar en w2

    // Finalizar el programa
    MOV w8, #93         // Código para salir en Linux
    SVC #0              // Llamada al sistema para salir
