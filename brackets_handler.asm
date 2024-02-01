start_bracket:
  cmp byte [r13], 0
  je ignore_brackets

  push r12
  jmp main_loop


ignore_brackets:
  xor rcx, rcx

ignore_brackets_loop:
  inc r12
  mov rax, [r12]
  cmp al, '['
  je bracket_open
  cmp al, ']'
  je bracket_close
  cmp al, 0
  je quit
  jmp ignore_brackets_loop

bracket_open:
  inc rcx
  jmp check_if_ignore_brackets_loop_end
bracket_close:
  dec rcx
  jmp check_if_ignore_brackets_loop_end

check_if_ignore_brackets_loop_end:
  test rcx, rcx
  jz main_loop
  jnz ignore_brackets_loop


end_bracket:
  cmp byte [r13], 0
  je end_to_main_loop

  pop r12
  push r12
  jmp main_loop
end_to_main_loop:
  ;add rsp, 8
  pop rcx
  jmp main_loop

