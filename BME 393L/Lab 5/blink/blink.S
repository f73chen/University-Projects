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

  ; @@@ Fix timings so it becomes 1Hz
  ldi r18, 0x00  ; 4000000 / 256 = 15625
  ldi r19, 0x7D  ; 15625 / 125 = 125
  ldi r20, 0x40  ; 125 --> 0.5s
  l1:
    mul r17, r17
    dec r18
    brne l1
    dec r19
    brne l1
    dec r20
    brne l1

  ldi r16, 0xFF  ; Load register 16 with 0xFF (all bits 1)  
  out DDRB, r16  ; Write 0xFF to Data Direction Register for port B. This defines all pins on port B as output.  
  ldi r16, 0x0   ; Load register 16 with 0x00 (all bits 0)  
  cbi PORTB, 0   ; Clears bit 0 on port B to 0.
  
  ldi r18, 0x00  ; 4000000 / 256 = 15625
  ldi r19, 0x7D  ; 15625 / 125 = 125
  ldi r20, 0x40  ; 125 --> 0.5s
  l2:
    mul r17, r17
    dec r18
    brne l2
    dec r19
    brne l2
    dec r20
    brne l2