// Programa: Máximo Común Divisor (MCD)
// Descripción: Calcula el MCD de dos números utilizando el algoritmo de Euclides.
// Autor: Daniel Ivan Ruiz Pacheco

// Solucion en C#
// ===============================================

/*
using System;

class Program
{
    // Método para calcular el MCD utilizando el algoritmo de Euclides
    static int CalcularMCD(int a, int b)
    {
        while (b != 0)
        {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    static void Main()
    {
        // Solicitar los números al usuario
        Console.Write("Introduce el primer número: ");
        int num1 = int.Parse(Console.ReadLine());

        Console.Write("Introduce el segundo número: ");
        int num2 = int.Parse(Console.ReadLine());

        // Calcular el MCD
        int mcd = CalcularMCD(num1, num2);

        // Mostrar el resultado
        Console.WriteLine($"El Máximo Común Divisor de {num1} y {num2} es: {mcd}");
    }
}

*/

.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!   // Guardar el frame pointer (fp) y el link register (lr)
    mov     x29, sp                 // Establecer nuevo frame pointer

    // Valores de entrada: colocar en w0 y w1
    mov     w0, #56                 // Ejemplo: primer número
    mov     w1, #98                 // Ejemplo: segundo número

    // Llamar a la función que calcula el MCD
    bl      calcular_mcd

    // Imprimir el resultado (w0 contiene el MCD)
    // Asumiendo que tienes una función de impresión configurada con printf
    adrp    x0, msg_mcd             // Cargar mensaje de formato para printf
    add     x0, x0, :lo12:msg_mcd
    mov     w1, w0                  // Pasar el MCD a w1 como argumento para printf
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16     // Restaurar el frame pointer y el link register
    mov     x0, #0                  // Código de salida 0
    ret

// Función calcular_mcd
// Entrada: w0 = primer número, w1 = segundo número
// Salida: w0 = MCD de los dos números
calcular_mcd:
    stp     x29, x30, [sp, #-16]!   // Guardar el frame pointer (fp) y el link register (lr)
    mov     x29, sp                 // Establecer nuevo frame pointer

loop_mcd:
    cmp     w1, #0                  // Comparar w1 con 0
    beq     fin                     // Si w1 es 0, fin (MCD está en w0)
    udiv    w2, w0, w1              // w2 = w0 / w1 (división entera)
    msub    w2, w2, w1, w0          // w2 = w0 - (w2 * w1) -> residuo
    mov     w0, w1                  // w0 = w1 (intercambiar)
    mov     w1, w2                  // w1 = residuo
    b       loop_mcd                // Repetir hasta que w1 sea 0

fin:
    ldp     x29, x30, [sp], #16     // Restaurar el frame pointer y el link register
    ret                             // Retornar el MCD en w0

// Datos
.data
msg_mcd: .string "El MCD es: %d\n"
