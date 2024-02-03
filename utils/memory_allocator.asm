allocate:       ; rsi - how much memory needs to be allocated 
  mov rax, 9
  xor rdi, rdi
  mov rdx, 3    ; PROT_READ | PROT_WRITE
  mov r10, 34   ; MAP_PRIVATE | MAP_ANONYMOUS
  mov r8, -1
  mov r9, 0
  syscall
  ret           ; value is being returned to rax

