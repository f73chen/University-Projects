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
# WatIAM username: f73chen
# Student number: 20823934
################################################################################


# TODO: Add implementations of modexp and extended_euclid (you can resuse your code from A1).

def modexp(x, y, N):
    """
    Input: Three positive integers x and y, and N.
    Output: The number x^y mod N
    """
    if y == 0:
        return 1
    z = modexp(x, math.floor(y/2), N)
    if y % 2 == 0:
        return (z * z) % N
    else:
        return (x * z * z) % N


def extended_euclid(a, b):
    """
    Input: Two positive integers a >= b >= 0
    Output: Three integers x, y, and d returned as a tuple (x, y, d)
            such that d = gcd(a, b) and ax + by = d
    """
    if b == 0:
        return 1, 0, a
    (x_new, y_new, d) = extended_euclid(b, a % b)

    return y_new, x_new - math.floor(a/b) * y_new, d


def primality(N):
    """
    Test if a number N is prime using Fermat's little Theorem with
    ten random values of a.  If a^(N-1) mod N = 1 for all values,
    then return true.  Otherwise return false.
    Hint:  you can generate a random integer between a and b using
    random.randint(a,b).
    """
    # TODO: Implement a True/False test for primality of an input number N.
    
    for i in range(10):
        a = random.randint(1, N - 1)

        # Calculate a^(N - 1) mod N using modexp()
        if modexp(a, N - 1, N) != 1:
            return False
        
    # Return True only if all 10 tests pass
    return True


def prime_generator(N):
    """
    This function generates a prime number <= N
    """
    # TODO: Implement a prime number generator.

    # Add a counter so it doesn't run forever
    counter = 0
    while counter < 10000:
        # Pick a random number from 2 to N and check for primality
        p = random.randint(2, N)
        if primality(p):
            return p
        
        # Increment the counter
        counter += 1
    return 0


def main():
    """
    Generate RSA private/public key, then encode and decode a message.
    """
    ## A2Q1:  generating primes and RSA
    ##################
    # p = prime_generator(10000000)
    # q = prime_generator(10000000)
    # N = p * q
    e = 5
    x = 2148321

    # TODO: Complete this main() function.
    #       You should use print statements to show that your code completes the 
    #       instructions from parts iii--vi.

    # iii) Check if e and (p - 1)(q - 1) are coprime
    # If not, regenerate p and q until they become coprime
    gcd = 0
    while gcd != 1:
        p = prime_generator(10000000)
        q = prime_generator(10000000)
        N = p * q
        pq_1 = (p - 1) * (q - 1)
        xx, yy, gcd = extended_euclid(e, pq_1)

    assert gcd == 1 # e and (p - 1)(q - 1) should be coprime
    print(xx * e + yy * pq_1)
    print(f"p: {p}, q: {q}, N: {N}, pq1: {pq_1}, xx: {xx}, yy: {yy}, gcd: {gcd}")

    # iv) Find the value of d for the private key
    # Modular Division Theorem
    # Recall that the multiplicative inverse can be found using extended_euclid(a, b) as x mod b
    d = xx % pq_1

    assert (d * e) % pq_1 == 1  # d should be the multiplicative inverse of e mod (p - 1)(q - 1)
    print(f"d: {d}, xx: {xx}, b: {pq_1}")

    # v) Encode x as y = x^e mod N
    encoded_x = modexp(x, e, N)
    print(f"Encoded message: {encoded_x}")

    # vi) Decode y as x = y^d mod N
    decoded_x = modexp(encoded_x, d, N)

    assert decoded_x == x  # The decoded message should be the same as the original message
    print(f"Decoded message: {decoded_x}")
    print(f"Original message: {x}")


if __name__ == '__main__':
    main()
