/*
 * serial_debug.c
 *
 *  Created on: 7 Dec 2018
 *      Author: eser
 */


#include <stdio.h>
#include "serial_debug.h"

int _write (int fd, char *ptr, int len)
{
	HAL_UART_Transmit(&debug_uart, (uint8_t*) ptr, len, 0xFFFF);
	return len;
}

int _read (int fd, char *ptr, int len)
{
	*ptr = 0x00; // Flush the character buffer
	HAL_UART_Receive(&debug_uart, (uint8_t*) ptr, 1, 0xFFFF);
return 1;
}


