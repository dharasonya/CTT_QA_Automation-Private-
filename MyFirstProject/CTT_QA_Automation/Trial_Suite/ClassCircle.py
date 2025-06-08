'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''


class Circle:
    def __init__(self,radius):
        self.radius=radius

    def calcArea(self):
        print("Area of circle : ",3.1416*self.radius*self.radius)
        
    def calcPerimeterArea(self):
        print("Perimeter of circle : ",(2*3.14*self.radius))
    
c1=Circle(21)
c1.calcArea()
c1.calcPerimeterArea()
