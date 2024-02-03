inc_instruction: ; +
  inc byte [r13]
  jmp main_loop
dec_instruction: ; -
  dec byte [r13]
  jmp main_loop

