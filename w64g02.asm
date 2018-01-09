;===============================================================================
;Program : w64g02
;Version : 0.0.1
;Author  : Yeoh HS
;Date    : 7 January 2018
;Purpose : a Win64 console program. Use printf from msvcrt.dll
;fasmg   : i17sx
;===============================================================================
include 'format/format.inc'

format PE64 Console
entry start

section '.text' code readable executable

  start:
  	sub	    rsp,8*5
    
 	lea     rdx, [Message]
    lea     rcx, [FormatString]
    call    [printf]
    
	xor     ecx, ecx
	call	[ExitProcess]

section '.data' data readable writeable
  FormatString db '%s',0
  Message db 'With printf function, fasmg says Hello 64-bit World!',0

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA msvcrt_name,RVA msvcrt_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess
    dq 0
  
  msvcrt_table:
    printf         dq RVA _printf
    dq 0
    
  kernel_name db 'Kernel32.dll',0
  msvcrt_name db 'msvcrt.dll',0
  
  _ExitProcess dw 0
    db 'ExitProcess',0
  _printf dw 0
    db 'printf',0
