#!/usr/bin/env python3
"""
ECE 406:  File for Exercise 1 of Assignment #3
"""
import numpy.fft as np


################################################################################
# student info
#
# WatIAM username: f73chen
# Student number: 20823934
################################################################################


def main():
    """
    Exercise 1:  Using the FFT to multiply two binary numbers.
    You just need to fill in parts (v) and (vi)
    """
    # The binary numbers and their product
    a_bin = 0b110000001101
    b_bin = 0b100011110001
    c_bin = a_bin * b_bin
    print('The product of a and b is', c_bin)


    # (i) The coefficients of the polynomials A and B
    Acoeff = [1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1]
    Bcoeff = [1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1]


    # (ii) the value representations of A and B
    # d = 11, 2d + 1 = 23 --> 32 roots of unity
    Aval = np.fft(Acoeff, 32)
    Bval = np.fft(Bcoeff, 32)


    # (iii) The value representation of C
    Cval = []
    for i in range(len(Aval)):
        Cval.append(Aval[i] * Bval[i])  # Element-wise multiplication


    # (iv) The coefficients of the polynomial C
    Ccoeff = np.ifft(Cval)
    # we'll get rid of the imaginary parts, which are just numerical errors
    for i, c in enumerate(Ccoeff):
        Ccoeff[i] = int(round(c.real))
    # NOTE: Because we are taking the FFT on 12-bit numbers using the 32-th roots
    #       of unity, the polynomial coefficients (Ccoeff) can be numbers 
    #       other than 0 and 1. Don't be alarmed by this: this polynomial will
    #       still produce the correct answer c = C(2)


    # (v) calculate the product by evaluating the polynomial at 2, i.e., C(2)
    # (You may need to take the real part at the end if there is a small imaginary component)
    prod = 0
    # TODO: write some code to produce the proper value of prod as an integer
    for i, coeff in enumerate(Ccoeff):
        prod += coeff * (2 ** i)
    print('Using the FFT the product of a and b is', int(round(prod.real)))
    
    assert prod == c_bin    # Verify that the number is correct
    print("prod matches c_bin")


    # (vi) write code to calculate the binary digits of c directly from the coefficients of C, Ccoeff.
    # TODO: use Coeff to produce an array of {0, 1} values that represent the binary values of c
    c = [int(coeff.real) for coeff in Ccoeff[:23]]   # a and b are 11-dimensional, so c is 22-dimensional (23 bits)
    for i in range(22):
        c[i+1] += c[i] // 2 # Carry over
        c[i] %= 2           # Modulo 2
    print(f"Binary digits of c from Ccoeff: {c}")
    
    c_bin_list = bin(c_bin)[2:] # Convert the original product to binary
    c_bin_list = list(reversed([int(x) for x in c_bin_list]))   # Order the coefficients from least to most significant
    print(f"Binary digits of c from c_bin: {c_bin_list}")
    
    assert c == c_bin_list  # Verify that the direct conversion is correct
    print("c matches c_bin_list")
    

if __name__ == '__main__':
    main()
