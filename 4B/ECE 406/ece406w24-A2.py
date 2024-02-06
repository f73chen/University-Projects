#!/usr/bin/env python3
"""
Assignment 2 Python file
Copy-and-paste your extended_euclid and modexp functions
from assignment 1
"""
import random
import math

################################################################################
# student info
#
# WatIAM username: TODO
# Student number: TODO
################################################################################


# TODO: Add implementations of modexp and extended_euclid (you can resuse your code from A1).

# part (i) for modular exponentiation -- fill in the code below
def modexp(x, y, N):
    """
    Input: Three positive integers x and y, and N.
    Output: The number x^y mod N
    """
    # Base case
    if y == 0:
        return 1
    
    z = modexp(x, y // 2, N)
    # If y is even
    if y % 2 == 0:
        return z**2 % N
    else:
        return (x * z**2) % N


# part (ii) for extended Euclid  -- fill in the code below
def extended_euclid(a, b):
    """
    Input: Two positive integers a >= b >= 0
    Output: Three integers x, y, and d returned as a tuple (x, y, d)
            such that d = gcd(a, b) and ax + by = d
    """
    # Base case
    if b == 0:
        return (1, 0, a)
    
    # Recursion
    (x_, y_, d) = extended_euclid(b, a % b)
    return (y_, x_ - (a // b) * y_, d)


def primality(N):
    """
    Test if a number N is prime using Fermat's little Theorem with
    ten random values of a.  If a^(N-1) mod N = 1 for all values,
    then return true.  Otherwise return false.
    Hint:  you can generate a random integer between a and b using
    random.randint(a,b).
    """
    # TODO: Implement a True/False test for primality of an input number N.
    return True


def prime_generator(N):
    """
    This function generates a prime number <= N
    """
    # TODO: Implement a prime number generator.
    return 0


def main():
    """
    Generate RSA private/public key, then encode and decode a message.
    """
    ## A2Q1:  generating primes and RSA
    ##################
    p = prime_generator(10000000)
    q = prime_generator(10000000)
    N = p * q
    e = 5
    x = 2148321

    # TODO: Complete this main() function.
    #       You should use print statements to show that your code completes the 
    #       instructions from parts iii--vi.

if __name__ == '__main__':
    main()
