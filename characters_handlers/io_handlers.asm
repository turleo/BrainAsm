print_data_instruction: ; .
  mov rdx, [r13]
  mov [output], dl
  mov rax, 1        ; write
  mov rdi, 1        ; stdout
  mov rsi, output
  mov rdx, 1        ; 1 character
  syscall
  jmp main_loop

