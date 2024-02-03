print_data_instruction: ; .
  mov rdx, [r13]
  mov [output], dl
  mov rax, 1
  mov rdi, 1
  mov rsi, output
  mov rdx, 1
  syscall
  jmp main_loop

