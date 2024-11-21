// Programa: Rotación de un arreglo (izquierda/derecha)
// Descripción: Rota los elementos de un arreglo a la izquierda o derecha.
// Autor: Daniel Ivan Ruiz Pacheco

// Solucion en C#
// ===============================================

/*
using System;

class Program
{
    // Función para rotar el arreglo hacia la izquierda
    static void RotarIzquierda(int[] arreglo, int posiciones)
    {
        int n = arreglo.Length;
        posiciones = posiciones % n; // En caso de que posiciones sea mayor que el tamaño del arreglo
        int[] temp = new int[posiciones];

        // Guardar los primeros elementos que se desplazarán al final
        Array.Copy(arreglo, 0, temp, 0, posiciones);

        // Desplazar los elementos del arreglo a la izquierda
        Array.Copy(arreglo, posiciones, arreglo, 0, n - posiciones);

        // Copiar los elementos guardados al final del arreglo
        Array.Copy(temp, 0, arreglo, n - posiciones, posiciones);
    }

    // Función para rotar el arreglo hacia la derecha
    static void RotarDerecha(int[] arreglo, int posiciones)
    {
        int n = arreglo.Length;
        posiciones = posiciones % n; // En caso de que posiciones sea mayor que el tamaño del arreglo
        int[] temp = new int[posiciones];

        // Guardar los últimos elementos que se desplazarán al principio
        Array.Copy(arreglo, n - posiciones, temp, 0, posiciones);

        // Desplazar los elementos del arreglo a la derecha
        Array.Copy(arreglo, 0, arreglo, posiciones, n - posiciones);

        // Copiar los elementos guardados al principio del arreglo
        Array.Copy(temp, 0, arreglo, 0, posiciones);
    }

    static void Main()
    {
        // Solicitar el número de elementos en el arreglo
        Console.WriteLine("Introduce el número de elementos en el arreglo:");
        int n = Convert.ToInt32(Console.ReadLine());
        int[] arreglo = new int[n];

        // Solicitar los elementos del arreglo
        Console.WriteLine("Introduce los elementos del arreglo:");
        for (int i = 0; i < n; i++)
        {
            Console.Write($"Elemento {i + 1}: ");
            arreglo[i] = Convert.ToInt32(Console.ReadLine());
        }

        // Solicitar la dirección y las posiciones de rotación
        Console.WriteLine("Introduce la dirección de rotación (izquierda/derecha):");
        string direccion = Console.ReadLine().ToLower();

        Console.WriteLine("Introduce el número de posiciones a rotar:");
        int posiciones = Convert.ToInt32(Console.ReadLine());

        // Realizar la rotación
        if (direccion == "izquierda")
        {
            RotarIzquierda(arreglo, posiciones);
        }
        else if (direccion == "derecha")
        {
            RotarDerecha(arreglo, posiciones);
        }
        else
        {
            Console.WriteLine("Dirección no válida. Debe ser 'izquierda' o 'derecha'.");
            return;
        }

        // Mostrar el arreglo rotado
        Console.WriteLine("Arreglo después de la rotación:");
        foreach (int elemento in arreglo)
        {
            Console.Write(elemento + " ");
        }
        Console.WriteLine();
    }
}
*/


.data
    array:      .quad   1000000000000, 2000000000000, 3000000000000, 4000000000000, 5000000000000    // Números de 64 bits
    len:        .quad   5                 // Longitud del array
    positions:  .quad   2                 // Número de posiciones a rotar
    msg_left:   .asciz  "Array rotado a la izquierda: "
    msg_right:  .asciz  "Array rotado a la derecha: "
    newline:    .asciz  "\n"
    space:      .asciz  " "
    buffer:     .skip   32               // Buffer para conversión de números

.text
.global _start

_start:
    // Guardar dirección de retorno
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Cargar dirección base del array
    adr     x19, array
    // Cargar longitud del array
    ldr     x20, len
    // Cargar número de posiciones a rotar
    ldr     x21, positions

    // Imprimir mensaje izquierda
    adr     x0, msg_left
    bl      print_string

    // Llamar a rotación izquierda
    mov     x0, x19          // Array
    mov     x1, x20          // Longitud
    mov     x2, x21          // Posiciones
    bl      rotate_left
    
    // Imprimir array
    mov     x0, x19
    mov     x1, x20
    bl      print_array
    
    // Imprimir nueva línea
    adr     x0, newline
    bl      print_string

    // Restaurar array original
    adr     x19, array

    // Imprimir mensaje derecha
    adr     x0, msg_right
    bl      print_string

    // Llamar a rotación derecha
    mov     x0, x19          // Array
    mov     x1, x20          // Longitud
    mov     x2, x21          // Posiciones
    bl      rotate_right
    
    // Imprimir array
    mov     x0, x19
    mov     x1, x20
    bl      print_array
    
    // Imprimir nueva línea
    adr     x0, newline
    bl      print_string

    // Salir del programa
    mov     x0, #0
    mov     x8, #93
    svc     #0

// Función para rotar a la izquierda
rotate_left:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Ajustar posiciones si es mayor que la longitud
    udiv    x3, x2, x1
    msub    x2, x3, x1, x2

rotate_left_loop:
    cbz     x2, rotate_left_end
    
    // Guardar primer elemento
    ldr     x4, [x0]
    
    // Mover elementos una posición a la izquierda
    mov     x5, #0          // índice
shift_left_loop:
    add     x6, x5, #1
    cmp     x6, x1
    b.ge    shift_left_end
    
    ldr     x7, [x0, x6, lsl #3]
    str     x7, [x0, x5, lsl #3]
    
    add     x5, x5, #1
    b       shift_left_loop
shift_left_end:

    // Colocar primer elemento al final
    sub     x5, x1, #1
    str     x4, [x0, x5, lsl #3]
    
    sub     x2, x2, #1
    b       rotate_left_loop

rotate_left_end:
    ldp     x29, x30, [sp], #16
    ret

// Función para rotar a la derecha
rotate_right:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Ajustar posiciones si es mayor que la longitud
    udiv    x3, x2, x1
    msub    x2, x3, x1, x2

rotate_right_loop:
    cbz     x2, rotate_right_end
    
    // Guardar último elemento
    sub     x4, x1, #1
    ldr     x5, [x0, x4, lsl #3]
    
    // Mover elementos una posición a la derecha
    mov     x6, x4          // índice
shift_right_loop:
    cbz     x6, shift_right_end
    
    sub     x7, x6, #1
    ldr     x8, [x0, x7, lsl #3]
    str     x8, [x0, x6, lsl #3]
    
    sub     x6, x6, #1
    b       shift_right_loop
shift_right_end:

    // Colocar último elemento al inicio
    str     x5, [x0]
    
    sub     x2, x2, #1
    b       rotate_right_loop

rotate_right_end:
    ldp     x29, x30, [sp], #16
    ret

// Función para imprimir el array
print_array:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    mov     x21, x0         // Guardar dirección del array
    mov     x22, x1         // Guardar longitud

    mov     x23, #0         // índice
print_loop:
    cmp     x23, x22
    b.ge    print_end
    
    ldr     x0, [x21, x23, lsl #3]
    bl      print_num
    
    add     x23, x23, #1
    b       print_loop
print_end:
    ldp     x29, x30, [sp], #16
    ret

// Función para imprimir un número
print_num:
    stp     x29, x30, [sp, #-32]!
    stp     x19, x20, [sp, #16]
    mov     x29, sp
    
    mov     x19, x0         // Guardar número original
    adr     x20, buffer
    mov     x2, #0          // contador de dígitos
    
    // Si el número es 0, manejar caso especial
    cmp     x19, #0
    b.ne    convert_loop
    
    mov     w3, #'0'
    strb    w3, [x20]
    mov     x2, #1
    b       print_digits

convert_loop:
    // Dividir por 10
    mov     x3, #10
    udiv    x4, x19, x3     // cociente
    msub    x5, x4, x3, x19 // resto
    
    // Convertir a ASCII y guardar
    add     w5, w5, #'0'
    strb    w5, [x20, x2]
    
    add     x2, x2, #1
    mov     x19, x4
    
    cbnz    x19, convert_loop

print_digits:
    // Invertir dígitos
    mov     x3, #0          // inicio
    sub     x4, x2, #1      // fin

reverse_loop:
    cmp     x3, x4
    b.ge    print_buffer
    
    ldrb    w5, [x20, x3]
    ldrb    w6, [x20, x4]
    strb    w6, [x20, x3]
    strb    w5, [x20, x4]
    
    add     x3, x3, #1
    sub     x4, x4, #1
    b       reverse_loop

print_buffer:
    mov     x0, #1          // stdout
    mov     x1, x20         // buffer
    mov     x8, #64         // syscall write
    svc     #0
    
    // Imprimir espacio
    mov     x0, #1
    adr     x1, space
    mov     x2, #1
    mov     x8, #64
    svc     #0
    
    ldp     x19, x20, [sp, #16]
    ldp     x29, x30, [sp], #32
    ret

// Función para imprimir una cadena
print_string:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    mov     x2, #0
str_len_loop:
    ldrb    w1, [x0, x2]
    cbz     w1, str_len_done
    add     x2, x2, #1
    b       str_len_loop
str_len_done:

    mov     x1, x0          // dirección de la cadena
    mov     x0, #1          // stdout
    mov     x8, #64         // syscall write
    svc     #0
    
    ldp     x29, x30, [sp], #16
    ret
