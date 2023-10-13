import numpy as np
import matplotlib.pyplot as plt
import math


class Circle:

    def __init__(self, centre, radius):
        assert isinstance(radius, float), 'Expected a scalar radius'
        assert isinstance(centre, tuple) and len(centre) == 2, 'Expected centre to be a 2-vector'

        self.centre = centre
        self.radius = radius

    def contains(self, point):
        assert isinstance(point, tuple) and len(point) == 2, 'Expected point to be a 2-vector'

        if (point[0]-self.centre[0])**2 + (point[1]-self.centre[1])**2 < self.radius**2:
            return 1
        else:
            return 0


if __name__ == '__main__':
    circle = Circle((.5,.5), .3)

    plt.figure(figsize=(4,4))
    for i in range(1000):
        point = tuple(np.random.rand(2))
        if circle.contains(point):
            colour = 'c'
        else:
            colour = 'b'
        plt.scatter(point[0], point[1], c=colour)

    plt.show()

def test_circle_init():
    circ = Circle(centre=(1,1), radius=10.0)
    assert circ.centre == (1,1)
    assert circ.radius == 10

def test_circle_contains():
    circ = Circle(centre=(0,0), radius=10.0)
    assert circ.contains((0, 0)) == 1
    assert circ.contains((math.sqrt(10)-0.001, math.sqrt(10)-0.001)) == 1

def test_circle_doesnt_contain():
    circ1 = Circle(centre=(0,0), radius=10.0)
    assert circ1.contains((10, 0)) == 0
    circ2 = Circle(centre=(0,0), radius=0.0)
    assert circ2.contains((0, 0)) == 0