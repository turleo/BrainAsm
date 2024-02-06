format ELF64 executable 

segment readable executable
entry main
main:
include "utils/code_reader.asm"
  pop r12         ; r12 -- code pointer
  dec r12
  mov rsi, 30000  ; memory size
  call allocate
  mov r13, rax    ; r13 -- data pointer

main_loop:
  inc r12
  mov rax, [r12]
  cmp al, 0
  je quit
  cmp al, '+' ; +
  je inc_instruction
  cmp al, '-' ; -
  je dec_instruction
  cmp al, '.'
  je print_data_instruction
  cmp al, '>'
  je inc_data_instruction
  cmp al, '<'
  je dec_data_instruction
  cmp al, '['
  je start_bracket
  cmp al, ']'
  je end_bracket

  jmp main_loop
  
include "characters_handlers/number_handlers.asm"   ; +-
include "characters_handlers/pointer_handlers.asm"  ; <>
include "characters_handlers/brackets_handlers.asm" ; []
include "characters_handlers/io_handlers.asm"       ; .,


quit:
  mov rdi, 0
  mov rax,  60     ; exit
  syscall
error:
  mov rdi, rax     ; (syscall's errors are allways in rax)
  mov rax,  60     ; exit
  syscall

include "utils/memory_allocator.asm"

segment readable writable
output db 0

