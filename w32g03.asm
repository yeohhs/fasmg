;===============================================================================
;Program : w32g03
;Version : 0.0.1
;Author  : Yeoh HS
;Date    : 6 January 2018
;Purpose : a Win32 console program.
;fasmg   : i17sx
;===============================================================================
include 'format/format.inc'

format PE Console
entry start

section '.text' code readable executable

  start:
    push    Prompt
    push    FormatString
    call    [printf]
    
    push    UserInput 
	call    [gets]
    
    push    UserInput
    push    Welcome
    call    [printf]
    
    push	0
	call	[ExitProcess]

section '.data' data readable writeable
  FormatString db '%s',0
  Prompt       db 'Enter your name and press Enter: ',0
  Welcome      db 'Hello %s!',0
  UserInput    db 0
  
;-------------------------------------------------------------------------------
section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA user_name,RVA user_table
  dd 0,0,0,RVA msvcrt_name,RVA msvcrt_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dd RVA _ExitProcess
    dd 0
  user_table:
    MessageBoxA dd RVA _MessageBoxA
    dd 0
  msvcrt_table:
    printf dd RVA _printf
    gets   dd RVA _gets
    dd 0
    
  kernel_name db 'Kernel32.dll',0
  user_name db 'User32.dll',0
  msvcrt_name db 'msvcrt.dll',0
  
  _ExitProcess dw 0
    db 'ExitProcess',0
  _MessageBoxA dw 0
    db 'MessageBoxA',0
  _printf dw 0
    db 'printf',0
  _gets dw 0
    db  'gets',0
    
;-------------------------------------------------------------------------------    
section '.reloc' fixups data readable discardable	; needed for Win32s

; end of file ==================================================================