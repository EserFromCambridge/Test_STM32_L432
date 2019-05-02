

# Paths relative to curr directory
export BASE := $(shell pwd)
export SRCBASE := $(shell pwd)

#Set this to @ to keep the makefile quiet
SILENCE				= @

#---- Outputs ----#
COMPONENT_NAME		= ./gen/bin/full_test_suite

	#--- Inputs ----#
PROJECT_HOME_DIR	= ..
CPPUTEST_HOME		= ../submodules/cpputest


# --- SRC_FILES ---
SRC_FILES			+= ../application/unittest_ex.cpp

# --- TEST_SRC_FILES ---
# TEST_SRC_DIRS		:=\
	./tests \
# Test Runner
TEST_SRC_FILES		+= ./tests/AllTests.cpp
# Individual Tests
TEST_SRC_FILES		+= ./tests/ExampleTest.cpp


# --- MOCKS_SRC_DIRS ---
# MOCKS_SRC_DIRS specifies a directories where you can put your
# mocks, stubs and fakes.  You can also just put them
# in TEST_SRC_DIRS
# MOCKS_SRC_DIRS = \

# Turn on CppUMock
CPPUTEST_USE_EXTENSIONS = Y
CPPUTEST_USE_GCOV = Y

# --- INCLUDE DIRs ---
INCLUDE_DIRS	:=\
  .\
  ../application\
  $(CPPUTEST_HOME)/include\
#  ../submodules/mbedOS\
  ../submodules/mbedOS/rtos/TARGET_CORTEX\
  ../submodules/mbedOS/rtos/TARGET_CORTEX/rtx5/RTX/Source\
  ../submodules/mbedOS/targets/TARGET_Freescale/TARGET_MCUXpresso_MCUS/TARGET_MCU_K64F/device\

# This line is overriding the default new macros.  This is helpful
# when using std library includes like <list> and other containers
# so that memory leak detection does not conflict with stl.
CPPUTEST_MEMLEAK_DETECTOR_NEW_MACRO_FILE = -include ./mock/NewMacros.h

# --- CPPUTEST_OBJS_DIR ---
# if you have to use "../" to get to your source path
# the makefile will put the .o and .d files in surprising 
# places.
# To make up for each level of "../", add place holder 
# sub directories in CPPUTEST_OBJS_DIR
# each "../".  It is kind of a kludge, but it causes the
# .o and .d files to be put under objs.
# e.g. if you have "../../src", set to "test-objs/1/2"
# This is set no "../" in the source path.
# CPPUTEST_OBJS_DIR = objs



################################################################################

#CPP_PLATFORM = Gcc
# Path to ARMCC of Keil MDK-ARM, with libraries, includes and executables
#GCC_DIR	:= ~/opt/gcc-arm-none-eabi-6-2017-q2-update/bin

#MKDIR	:=mkdir
#RM		:=rm
#CC		:= $(GCC_DIR)/arm-none-eabi-gcc
#CXX		:= $(GCC_DIR)/arm-none-eabi-g++
#AR		:= $(GCC_DIR)/arm-none-eabi-gcc-ar
#RANLIB  := $(GCC_DIR)/arm-none-eabi-ranlib


#LINKER_SCRIPT =  $(SRCBASE)/submodules/mbedOS/targets/TARGET_Freescale/TARGET_MCUXpresso_MCUS/TARGET_MCU_K64F/device/TOOLCHAIN_GCC_ARM/MK64FN1M0xxx12.ldo
#LINKER_SCRIPT_INPUT = $(SRCBASE)/submodules/mbedOS/targets/TARGET_Freescale/TARGET_MCUXpresso_MCUS/TARGET_MCU_K64F/device/TOOLCHAIN_GCC_ARM/MK64FN1M0xxx12.ld

#ifeq ($(HARDFP), 1)
#	FLOAT_ABI = hard
#else
#	FLOAT_ABI = softfp
#endif
#export FLOAT_ABI

#export CPU = -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=$(FLOAT_ABI)
#export LDFLAGS = $(CPU) -Wl,--gc-sections --specs=nosys.specs -u _printf_float -u _scanf_float -Wl,--wrap,main -Wl,--cref
#export LD_LIBRARIES = -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys

# armcc system include path
#SYS_INCLUDE_DIRS:=$(GCC_DIR)/arm-none-eabi/include 


################################################################################




CXX = clang++
COMPILER_OPTIONS = -std=c++11 -Wno-c++98-compat -Wc++11-compat -Wno-c++98-compat-pedantic -fms-extensions -DUNIT_TESTING=1 -DMBED_CONF_RTOS_PRESENT=1\
 -DDEVICE_I2C=1 -DDISABLE_MEMORY_LEAK_DETECTION 
# Ignore warnings - gradually remove these...
CPPUTEST_WARNINGFLAGS += -Wno-reserved-id-macro -Wno-keyword-macro -Wno-unused-parameter\
 -Wno-sign-conversion -Wno-header-hygiene -Wno-conversion -Wno-documentation -Wno-documentation-unknown-command\
 -Wno-return-type -Wno-unused-variable -Wno-covered-switch-default -Wno-unneeded-internal-declaration\
 -Wno-format-nonliteral -Wno-missing-prototypes -Wno-unreachable-code-return -Wno-shadow-field-in-constructor -Wno-c99-extensions\
 -Wno-unused-macros -Wno-nested-anon-types -Wno-c++14-binary-literal -Wno-missing-field-initializers -Wno-missing-braces\
 -Wno-missing-field-initializers

# Default dir for temporary files (d, o)
# Default dir for the outout library
CPPUTEST_OBJS_DIR = ./gen/objs
CPPUTEST_LIB_DIR = ./gen/lib

# Look at $(CPPUTEST_HOME)/build/MakefileWorker.mk for more controls
include $(CPPUTEST_HOME)/build/MakefileWorker.mk

# Need to add compiler options last or MakefileWorker.mk will overwrite
CPPFLAGS += $(COMPILER_OPTIONS)

