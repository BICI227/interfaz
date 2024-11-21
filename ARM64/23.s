// Programa: Conversión de entero a ASCII
// Descripción: Convierte un número entero en su carácter ASCII correspondiente.
// Autor: Daniel Ivan Ruiz Pacheco

// Solucion en C#
// ===============================================
/*
using System;

class Program
{
    static void Main()
    {
        Console.Write("Ingresa un número entero: ");
        int numero = int.Parse(Console.ReadLine());

        // Convertir el número entero a una cadena ASCII
        string cadenaASCII = EnteroAAscii(numero);
        
        Console.WriteLine("El número convertido a ASCII es: " + cadenaASCII);
    }

    static string EnteroAAscii(int numero)
    {
        // Si el número es 0, devolvemos directamente "0"
        if (numero == 0)
            return "0";

        // Almacenamos el resultado de la conversión
        string resultado = "";

        // Variable para gestionar el signo de los números negativos
        bool esNegativo = false;

        // Si el número es negativo, guardamos el signo y convertimos a positivo
        if (numero < 0)
        {
            esNegativo = true;
            numero = -numero;  // Hacemos el número positivo para procesarlo
        }

        // Convertir el número a cadena extrayendo cada dígito
        while (numero > 0)
        {
            int digito = numero % 10;               // Obtener el último dígito
            char digitoChar = (char)(digito + '0'); // Convertir a carácter ASCII
            resultado = digitoChar + resultado;     // Agregar el carácter al inicio de la cadena
            numero /= 10;                           // Eliminar el último dígito
        }

        // Agregar el signo negativo si es necesario
        if (esNegativo)
            resultado = "-" + resultado;

        return resultado;
    }
}

*/

.section .data
    result: .skip 10              // Reservar espacio para la cadena de salida (máximo 10 dígitos)

.section .text
.global _start
_start:
    MOV x0, 12345                // El número a convertir a ASCII
    ADRP x1, result              // Cargar la dirección base de la cadena de resultado
    ADD x1, x1, :lo12:result     // Obtener la dirección de result
    MOV x2, 0                    // Índice para escribir en la cadena (comienza en 0)
    MOV x3, 10                   // Guardar el valor 10 en un registro para la división y multiplicación

convert_loop:
    UDIV x4, x0, x3              // Dividir el número entre 10 (obtener el cociente)
    MUL x5, x4, x3               // Multiplicar el cociente por 10 (obtener el residuo)
    SUB x6, x0, x5               // Resto de la división (el último dígito)
    ADD x6, x6, #48              // Convertir el dígito a su valor ASCII
    STRB w6, [x1, x2]            // Almacenar el dígito como carácter ASCII en la cadena
    ADD x2, x2, #1               // Avanzar el índice en la cadena
    MOV x0, x4                   // El nuevo número es el cociente
    CMP x0, #0                   // Comprobar si el número es 0
    BNE convert_loop             // Si no es 0, continuar el ciclo

    // Finalizar la cadena de caracteres con el terminador nulo (0)
    MOV w5, #0                   // Valor nulo (0)
    STRB w5, [x1, x2]            // Colocar el terminador nulo al final de la cadena

    // Imprimir la cadena resultante
    MOV x0, 1                    // Descriptor de archivo para stdout
    ADRP x1, result              // Dirección de la cadena
    ADD x1, x1, :lo12:result
    MOV x2, x2                   // Longitud de la cadena (el índice actual)
    MOV x8, 64                   // Syscall para write
    SVC 0                        // Llamada al sistema

    // Terminar el programa
    MOV x8, 93                   // Syscall para exit
    MOV x0, 0                    // Código de salida
    SVC 0                        // Llamada al sistema
