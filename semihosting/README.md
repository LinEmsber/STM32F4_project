# The simple example of semihosting

## Memory layout
* We can check from linker script to understand the memory layout of ELF.

```c=like
/* Highest address of the user mode stack */                    
_estack = 0x20020000;    /* end of 128K RAM on AHB bus*/

/* Generate a link error if heap and stack don't fit into RAM */
_Min_Heap_Size = 0;      /* required amount of heap  */
_Min_Stack_Size = 0x400; /* required amount of stack */

/* Specify the memory areas */
MEMORY
{
  FLASH (rx)      : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 192K
  MEMORY_B1 (rx)  : ORIGIN = 0x60000000, LENGTH = 0K
}
```
* The default setting as follows:
  * FLASH origin: 0x08000000 and length: 1024K
  * RAM origin: 0x08000000 and length: 192K

```c=like
SECTIONS
{
  /* The startup code goes first into FLASH */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Startup code */
    . = ALIGN(4);
  } >FLASH

  .text :
  {
    ...
  } >FLASH

  .data : AT ( _sidata )
  {
    ...
  } >RAM

  .bss :
  {
    ...
  } >RAM

  /* User_heap_stack section, used to check that there is enough RAM left */
  ._user_heap_stack :
  {
    . = ALIGN(4);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    PROVIDE ( __end__ = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(4);
  } >RAM
```

* FLASH
  * Startup code in F
  * .text section
* RAM
  * .data section
  * .bss section
  * user's heap and stack
