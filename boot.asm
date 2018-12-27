MBALIGN equ 1 << 0 ; Flagi dla multiboot
MEMINFO equ 1 << 1
FLAGS equ MBALIGN | MEMINFO
MAGIC equ 0x1BADB002
CHECKSUM equ -(MAGIC + FLAGS) ; Suma kontrolna + flagi = 0

section .multiboot
align 4 ; wymóg multiboot
    dd MAGIC ;  układamy flagi
    dd FLAGS
    dd CHECKSUM

section .bss ; tworzymy stos
align 16 ; zgodnie z System V ABI stack musi być 16 bajtowo
         ; wyrównany
stack_bottom: ; dół stacku
resb 16384; to 16 KiB
stack_top: ; góra stacku

section .text
global _start:function (_start.end - _start) ; zadeklaruj symbol
_start:
    mov esp, stack_top ; ustawiamy stos

    extern kernel_main
    call kernel_main ; wywołujemy jądro

    cli ; jeśli jądro coś zwróci

.hang:
    hlt ; czekaj na przerwanie, ale dlatego, że ich nie ma, będzie
        ; czekał w nieskończość
    jmp .hang ; ale jeśli jednak wyjdzie z powodu ACPI, to wróć

.end: ; do symbolu
