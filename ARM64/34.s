// Programa: Invertir los elementos de un arreglo
// Descripción: Invierte el orden de los elementos en un arreglo.
// Autor: Daniel Ivan Ruiz Pacheco

// Solucion en C#
// ===============================================

/*
using System;

class Program
{
    // Función para invertir los elementos de un arreglo
    static void InvertirArreglo(int[] arreglo)
    {
        int inicio = 0;
        int fin = arreglo.Length - 1;

        // Intercambiar los elementos desde el principio y el final hasta llegar al medio
        while (inicio < fin)
        {
            int temp = arreglo[inicio];
            arreglo[inicio] = arreglo[fin];
            arreglo[fin] = temp;

            inicio++;
            fin--;
        }
    }

    static void Main()
    {
        // Definir un arreglo de enteros
        int[] arreglo = { 1, 2, 3, 4, 5 };

        // Mostrar el arreglo original
        Console.WriteLine("Arreglo original:");
        MostrarArreglo(arreglo);

        // Invertir el arreglo
        InvertirArreglo(arreglo);

        // Mostrar el arreglo invertido
        Console.WriteLine("\nArreglo invertido:");
        MostrarArreglo(arreglo);
    }

    // Función para mostrar los elementos de un arreglo
    static void MostrarArreglo(int[] arreglo)
    {
        foreach (int numero in arreglo)
        {
            Console.Write(numero + " ");
        }
        Console.WriteLine();
    }
}
*/

.section .text
.global invert_array

// Función que invierte un arreglo de enteros
// Parámetros:
// x0 = dirección del arreglo
// w1 = longitud del arreglo
invert_array:
    // Calcular la dirección del último elemento
    mov w2, w1              // Copiar la longitud en w2
    sub w2, w2, 1           // Restar 1 para obtener el índice final
    lsl w2, w2, 2           // Multiplicar por 4 (tamaño de un entero en bytes)
    add x3, x0, x2          // x3 apunta al último elemento

invert_loop:
    cmp x0, x3              // Comparar las direcciones de los extremos
    bge end_invert          // Si se cruzan o se encuentran, salir del bucle

    ldr w4, [x0]            // Cargar el elemento desde el extremo izquierdo
    ldr w5, [x3]            // Cargar el elemento desde el extremo derecho
    str w5, [x0]            // Escribir el elemento derecho en el extremo izquierdo
    str w4, [x3]            // Escribir el elemento izquierdo en el extremo derecho

    add x0, x0, 4           // Avanzar al siguiente elemento desde la izquierda
    sub x3, x3, 4           // Retroceder al siguiente elemento desde la derecha
    b invert_loop           // Repetir el bucle

end_invert:
    ret                     // Retornar al código de C
