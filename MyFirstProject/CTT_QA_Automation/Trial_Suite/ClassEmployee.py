'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''

class Employee:
    def __init__(self,role,department,salary=45000):
        self.role=role
        self.department=department
        self.salary=salary
        
    def showEmpDetails(self):
        print("Employee Role :",self.role," , Department : ",self.department," ,Salary :",self.salary)
            

class Engineer(Employee):
    def __init__(self,name,age):
        self.name=name;
        self.age=age;
        
    def showEngDetails(self):
        print("Engineer Name :",self.name," , Age : ",self.age)
        super().__init__("QA", "Technology", 1000)
        super().showEmpDetails()
            
          
       
eng1=Engineer("Sonya",29)
eng1.showEngDetails()

    