#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global segment

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

segment:
  ldi r21, 0x01  ; Initialize loop iterator
  loop:
    ldi r16, 0xFF  ; Load register 16 with 0xFF (all bits 1)  
    out DDRB, r16  ; Define all pins on port B as output
    out DDRD, r16  ; Define all pins on port D as output
    ldi r16, 0x00  ; Load register 16 with 0x00 (all bits 0)  
    out PORTB, r16 ; Write 0x00 to port B. This sets all pins to 0
    out PORTD, r16 ; Write 0x00 to port D. This sets all pins to 0

    ; @@@ START COPYING TO NEXT QUESTION

    ; Bisect the search space because word jump limit is 64
    ; Therefore the switch-case can't be too long

    cp r21, 0x00
    breq num_0     ; @@@ Error: no matter r21, eventually repeats this call
    cp r21, 0x01   ; @@@ If r21 != 0, stays on error for 1 tick then back to num_0
    breq num_1
    cp r21, 0x02
    breq num_2
    cp r21, 0x03
    breq num_3
    cp r21, 0x04
    breq num_4
    cp r21, 0x05
    breq num_5
    cp r21, 0x06
    breq num_6
    cp r21, 0x07
    breq num_7
    ; cp r21, 0x08
    ; breq num_8
    ; cp r21, 0x09
    ; breq num_9
    ; cp r21, 0x0a
    ; breq letter_a
    ; cp r21, 0x0B
    ; breq letter_b
    ; cp r21, 0x0C
    ; breq letter_c
    ; cp r21, 0x0D
    ; breq letter_d
    ; cp r21, 0x0E
    ; breq letter_e
    ; cp r21, 0x0F
    ; breq letter_f

    jmp error

    num_0:
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      jmp end
    num_1:
      sbi PORTD, 6
      sbi PORTD, 7
      jmp end
    num_2:
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 3
      jmp end
    num_3:
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 3
      jmp end
    num_4:
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_5:
      sbi PORTD, 5
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_6:
      sbi PORTD, 5
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_7:
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      jmp end
    num_8:
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    num_9:
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    letter_a:
      sbi PORTD, 5
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    letter_b:
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    letter_c:
      sbi PORTD, 5
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      jmp end
    letter_d:
      sbi PORTD, 6
      sbi PORTD, 7
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 3
      jmp end
    letter_e:
      sbi PORTD, 5
      sbi PORTB, 0
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    letter_f:
      sbi PORTD, 5
      sbi PORTB, 1
      sbi PORTB, 2
      sbi PORTB, 3
      jmp end
    error:
      sbi PORTD, 5
      sbi PORTB, 0
      sbi PORTB, 3
      jmp end
    end:

    inc r21        ; Increment iterator
    and r21, 0x0F  ; Mask to remove the upper half of r21

    ; Wait for 1s
    ldi r18, 0x00  ; 8000000 / 256 = 31250
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

    ; @@@ STOP COPYING TO NEXT QUESTION

    jmp loop