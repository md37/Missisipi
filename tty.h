#ifndef TTY_H
#define TTY_H

#include <stddef.h>

void terminal_initialize(void);
void terminal_putchar(char c);
void terminal_write(conts char* data, size_t size);
void terminal_writestring(const char* data);

#endif TTY_H // TTY_H