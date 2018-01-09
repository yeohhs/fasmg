;===============================================================================
;Program : w32g00
;Version : 0.0.1
;Author  : Yeoh HS
;Date    : 6 January 2018
;Purpose : a bare-bones Win32 console program.
;fasmg   : i17sx
;===============================================================================
include 'format/format.inc'

format PE Console
entry start

section '.text' code readable executable

  start:
	push	0
	call	[ExitProcess]

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dd RVA _ExitProcess
    dd 0
    
  kernel_name db 'Kernel32.dll',0
  
  _ExitProcess dw 0
    db 'ExitProcess',0

  
section '.reloc' fixups data readable discardable	; needed for Win32s
