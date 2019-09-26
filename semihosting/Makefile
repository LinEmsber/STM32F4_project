
# Source files 
SRCS=main.c \
	system_stm32f4xx.c 

# Binary will be generated with this name (.elf, etc)
PROJ_NAME=semihosting_example

# Put your STM32F4 library code directory here
STM_COMMON=../STM32F4-Discovery_FW_V1.1.0

CC=arm-none-eabi-gcc
NM=arm-none-eabi-nm
OBJDUMP=arm-none-eabi-objdump
SIZE=arm-none-eabi-size

#Debug
CFLAGS  = -ggdb -O0 -Wall -Tstm32_flash.ld 

CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -I.

# Include files from STM libraries
CFLAGS += -I$(STM_COMMON)/Libraries/CMSIS/Include -I$(STM_COMMON)/Libraries/CMSIS/ST/STM32F4xx/Include

# add startup file to build
SRCS += $(STM_COMMON)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/TrueSTUDIO/startup_stm32f4xx.s 
OBJS = $(SRCS:.c=.o)

SEMIHOSTING_FLAGS = --specs=rdimon.specs -lc -lrdimon 


.PHONY: all

all: clean $(PROJ_NAME).elf

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(SEMIHOSTING_FLAGS) $(CFLAGS) $^ -o $@    
	$(NM) -l $(PROJ_NAME).elf > $(PROJ_NAME).nm
	$(OBJDUMP) -dSl $(PROJ_NAME).elf > $(PROJ_NAME).obj_src
	$(SIZE) $@    

clean:
	rm -f ./*.elf ./*obj* ./*nm 
