// Programa: Convertir decimal a binario
// Descripción: Convierte un número decimal en su representación binaria.
// Autor: Daniel Ivan Ruiz Pacheco

// Solucion en C#
// ===============================================

/*
using System;

class Program
{
    static string DecimalToBinary(long number)
    {
        // Si el número es 0, devolver "0"
        if (number == 0)
        {
            return "0";
        }

        string binary = "";

        // Convertir el número decimal a binario
        while (number > 0)
        {
            binary = (number % 2) + binary;  // Concatenar el residuo al inicio
            number /= 2;  // Dividir el número entre 2
        }

        return binary;
    }

    static void Main()
    {
        Console.WriteLine("Conversor de Decimal a Binario");

        while (true)
        {
            Console.Write("\nIngrese un número decimal: ");
            if (long.TryParse(Console.ReadLine(), out long number))
            {
                string binary = DecimalToBinary(number);  // Convertir a binario
                Console.WriteLine($"Número decimal: {number}");
                Console.WriteLine($"Número binario: {binary}");
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
            }

            Console.Write("\n¿Desea convertir otro número? (s/n): ");
            string answer = Console.ReadLine();
            if (answer.ToLower() != "s")
            {
                break;  // Salir si el usuario no quiere continuar
            }
        }
    }
}

*/


// ===============================================
// Archivo C
// ===============================================

/*
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  // Incluir string.h para usar strlen

extern void decimal_to_binary(long number);  // Declarar las funciones del ensamblador
extern long get_bit(int index);
extern int get_size();

// Función para obtener la representación binaria de un número
void get_binary_string(long number, char *result)
{
    decimal_to_binary(number);
    int size = get_size();

    // Construir el string binario desde el último bit hasta el primero
    for (int i = size - 1; i >= 0; i--)
    {
        result[size - 1 - i] = get_bit(i) + '0';  // Convertir bit a caracter
    }
    result[size] = '\0';  // Finalizar la cadena de caracteres
}

int main()
{
    while (1)
    {
        int opcion;
        printf("\nConversor de Decimal a Binario\n");
        printf("1. Convertir número\n");
        printf("0. Salir\n");
        printf("Seleccione una opción: ");

        if (scanf("%d", &opcion) != 1)
        {
            printf("Error: Ingrese un número válido.\n");
            while (getchar() != '\n');  // Limpiar el buffer de entrada
            continue;
        }

        switch (opcion)
        {
        case 1:
        {
            long numero;
            printf("\nIngrese un número decimal (0-9223372036854775807): ");
            if (scanf("%ld", &numero) != 1)
            {
                printf("Error: Ingrese un número válido.\n");
                while (getchar() != '\n');  // Limpiar el buffer de entrada
                break;
            }

            if (numero < 0)
            {
                printf("Por favor, ingrese un número positivo.\n");
                break;
            }

            char binario[65];  // Buffer para la cadena binaria (máximo 64 bits + 1 para el '\0')
            get_binary_string(numero, binario);
            printf("\nNúmero decimal: %ld\n", numero);
            printf("Número binario: %s\n", binario);

            // Mostrar información adicional
            printf("Cantidad de bits: %lu\n", strlen(binario));  // Uso de strlen
            if (binario[0] != '\0')
            {
                printf("Bit más significativo: %c\n", binario[0]);
                printf("Bit menos significativo: %c\n", binario[strlen(binario) - 1]);
            }
            break;
        }
        case 0:
            printf("Saliendo del programa...\n");
            return 0;

        default:
            printf("Opción no válida.\n");
            break;
        }
    }

    return 0;
}

*/

.data
num_decimal: .word 29                      // Número decimal de ejemplo (29 en este caso)
msg_binario: .string "El binario es: %s\n" // Mensaje de salida
binario: .space 33                         // Cadena para almacenar el binario (32 bits + nulo)

.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Cargar el número decimal
    adrp    x0, num_decimal               // Cargar la base de la dirección de 'num_decimal'
    add     x0, x0, :lo12:num_decimal     // Completa la dirección de 'num_decimal'
    ldr     w1, [x0]                      // Cargar el valor decimal en w1

    // Inicialización
    adrp    x2, binario                   // Cargar la base de la dirección de 'binario'
    add     x2, x2, :lo12:binario         // Completa la dirección de 'binario'
    mov     w3, #32                       // Contador para 32 bits

loop_conversion:
    subs    w3, w3, #1                    // Decrementa el contador de bits
    lsr     w4, w1, w3                    // Desplaza el número a la derecha
    and     w4, w4, #1                    // Aisla el bit menos significativo
    add     w4, w4, '0'                   // Convierte el bit en carácter ASCII ('0' o '1')
    strb    w4, [x2], #1                  // Almacena el carácter en la cadena y avanza el puntero

    cbnz    w3, loop_conversion           // Repite hasta procesar los 32 bits

    // Terminar la cadena con un nulo
    mov     w4, #0                        // Terminador nulo
    strb    w4, [x2]

    // Imprimir el resultado
    adrp    x0, msg_binario               // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_binario
    adrp    x1, binario                   // Cargar la dirección base de 'binario' para printf
    add     x1, x1, :lo12:binario
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16           // Restaurar el frame pointer y el link register
    mov     x0, #0                        // Código de salida 0
    ret
