MEMORY
{
  /* NOTE K = KiBi = 1024 bytes */
  FLASH : ORIGIN = 0x08000000, LENGTH = 512K
  RAM : ORIGIN = 0x20000000, LENGTH = 112K /* I-BUS & D-BUS */
  RAM2: ORIGIN = 0x2001C000, LENGTH = 16K  /* S-BUS */
}

/* I Bus (S0): This bus connects the instruction bus of the Cortex-M4 core to the bus matrix. 
The core fetches instructions through this bus. The objects accessed by this bus are memory including code. */

/* D Bus (S1): This bus connects the Cortex-M4 data bus and 64KB CCM data RAM to the bus matrix. 
The core uses this bus for immediate loads and debug access. */

/* S-bus (S2): This bus connects the system bus of the Cortex-M4 core to the bus matrix. 
This bus is used to access data located in peripherals or SRAM. */


/* This is where the call stack will be allocated. */
/* The stack is of the full descending type. */
/* You may want to use this variable to locate the call stack and static
   variables in different memory regions. Below is shown the default value */
/* _stack_start = ORIGIN(RAM) + LENGTH(RAM); */

/* You can use this symbol to customize the location of the .text section */
/* If omitted the .text section will be placed right after the .vector_table
   section */
/* This is required only on microcontrollers that store some configuration right
   after the vector table */
/* _stext = ORIGIN(FLASH) + 0x400; */

/* Example of putting non-initialized variables into custom RAM locations. */
/* This assumes you have defined a region called CCMRAM above, and in the 
   Rust privacy crate you have a `static mut` called `MyCCMVar`. */
/* Note that the section name `.uninit.MyCCMVar` must match the name used
   in the Rust declarations. */
/* SECTIONS {
     .uninit.MyCCMVar (NOLOAD) : ALIGN(4) {
       . = ALIGN(4);
       __sMyCCMVar = .;
       *(.uninit.MyCCMVar .uninit.MyCCMVar.*);
       . = ALIGN(4);
       __eMyCCMVar = .;
     } > CCMRAM
   } INSERT AFTER .bss;
*/
