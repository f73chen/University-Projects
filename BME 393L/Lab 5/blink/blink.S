#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global blink

;---------------------

start:
  ret

blink:
  ldi r16, 0xFF  ; Load register 16 with 0xFF (all bits 1)  
  out DDRB, r16  ; Write 0xFF to Data Direction Register for port B. This defines all pins on port B as output.  
  ldi r16, 0x0   ; Load register 16 with 0x00 (all bits 0)  
  out PORTB, r16 ; Write 0x00 to port B. This sets all pins to 0.  
  sbi PORTB, 0   ; Sets bit 0 on port B to 1. 

  ; Turn on for 0.5s
  ldi r18, 0x00  ; 8000000 / 256 = 31250
  l1:
    ldi r19, 0x7D  ; 31250 / 250 (FA) = 125
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

  ldi r16, 0xFF  ; Load register 16 with 0xFF (all bits 1)  
  out DDRB, r16  ; Write 0xFF to Data Direction Register for port B. This defines all pins on port B as output.  
  ldi r16, 0x0   ; Load register 16 with 0x00 (all bits 0)  
  cbi PORTB, 0   ; Clears bit 0 on port B to 0.
  
  ; Turn off for 0.5s
  ldi r18, 0x00  ; 8000000 / 256 = 31250
  l4:
    ldi r19, 0x7D  ; 31250 / 250 = 125
    l5:
      ldi r20, 0x7D  ; 125 --> 0.5s
      l6:
        mul r17, r17
        dec r20
        brne l6
      dec r19
      brne l5
    dec r18
    brne l4