#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global pullup

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

pullup:
  ldi r21, 0x00  ; Initialize loop iterator
  ldi r22, 0x01  ; Wait flag
  ldi r16, 0xFF  ; Load register 16 with 0xFF (all bits 1)  
  out DDRB, r16  ; Define all pins on port B as output
  ldi r16, 0xFB  ; Load register 16 with 0xFB (all bits 1 except #2)
  out DDRD, r16  ; Define all pins on port D as output except #2 as input
  loop:
    ldi r16, 0x00  ; Load register 16 with 0x00 (all bits 0)  
    out PORTB, r16 ; Set all pins to 0
    ldi r16, 0x04  ; Load register 16 with 0x04 (all bits 0 except #2)  
    out PORTD, r16 ; Set all pins to 0 except #2

    cpi r22, 0x01
    brne letter_f  ; If don't need to wait for button, skip to iteration
    tmp:           ; Else wait until the button is pressed to proceed
      in r23, PIND
      andi r23, 0x04
      cpi r23, 0x00
      brne tmp
      ldi r22, 0x00

    letter_f:
      cpi r21, 0x0F
      brne letter_e
      sbi PORTD, 5
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      ldi r22, 0x01
      jmp end
    letter_e:
      cpi r21, 0x0E
      brne letter_d
      sbi PORTD, 5
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    letter_d:
      cpi r21, 0x0D
      brne letter_c
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 3
      jmp end
    letter_c:
      cpi r21, 0x0C
      brne letter_b
      sbi PORTD, 5
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      jmp end
    letter_b:
      cpi r21, 0x0B
      brne letter_a
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    letter_a:
      cpi r21, 0x0A
      brne num_9
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_9:
      cpi r21, 0x09
      brne num_8
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
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
      jmp end
    num_7:
      cpi r21, 0x07
      brne num_6
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      jmp end
    num_6:
      cpi r21, 0x06
      brne num_5
      sbi PORTD, 5
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_5:
      cpi r21, 0x05
      brne num_4
      sbi PORTD, 5
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_4:
      cpi r21, 0x04
      brne num_3
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_3:
      cpi r21, 0x03
      brne num_2
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 3
      jmp end
    num_2:
      cpi r21, 0x02
      brne num_1
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 3
      jmp end
    num_1:
      cpi r21, 0x01
      brne num_0
      sbi PORTD, 6
      sbi PORTD, 7
      jmp end
    num_0:
      cpi r21, 0x00
      brne error
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      jmp end
    error:
      sbi PORTD, 5
      sbi PORTB, 0
      sbi PORTB, 3
    end:

    inc r21         ; Increment iterator
    andi r21, 0x0F  ; Mask to remove the upper half of r21

    ; Wait for 1s
    ldi r18, 0x68  ; 8000000 / 256 = 31250
    l1:
      ldi r19, 0xFA  ; 31250 / 250 = 125
      l2:
        ldi r20, 0x7D  ; 125 --> 0.5s
        l3:
          mul r17, r17
          dec r20
          brne l3
        dec r19
        brne l2
      dec r18
      brne l1

    jmp loop