;===============================================================================
;Program : w64g01
;Version : 0.0.1
;Author  : Yeoh HS
;Date    : 7 January 2018
;Purpose : a Win64 console program. Use puts from msvcrt.dll
;fasmg   : i17sx
;===============================================================================
include 'format/format.inc'

format PE64 Console
entry start

section '.text' code readable executable

  start:
  	sub	    rsp,8*5
 	
    lea     rcx, [Message]
    call    [puts]
    
	xor     ecx, ecx
	call	[ExitProcess]

section '.data' data readable writeable

  Message db 'fasmg says Hello 64-bit World!',0

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA msvcrt_name,RVA msvcrt_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess
    dq 0
  
  msvcrt_table:
    puts         dq RVA _puts
    dq 0
    
  kernel_name db 'Kernel32.dll',0
  msvcrt_name db 'msvcrt.dll',0
  
  _ExitProcess dw 0
    db 'ExitProcess',0
  _puts dw 0
    db 'puts',0
