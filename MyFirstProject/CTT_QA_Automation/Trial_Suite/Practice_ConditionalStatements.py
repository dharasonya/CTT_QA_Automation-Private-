'''
Created on 07-Jun-2025

@author: sonyarani.dhara
'''
# # Check Number is Odd or Even
# num=8
# if(num%2==0):
#     print("Even Number")
# else :
#     print("Odd Number")

#Check Greatest of 3 or 4 number Number

num1=int(input("Enter Number 1 : "))
num2=int(input("Enter Number 2 : "))
num3=int(input("Enter Number 3 : "))
num4=int(input("Enter Number 4 : "))

#Greater Number
if(num1>num2 and num1>num3 and num1>num4):
    print ("Greater Number : ",num1)
elif(num2>num3 and num2>num4):
    print ("Greater Number : ",num2)
elif(num3>num4):
    print ("Greater Number : ",num3)
else:
    print ("Greater Number : ",num4)
    
    