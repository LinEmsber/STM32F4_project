# The practice project of STM32F4Discovery

## Introduction
1. STM32F429ZIT6 MCU, cortex M4, 180MHz/225DMIPS
2. 64Mbits SDRAM

## st-link

* The STM32F429 Discovery board EVB includes an ST-LINK/V2 or ST-LINK/V2-B embedded debug tool. We can easier to debug our program via ICE tool.

### Download
```shell=
git clone https://github.com/texane/stlink
```

### Installation
```shell=
$ make
```

### Probe
* Probe our device.
```shell=
$ sudo ./build/Release/st-info --probe
```

### Test
* Use semihosting to test.

* In the terminal 1
```shell=
sudo ./build/Release/src/gdbserver/st-util --semihosting
```

* In the terminal 2
```shell=
arm-none-eabi-gdb ./semihosting/hello_world.elf -x ./GDB_script.gdb
```

## openOCD
* The Open On-Chip Debugger (OpenOCD) aims to provide debugging, in-system programming and boundary-scan testing for embedded target devices.

### Download
```shell=
git clone https://repo.or.cz/openocd.git
```

### Installation
```shell=
$ ./bootstrap
$ ./configure --enable-stlink
$ make
$ sudo make install
```

## Test
* In the terminal 1
```shell=
sudo ../src/openocd -f ./board/stm32f4discovery.cfg -c "init" -c "arm semihosting enable"
```
* In the terminal 2
```shell=
arm-none-eabi-gdb ./semihosting/hello_world.elf -x ./GDB_script.gdb
```

## Simple GDB script
```bash
target remote :3333
load
c
```

## References:
* UM1670 User manual: Discovery kit with STM32F429ZI MCU
* STM32F427xx STM32F429xx Datasheet - production data
* STM32 ST-LINK utility software description
* RM0090 Reference manual STM32F405/415, STM32F407/417, STM32F427/437 and STM32F429/439 advanced Arm®-based 32-bit MCUs
* [STM32F4 Discovery Semihosting with the GNU Tools for Embedded ARM Processors Toolchain](http://www.wolinlabs.com/blog/stm32f4.semihosting.html)
