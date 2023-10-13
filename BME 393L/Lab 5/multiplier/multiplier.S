#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global multiplier

;---------------------

start:
  ret

; PORTD 5 --> PIN 7 --> A
; PORTD 6 --> PIN 6 --> B
; PORTD 7 --> PIN 4 --> C
; PORTB 0 --> PIN 2 --> D
; PORTB 1 --> PIN 1 --> E
; PORTB 2 --> PIN 9 --> F
; PORTB 3 --> PIN 10 --> G

; PORTD 2 --> UP
; PORTD 3 --> ENTER

; r21 --> Current number
; r23 --> 1st number LSD; Result(0)
; r24 --> 1st number MSD; Result(1)
; r25 --> 2nd number LSD; Result(2)
; r26 --> 2nd number MSD; Result(3)
; r27 --> Pin/button inputs

multiplier:
  ldi r21, 0x00  ; Initialize current number
  ldi r16, 0xFF  ; 1111_1111
  out DDRB, r16  ; Define as output
  ldi r16, 0xF3  ; 1111_0011
  out DDRD, r16  ; Define as output; define as input for #2, #3
  loop:
    ldi r16, 0x00  ; 0000_0000
    out PORTB, r16 ; Reset all pins
    ldi r16, 0x0C  ; 0000_1100
    out PORTD, r16 ; Reset all pins; activate pull-up for #2, #3

    call enter
    mov r23, r21
    call enter
    mov r24, r21
    call enter
    mov r25, r21
    call enter
    mov r26, r21

    call multiply
    show_results: ; After multiplication, cycle through results
      mov r21, r23
      call display_result
      mov r21, r24
      call display_result
      mov r21, r25
      call display_result
      mov r21, r26
      call display_result
      call display_dash
      jmp show_results
  jmp loop




; SUBROUTINE: Change r21 based on Up key or Enter key
enter:
  call display_q
  ldi r21, 0x00

  wait_r21:
    in r27, PIND    ; Read input port D
    andi r27, 0x0C  ; Mask 0000_1100

    cpi r27, 0x04   ; Up key
    breq inc_r21
    jmp ninc_r21
    inc_r21:        ; If up key pressed
      inc r21
      andi r21, 0x0F
      call display_current
      call wait_05s ; Debounce input
      jmp wait_r21
    ninc_r21:       ; If up key not pressed

    cpi r27, 0x08   ; Enter key
    breq enter_r21
    jmp nenter_r21
    enter_r21:      ; If enter key pressed
      call flash_current
      ret
    nenter_r21:     ; If enter key not pressed
      jmp wait_r21
ret

; SUBROUTINE: Aggregate inputs, multiply, and distribute outputs  @@@
multiply:
  lsl r24      ; Shift MSD 4 spaces to the left 
  lsl r24
  lsl r24
  lsl r24
  lsl r26
  lsl r26
  lsl r26
  lsl r26

  or r23, r24  ; r23 = r24_r23
  or r25, r26  ; r25 = r26_r25
  mul r23, r25 ; Store results in r1:r0

  mov r23, r0  ; Mask results to 4 bits each
  andi r23, 0x0F
  mov r24, r0
  andi r24, 0xF0
  mov r25, r1
  andi r25, 0x0F
  mov r26, r1
  andi r26, 0xF0

  lsr r24      ; Shift MSD 4 spaces to the right
  lsr r24
  lsr r24
  lsr r24
  lsr r26
  lsr r26
  lsr r26
  lsr r26
ret

; SUBROUTINE: Show r21 for 1 second, then blank for half-second
display_result:
  call display_current
  call wait_05s
  call wait_05s
  call display_blank
  call wait_05s
ret

; SUBROUTINE: Show a single dash for 1 second
display_dash:
  sbi PORTB, 3
  call wait_05s
  call wait_05s
  call display_blank
  call wait_05s
ret

; SUBROUTINE: Flash the last input 2-3 times
flash_current:
  call display_current
  call wait_02s
  call display_blank
  call wait_02s
  call display_current
  call wait_02s
  call display_blank
  call wait_02s
  call display_current
  call wait_02s
  call display_blank
  call wait_02s
ret

; SUBROUTINE: Display the number stored in r21
display_current:
  call display_blank
  letter_f:
    cpi r21, 0x0F
    brne letter_e
    sbi PORTD, 5
    sbi PORTB, 1
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  letter_e:
    cpi r21, 0x0E
    brne letter_d
    sbi PORTD, 5
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  letter_d:
    cpi r21, 0x0D
    brne letter_c
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 3
    ret
  letter_c:
    cpi r21, 0x0C
    brne letter_b
    sbi PORTD, 5
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 2
    ret
  letter_b:
    cpi r21, 0x0B
    brne letter_a
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  letter_a:
    cpi r21, 0x0A
    brne num_9
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 1
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  num_9:
    cpi r21, 0x09
    brne num_8
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  num_8:
    cpi r21, 0x08
    brne num_7
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  num_7:
    cpi r21, 0x07
    brne num_6
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTD, 7
    ret
  num_6:
    cpi r21, 0x06
    brne num_5
    sbi PORTD, 5
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  num_5:
    cpi r21, 0x05
    brne num_4
    sbi PORTD, 5
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  num_4:
    cpi r21, 0x04
    brne num_3
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 2
    sbi PORTB, 3
    ret
  num_3:
    cpi r21, 0x03
    brne num_2
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 3
    ret
  num_2:
    cpi r21, 0x02
    brne num_1
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 3
    ret
  num_1:
    cpi r21, 0x01
    brne num_0
    sbi PORTD, 6
    sbi PORTD, 7
    ret
  num_0:
    cpi r21, 0x00
    brne error
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTB, 1
    sbi PORTB, 2
    ret
  error:
    sbi PORTD, 5
    sbi PORTB, 0
    sbi PORTB, 3
ret

; SUBROUTINE: Display question mark
display_q:
  sbi PORTD, 5
  sbi PORTD, 6
  sbi PORTB, 1
  sbi PORTB, 3
ret

; SUBROUTINE: Clear 7-segment display
display_blank:
  cbi PORTD, 5
  cbi PORTD, 6
  cbi PORTD, 7
  cbi PORTB, 0
  cbi PORTB, 1
  cbi PORTB, 2
  cbi PORTB, 3
ret

; SUBROUTINE: Wait 0.5s
wait_05s:
  push r18
  push r19
  push r20

  ldi r18, 0x68
  l1:
    ldi r19, 0x7D
    l2:
      ldi r20, 0x7D
      l3:
        mul r17, r17
        dec r20
        brne l3
      dec r19
      brne l2
    dec r18
    brne l1

  pop r20
  pop r19
  pop r18
ret

; SUBROUTINE: Wait 0.2s
wait_02s:
  push r18
  push r19
  push r20

  ldi r18, 0x2A
  l4:
    ldi r19, 0x7D
    l5:
      ldi r20, 0x7D
      l6:
        mul r17, r17
        dec r20
        brne l6
      dec r19
      brne l5
    dec r18
    brne l4

  pop r20
  pop r19
  pop r18
ret