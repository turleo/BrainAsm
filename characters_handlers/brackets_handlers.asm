start_bracket:
  cmp byte [r13], 0
  je ignore_brackets

  push r12
  jmp main_loop


ignore_brackets:
  xor rcx, rcx

ignore_brackets_loop:
  mov rax, [r12]    ; check current character
  inc r12
  cmp al, '['
  je bracket_open
  cmp al, ']'
  je bracket_close
  cmp al, 0         ; file ended
  je quit
  jmp ignore_brackets_loop

bracket_open:
  inc rcx
  jmp check_if_ignore_brackets_loop_end
bracket_close:
  dec rcx
  jmp check_if_ignore_brackets_loop_end

check_if_ignore_brackets_loop_end:
  test rcx, rcx             ; if rcx is 0 all opened brackets are closed
  jz main_loop
  jnz ignore_brackets_loop


end_bracket:
  cmp byte [r13], 0
  je end_to_main_loop

  pop r12
  push r12
  jmp main_loop
end_to_main_loop:
  pop rcx
  jmp main_loop

