;===============================================================================
;Program : w64g00
;Version : 0.0.1
;Author  : Yeoh HS
;Date    : 7 January 2018
;Purpose : a bare-bones Win64 console program. 
;fasmg   : i17sx
;===============================================================================
include 'format/format.inc'

format PE64 Console
entry start

section '.text' code readable executable

  start:
  	sub	    rsp,8*5 	
    
	xor     ecx, ecx
	call	[ExitProcess]

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess
    dq 0
    
  kernel_name db 'Kernel32.dll',0
  
  _ExitProcess dw 0
    db 'ExitProcess',0
