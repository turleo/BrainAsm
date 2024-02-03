format ELF64 executable 

segment readable executable
entry main
main:
include "file_reader.asm"
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
  
inc_instruction: ; +
  inc byte [r13]
  jmp main_loop
dec_instruction: ; -
  dec byte [r13]
  jmp main_loop
inc_data_instruction: ; >
  inc r13
  jmp main_loop
dec_data_instruction: ; <
  dec r13
  jmp main_loop

include "brackets_handler.asm"

print_data_instruction: ; .
  mov rdx, [r13]
  mov [output], dl
  mov rax, 1
  mov rdi, 1
  mov rsi, output
  mov rdx, 1
  syscall
  jmp main_loop

quit:
  mov rdi, 0
  mov rax,  60
  syscall
  ret

include "memory_allocator.asm"

segment readable writable
output db 0

