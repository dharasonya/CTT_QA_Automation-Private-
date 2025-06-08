'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''

class Student:
    def __init__(self, name, marks):
        self.name = name
        self.marks = marks

    def getAverage(self):
        total = sum(self.marks)  # Use built-in sum function
        avg = total / len(self.marks)  # Get actual average
        print("Average is:", avg)  # Correct string concatenation

    def getListOfMarks(self):
        for val in self.marks:
            print(val)
        
        print(self.name)
       # print("Average is:", avg)  # Correct string concatenation



# Example Usage
s1 = Student("Sonya", [80, 85,22, 90])
s1.getAverage()
s1.getListOfMarks()
