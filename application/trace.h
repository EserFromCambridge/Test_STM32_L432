/*
 * trace.h
 *
 *  Created on: 7 Dec 2018
 *      Author: eser
 */


#ifndef APPLICATION_TRACE_H_
#define APPLICATION_TRACE_H_

typedef enum {
	MAIN		= 0,
	TASK1		= 1,
	TASK2		= 2,
	TASK3		= 3
}log_holder_t;

typedef enum {
	NONE		= 0,
	ERR			= 1,
	WRN			= 2,
	CRT			= 3,
	INF			= 4,
	DBG			= 5
}log_level_t;

typedef enum {
	SCREEN		= 0,
	SD_CARD		= 1
}log_target_t;

typedef enum {
	DEVICE_MSG  = 0,
	DEVICE_DATA	= 1
}log_category_t;

typedef struct {
	// this must be defined by the application writer regarding to app's data
	float f1;
	float f2;
	double d1;
	uint32_t i1;
}log_data_t;

typedef struct {
	volatile TickType_t		time;
	log_holder_t			name;
	log_target_t			target;
	log_category_t 			log_catg;
	log_level_t				debug_level;
	union {
		char				message[255];
		log_data_t			data;
	}content;
}log_queue_t;


#define QUEUE_LOG_DEPTH		16
#define SUBSYSTEM			4
#define LOG_DEPTH			6

extern const char * const LOG_NAME[SUBSYSTEM];
extern const char * const LOG_LEVEL[LOG_DEPTH];

void logMsgToQueue(log_holder_t holder, log_target_t target, log_level_t level, const char *msg, ...);
void logDataToQueue(log_holder_t holder, log_target_t target, log_level_t level, log_data_t data);

#define GLOBAL_DEBUG	1

// These are samples, names can be changed later
#define TASK1_DEBUG		1
#define TASK2_DEBUG		1
#define TASK3_DEBUG		1

#if TASK1_DEBUG
	#define TASK1_logMsgToQueue(target, level, msg, ...) \
		logMsgToQueue(TASK1, (target), (level), (msg), ##__VA_ARGS__)
	#define TASK1_logDataToQueue(target, level, data) \
		logDataToQueue(TASK1, (target), (level), (data))
#else
	#define TASK1_logMsgToQueue(target, level, msg, ...)
	#define TASK1_logDataToQueue(target, level, data)
#endif

#if TASK2_DEBUG
	#define TASK2_logMsgToQueue(target, level, msg, ...) \
		logMsgToQueue(TASK2, (target), (level), (msg), ##__VA_ARGS__)
	#define TASK2_logDataToQueue(target, level, data) \
		logDataToQueue(TASK2, (target), (level), (data))
#else
	#define TASK2_logMsgToQueue(target, level, msg, ...)
	#define TASK2_logDataToQueue(target, level, data)
#endif

#if TASK3_DEBUG
	#define TASK3_logMsgToQueue(target, level, msg, ...) \
		logMsgToQueue(TASK3, (target), (level), (msg), ##__VA_ARGS__)
	#define TASK3_logDataToQueue(target, level, data) \
		logDataToQueue(TASK3, (target), (level), (data))
#else
	#define TASK3_logMsgToQueue(target, level, msg, ...)
	#define TASK3_logDataToQueue(target, level, data)
#endif


#endif /* APPLICATION_TRACE_H_ */
