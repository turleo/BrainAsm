  add rsp, 16       ; moving stack pointer to first argument
  mov rax, 2        ; open syscall
  pop rdi           ; file name
  mov rsi, 0        ; flags: O_RDONLY
  syscall

  cmp rax, 0
  jl error

  push rax            ; fd

  mov rsi, 144        ; size of struct stat, returned by syscall
  call allocate

  mov rdi, [rsp]      ; fd
  push rax            ; struct stat address
  mov rsi, rax        ; struct stat address
  mov rax, 5          ; fstat syscall
  syscall

  cmp rax, 0
  jl error

  pop rax             ; struct stat

  mov rsi, [rax + 48] ; size of file
  push rsi
  inc rsi             ; if we allocate one byte more memory, the last byte allways will be 0
  call allocate

  mov rsi, rax        ; buffer
  pop rdx             ; count
  pop rdi             ; fd
  mov rax, 0          ; read syscall
  push rsi            ; code pointer
  syscall

