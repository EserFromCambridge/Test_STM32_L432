/*
 * trace.c
 *
 *  Created on: 7 Dec 2018
 *      Author: eser
 *
 *      This is a logging file which can be used in C and C++ projects in order
 *      to debug the code and log different variables to different envoirenments.
 *      It uses Dynamic memory allocation so that like in the basic receiver
 *      task example, pointer of the data taken from the queue must be freed
 *      after using it. Library uses printf function, If developer does not have
 *      enough code space for this library, it's welcome to replace printf to its
 *      own print function. Surely number formation with the strings can be used anymore.
 *      If there is enough space printf can be used to see the variables and strings together.
 *
 */

#include "FreeRTOS.h"
#include "trace.h"
#include "timers.h"
#include "semphr.h"
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>


// Add different task or subsystem names and enum values to this array and to the
// log_holder_t enum structure in the header file.
// After than you can use that name in order to trace your code by using its holder name.
const char * const LOG_NAME[SUBSYSTEM] = {
	"MAIN",
	"TASK1",
	"TASK2",
	"TASK3"
};

const char * const LOG_LEVEL[LOG_DEPTH] = {
	"NONE",
	"ERR",
	"WRN",
	"CRT",
	"INF",
	"DBG"
};

// In order to use this logging file a queue and a mutex(binary semphore) must
// be created in the main file of your project with the below names
extern QueueHandle_t		log_queue_ptr;
extern SemaphoreHandle_t	queue_mutex;



// ************************************************************************** //
// ************************ 	logMsgToQueue		 ************************ //
// ************************************************************************** //
void logMsgToQueue(log_holder_t holder, log_target_t target, log_level_t level, const char *msg, ...) {
#if GLOBAL_DEBUG
	BaseType_t xStatus;
	xSemaphoreTake(queue_mutex, portMAX_DELAY);
	{
		va_list args;
		va_start(args, msg);
		log_queue_t * log = (log_queue_t *)malloc(sizeof(log_queue_t));
		log->time = xTaskGetTickCount();
		log->name = holder;
		log->target = target;
		log->log_catg = DEVICE_MSG;
		log->debug_level = level;
		vsnprintf(log->content.message, sizeof(log->content.message), msg, args);

		xStatus = xQueueSendToBack(log_queue_ptr, &log, pdMS_TO_TICKS(50));
		if(xStatus != pdPASS) {
			printf("Task1 could not send to the queue\n\r");
		}
		va_end(args);
	}
	xSemaphoreGive(queue_mutex);
#else

#endif
}


// ************************************************************************** //
// ************************ 	logDataToQueue		 ************************ //
// ************************************************************************** //
void logDataToQueue(log_holder_t holder, log_target_t target, log_level_t level, log_data_t data) {
#if GLOBAL_DEBUG
	BaseType_t xStatus;
	xSemaphoreTake(queue_mutex, portMAX_DELAY);
	{
		log_queue_t * log = (log_queue_t *)malloc(sizeof(log_queue_t));
		log->time = xTaskGetTickCount();
		log->name = holder;
		log->target = target;
		log->log_catg = DEVICE_DATA;
		log->debug_level = level;
		log->content.data = data;

		xStatus = xQueueSendToBack(log_queue_ptr, &log, pdMS_TO_TICKS(50));
		if(xStatus != pdPASS) {
			printf("Task1 could not send to the queue\n\r");
		}
	}
	xSemaphoreGive(queue_mutex);
#else

#endif
}


/*
 * 	A possible basic receive task from the queue and print them to the screen.
 *
 *
 * 	BaseType_t xStatus;
	log_queue_t *log_ptr;
	const TickType_t xDelay = pdMS_TO_TICKS(300);

	for(;;) {
		// write o trace queue
		xStatus = xQueueReceive(log_queue_ptr, &log_ptr, xDelay);
		if(xStatus != pdPASS) {
			printf("Task0 could not receive from the queue\n\r");
		} else {
			if(log_ptr->log_catg == DEVICE_MSG) {
				printf("[%lu] [ %-15s ][%s]: %s \n", log_ptr->time, LOG_NAME[log_ptr->name],
				LOG_LEVEL[log_ptr->debug_level], log_ptr->content.message);
			} else if (log_ptr->log_catg == DEVICE_DATA) {
				printf("[%lu] [ %-15s ][%s]: %f  %f  %f  %d \n", log_ptr->time,
						LOG_NAME[log_ptr->name], LOG_LEVEL[log_ptr->debug_level],
						log_ptr->content.data.f1, log_ptr->content.data.f2,
						log_ptr->content.data.d1, log_ptr->content.data.i1);
			}
		}
		free(log_ptr);
	}
	vTaskDelete(NULL);
 *
 */
