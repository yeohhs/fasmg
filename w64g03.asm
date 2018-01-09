;===============================================================================
;Program : w64g03
;Version : 0.0.1
;Author  : Yeoh HS
;Date    : 7 January 2018
;Purpose : a Win64 console program. Use gets and printf from msvcrt.dll
;fasmg   : i17sx
;===============================================================================
include 'format/format.inc'

format PE64 Console
entry start

section '.text' code readable executable

  start:
  	sub	    rsp,8*5
    
 	lea     rdx, [Prompt]
    lea     rcx, [FormatString]
    call    [printf]

    lea     rcx, [UserInput]
    call    [gets]

    lea     rdx, [UserInput]
    lea     rcx, [Welcome]
    call    [printf]    
    
	xor     ecx, ecx
	call	[ExitProcess]

section '.data' data readable writeable
  FormatString db '%s',0
  Prompt       db 'Enter your name and press Enter: ',0
  Welcome      db 'Hello %s!',0
  UserInput    db 0

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA msvcrt_name,RVA msvcrt_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess
    dq 0
  
  msvcrt_table:
    printf         dq RVA _printf
    gets           dq RVA _gets
    dq 0
    
  kernel_name db 'Kernel32.dll',0
  msvcrt_name db 'msvcrt.dll',0
  
  _ExitProcess dw 0
    db 'ExitProcess',0
  _printf dw 0
    db 'printf',0
  _gets dw 0
    db 'gets',0
