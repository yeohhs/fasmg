;===============================================================================
;Program : w32g01
;Version : 0.0.1
;Author  : Yeoh HS
;Date    : 6 January 2018
;Purpose : a Win32 console program. Use puts from msvcrt.dll
;fasmg   : i17sx
;===============================================================================
include 'format/format.inc'

format PE Console
entry start

section '.text' code readable executable

  start:
    push    Message
    call    [puts]
    
	push	0
	call	[ExitProcess]

section '.data' data readable writeable

  Message db 'fasmg says, "Hello World!"',0

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA msvcrt_name,RVA msvcrt_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dd RVA _ExitProcess
    dd 0
  msvcrt_table:
    puts dd RVA _puts
    dd 0
    
  kernel_name db 'Kernel32.dll',0
  msvcrt_name db 'msvcrt.dll',0
  
  _ExitProcess dw 0
    db 'ExitProcess',0
  _puts dw 0
    db 'puts',0

section '.reloc' fixups data readable discardable	; needed for Win32s
