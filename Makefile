# This file is generated for compiling a project for STM32 microcontroller
###############################################################################

###############################################################################
# Project settings
TARGET = $(BUILD_DIR)/project

export MAINBASE := $(shell pwd)
SRCBASE    := $(MAINBASE)/util
STMSRCBASE := $(MAINBASE)/drivers/STM32L4xx_HAL_Driver/Src
freeRTOS   := $(MAINBASE)/submodules/freeRTOS
unitTEST   := $(MAINBASE)/submodules/cpputest

# Build path
BUILD_DIR = build

GCC_BIN := ~/opt/gcc-arm-none-eabi-8-2018-q4-major/bin/

# Project settings
###############################################################################
# building variables

# debug build?
DEBUG = 1
# optimization
OPT = -Og


#######################################

# firmware library path
PERIFLIB_PATH = 

######################################
# source
######################################
# CPP sources
# CPP_SOURCES =

# C sources
C_SOURCES =  \
$(SRCBASE)/main.c \
$(SRCBASE)/stm32l4xx_hal_msp.c \
$(SRCBASE)/system_stm32l4xx.c \
$(SRCBASE)/stm32l4xx_it.c \
$(SRCBASE)/freertos.c \
$(MAINBASE)/drivers/serial_debug.c \
$(MAINBASE)/application/trace.c \
$(STMSRCBASE)/stm32l4xx_hal_i2c_ex.c \
$(STMSRCBASE)/stm32l4xx_hal_dma_ex.c \
$(STMSRCBASE)/stm32l4xx_hal_uart_ex.c \
$(STMSRCBASE)/stm32l4xx_hal_rcc.c \
$(STMSRCBASE)/stm32l4xx_hal_rcc_ex.c \
$(STMSRCBASE)/stm32l4xx_hal_i2c.c \
$(STMSRCBASE)/stm32l4xx_hal_dma.c \
$(STMSRCBASE)/stm32l4xx_hal_pwr_ex.c \
$(STMSRCBASE)/stm32l4xx_hal_spi.c \
$(STMSRCBASE)/stm32l4xx_hal_flash.c \
$(STMSRCBASE)/stm32l4xx_hal_uart.c \
$(STMSRCBASE)/stm32l4xx_hal_tim.c \
$(STMSRCBASE)/stm32l4xx_hal_wwdg.c \
$(STMSRCBASE)/stm32l4xx_hal_cortex.c \
$(STMSRCBASE)/stm32l4xx_hal_spi_ex.c \
$(STMSRCBASE)/stm32l4xx_hal_gpio.c \
$(STMSRCBASE)/stm32l4xx_hal_flash_ramfunc.c \
$(STMSRCBASE)/stm32l4xx_hal.c \
$(STMSRCBASE)/stm32l4xx_hal_pwr.c \
$(STMSRCBASE)/stm32l4xx_hal_tim_ex.c \
$(STMSRCBASE)/stm32l4xx_hal_flash_ex.c \

# ASM sources
ASM_SOURCES =  \
$(SRCBASE)/startup_stm32l432xx.s


######################################
# firmware library
######################################
PERIFLIB_SOURCES = 


#######################################
# binaries
#######################################

###############################################################################
# Tools and Flags
CC 		= $(GCC_BIN)arm-none-eabi-gcc
CPP     = $(GCC_BIN)arm-none-eabi-g++
AS 		= $(GCC_BIN)arm-none-eabi-gcc -x assembler-with-cpp
OBJCOPY = $(GCC_BIN)arm-none-eabi-objcopy
LD 		= $(GCC_BIN)arm-none-eabi-gcc
AR 		= $(GCC_BIN)arm-none-eabi-ar
SIZE	= $(GCC_BIN)arm-none-eabi-size
OBJDUMP = $(GCC_BIN)arm-none-eabi-objdump
PREPRO	= $(GCC_BIN)arm-none-eabi-cpp
RANLIB	= $(GCC_BIN)arm-none-eabi-ranlib

HEX = $(OBJCOPY) -O ihex
BIN = $(OBJCOPY) -O binary -S
  
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m4

# fpu
FPU = -mfpu=fpv4-sp-d16

# float-abi
FLOAT-ABI = -mfloat-abi=hard

# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-DUSE_HAL_DRIVER \
-DSTM32L432xx


# AS includes
AS_INCLUDES =  \
-Iutil

# C includes
C_INCLUDES =  \
-Iapplication \
-Idevice \
-Idrivers \
-Idrivers/CMSIS/RTOS \
-Idrivers/CMSIS/Include \
-Idrivers/STM32L4xx_HAL_Driver/Inc \
-Idrivers/STM32L4xx_HAL_Driver/Inc/Legacy \
-Idrivers/CMSIS/Device/ST/STM32L4xx/Include \
-I$(freeRTOS)/Inc \
-I$(freeRTOS)/FreeRTOS/Source/include \
-I$(freeRTOS)/FreeRTOS/Source/CMSIS_RTOS \
-I$(freeRTOS)/FreeRTOS/Source/portable/GCC/ARM_CM4F \
-Iutil


# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"
CCFLAGS := $(CFLAGS)

#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = $(SRCBASE)/STM32L432KCUx_FLASH.ld

#LIBS = -lc -lm -lnosys 
#LIBDIR = 


# libraries
#LIBS = -lc -lm -lnosys -lgcc -lsupc -lstdc++
export LD_SYS_LIBS = -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys
LIBDIR = $(freeRTOS)/build
#-u _printf_float -u _scanf_float -Wl,--wrap,main -Wl,-Map=$(PROJECT).map,--cref
#LDFLAGS = $(MCU) -specs=nano.specs -Wl,-Map=$(TARGET).map,--cref -Wl,--gc-sections
LDFLAGS = $(MCU) -specs=nano.specs -u _printf_float -u _scanf_float -Wl,-Map=$(TARGET).map,--cref -Wl,--gc-sections
STATIC_LIBRARIES = $(freeRTOS)/build/libfreeRTOS.a
export STATIC_LIBRARIES

# Tools and Flags
###############################################################################
# Rules
.PHONY: clean lst size

# default action: build all
all: $(TARGET).bin $(TARGET).hex size

#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))
# cpp objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(CPP_SOURCES:.cpp=.o)))
vpath %.cpp $(sort $(dir $(CPP_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -std=gnu99 -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.cpp Makefile | $(BUILD_DIR)
	$(CPP) -c $(CCFLAGS) -std=gnu++11 -fno-rtti -o $@ $<

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(TARGET).elf: $(OBJECTS) $(LDSCRIPT) $(STATIC_LIBRARIES)
	$(LD) $(LDFLAGS) -T$(LDSCRIPT) -o $@ $(OBJECTS) $(LIBRARIES) $(STATIC_LIBRARIES) $(LD_SYS_LIBS) $(LIBRARIES) $(STATIC_LIBRARIES) $(LD_SYS_LIBS)

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

$(TARGET).hex: $(TARGET).elf
	@$(OBJCOPY) -O ihex $< $@

$(TARGET).lst: $(TARGET).elf
	@$(OBJDUMP) -Sdh $< > $@

lst: $(TARGET).lst

size: $(TARGET).elf
	$(SIZE) $(TARGET).elf

$(BUILD_DIR):
	mkdir $@		

#######################################
# clean up
#######################################
clean:
	-rm -fR .dep $(BUILD_DIR)
  
#######################################
# Rules
###############################################################################
# Dependencies

DEPS = $(OBJECTS:.o=.d)
-include $(DEPS)

-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)

# Dependencies
###############################################################################

# *** EOF ***