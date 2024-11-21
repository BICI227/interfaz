// Programa: Implementar una cola usando un arreglo
// Descripción: Implementa la estructura de datos cola utilizando un arreglo.
// Autor: Daniel Ivan Ruiz Pacheco

// Solucion en C#
// ===============================================
/*
using System;

class Cola
{
    private long[] cola;
    private int frente;
    private int fin;
    private int capacidad;

    // Constructor para inicializar la cola con un tamaño máximo
    public Cola(int capacidad)
    {
        this.capacidad = capacidad;
        cola = new long[capacidad];
        frente = 0;
        fin = 0;
    }

    // Método para verificar si la cola está vacía
    public bool EstaVacia()
    {
        return frente == fin;
    }

    // Método para verificar si la cola está llena
    public bool EstaLlena()
    {
        return (fin + 1) % capacidad == frente;
    }

    // Método para encolar un elemento
    public bool Encolar(long valor)
    {
        if (EstaLlena())
        {
            Console.WriteLine("Error: La cola está llena.");
            return false;
        }
        cola[fin] = valor;
        fin = (fin + 1) % capacidad;
        return true;
    }

    // Método para desencolar un elemento
    public long Desencolar()
    {
        if (EstaVacia())
        {
            Console.WriteLine("Error: La cola está vacía.");
            return -1; // Indicador de error
        }
        long valor = cola[frente];
        frente = (frente + 1) % capacidad;
        return valor;
    }

    // Método para ver el primer elemento sin quitarlo
    public long VerFrente()
    {
        if (EstaVacia())
        {
            Console.WriteLine("Error: La cola está vacía.");
            return -1; // Indicador de error
        }
        return cola[frente];
    }
}

class Program
{
    static void Main()
    {
        Console.Write("Ingrese el tamaño de la cola: ");
        int tamano = Convert.ToInt32(Console.ReadLine());
        
        Cola cola = new Cola(tamano);
        int opcion;

        do
        {
            Console.WriteLine("\nMenú Cola:");
            Console.WriteLine("1. Encolar");
            Console.WriteLine("2. Desencolar");
            Console.WriteLine("3. Ver el primer elemento (frente)");
            Console.WriteLine("4. Verificar si está vacía");
            Console.WriteLine("5. Verificar si está llena");
            Console.WriteLine("0. Salir");
            Console.Write("Seleccione una opción: ");
            
            if (int.TryParse(Console.ReadLine(), out opcion))
            {
                switch (opcion)
                {
                    case 1:
                        Console.Write("Ingrese el valor a encolar: ");
                        if (long.TryParse(Console.ReadLine(), out long valor))
                        {
                            if (cola.Encolar(valor))
                            {
                                Console.WriteLine($"Valor {valor} encolado exitosamente.");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error: Ingrese un número válido.");
                        }
                        break;

                    case 2:
                        long valorDesencolado = cola.Desencolar();
                        if (valorDesencolado != -1)
                        {
                            Console.WriteLine($"Valor desencolado: {valorDesencolado}");
                        }
                        break;

                    case 3:
                        long valorFrente = cola.VerFrente();
                        if (valorFrente != -1)
                        {
                            Console.WriteLine($"El primer valor en la cola es: {valorFrente}");
                        }
                        break;

                    case 4:
                        if (cola.EstaVacia())
                        {
                            Console.WriteLine("La cola está vacía.");
                        }
                        else
                        {
                            Console.WriteLine("La cola no está vacía.");
                        }
                        break;

                    case 5:
                        if (cola.EstaLlena())
                        {
                            Console.WriteLine("La cola está llena.");
                        }
                        else
                        {
                            Console.WriteLine("La cola no está llena.");
                        }
                        break;

                    case 0:
                        Console.WriteLine("Saliendo del programa...");
                        break;

                    default:
                        Console.WriteLine("Opción no válida.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Error: Ingrese un número válido.");
                opcion = -1;
            }

        } while (opcion != 0);
    }
}

*/

// ===============================================
// Archivo C
// ===============================================
/*
#include <stdio.h>
#include <stdlib.h>

// Declaraciones externas para las funciones en ensamblador
extern void init_cola();
extern long enqueue(long value);
extern long dequeue();
extern int is_empty();
extern int is_full();

int main() {
    int opcion;
    long valor, resultado, valorDesencolado;

    // Inicializar la cola
    init_cola();

    do {
        printf("\nMenú Cola:\n");
        printf("1. Encolar (Enqueue)\n");
        printf("2. Desencolar (Dequeue)\n");
        printf("3. Verificar si está vacía\n");
        printf("4. Verificar si está llena\n");
        printf("0. Salir\n");
        printf("Seleccione una opción: ");
        
        if (scanf("%d", &opcion) != 1) {
            printf("Error: Ingrese un número válido.\n");
            // Limpiar el buffer de entrada en caso de error de lectura
            while (getchar() != '\n');
            opcion = -1;
        }

        switch (opcion) {
            case 1:
                printf("Ingrese el valor a encolar: ");
                if (scanf("%ld", &valor) != 1) {
                    printf("Error: Ingrese un número válido.\n");
                    break;
                }
                resultado = enqueue(valor);
                if (resultado == -1) {
                    printf("Error: La cola está llena.\n");
                } else {
                    printf("Valor %ld encolado exitosamente.\n", valor);
                }
                break;

            case 2:
                valorDesencolado = dequeue();
                if (valorDesencolado == -1) {
                    printf("Error: La cola está vacía.\n");
                } else {
                    printf("Valor desencolado: %ld\n", valorDesencolado);
                }
                break;

            case 3:
                if (is_empty() == 1) {
                    printf("La cola está vacía.\n");
                } else {
                    printf("La cola no está vacía.\n");
                }
                break;

            case 4:
                if (is_full() == 1) {
                    printf("La cola está llena.\n");
                } else {
                    printf("La cola no está llena.\n");
                }
                break;

            case 0:
                printf("Saliendo del programa...\n");
                break;

            default:
                printf("Opción no válida.\n");
                break;
        }
    } while (opcion != 0);

    return 0;
}

*/

.data
cola: .word 32145435, 5345, 12345, 6789, 10234  // Arreglo que simula la cola con 5 elementos
tamano: .word 5                                 // Tamaño de la cola (definido directamente)

msg_cola: .string "El contenido de la cola es: %d\n"  

.text
.global main
.align 2

main:
    // Prologo de la función main
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Inicializar el acumulador y el índice
    mov     w0, #0                    // Acumulador de la suma
    mov     w1, #5                    // Tamaño de la cola
    adrp    x2, cola                  // Dirección base del arreglo que simula la cola
    add     x2, x2, :lo12:cola

loop_cola:
    cbz     w1, fin_cola              // Si el tamaño es 0, terminar el bucle

    ldr     w3, [x2], #4              // Cargar el siguiente elemento de la cola y avanzar la dirección
    add     w0, w0, w3                // Sumar el elemento al acumulador
    sub     w1, w1, #1                // Decrementar el tamaño (contador de elementos)

    b       loop_cola                 // Repetir para el siguiente elemento

fin_cola:
    // Imprimir el resultado acumulado
    adrp    x0, msg_cola              // Cargar el mensaje para printf
    add     x0, x0, :lo12:msg_cola
    mov     w1, w0                    // Pasar el contenido acumulado de la cola a w1 para printf
    bl      printf

    // Epílogo de la función main
    ldp     x29, x30, [sp], #16       // Restaurar el frame pointer y el link register
    mov     x0, #0                    // Código de salida 0
    ret
