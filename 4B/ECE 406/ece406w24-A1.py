"""
ECE406, Assignment 1.
Fill in these functions and submit on LEARN.
"""
#!/usr/bin/env python3
import math

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


def main():
    """
    Testing the two functions on a few inputs
    """
    # testing modular exponentiation
    if modexp(10, 1200, 14) == 8:
        print("modexp passed test 1")
    else:
        print("modexp failed test 1")

    # modexp -- test 2
    if modexp(325942, 25000000, 7) == 1:
        print("modexp passed test 2")
    else:
        print("modexp failed test 2")

    # modexp -- test 3 (extra test)
    if modexp(123456, 654321, 13) == 8:
        print("modexp passed test 3")
    else:
        print("modexp failed test 3")

    # testing extended Euclid
    (x, y, d) = extended_euclid(125, 15)
    if d == 5 and x*125 + y*15 == d:
        print("extended_euclid passed test 1")
    else:
        print("extended_euclid failed test 1")

    # extended_euclid -- test 2
    (x, y, d) = extended_euclid(10203040, 20304)
    if d == 16 and x*10203040 + y*20304 == d:
        print("extended_euclid passed test 2")
    else:
        print("extended_euclid failed test 2")

    # extended_euclid -- test 3 (extra test)
    (x, y, d) = extended_euclid(3129848,17652)
    if d == 4 and x*3129848 + y*17652 == d:
        print("extended_euclid passed test 3")
    else:
        print("extended_euclid failed test 3")
        

if __name__ == '__main__':
    main()
