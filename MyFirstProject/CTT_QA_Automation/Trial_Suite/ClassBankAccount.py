'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''
from pip._vendor.typing_extensions import Self


class Account:
    
    def __init__(self, accountNo, balance=50000):  # Initialize balance per instance
        self.accountNo = accountNo
        self.balance = balance

    
    def debit(self,amount):
        if amount>self.balance:
            print("Insufficient balance")
        else:
           self.balance=self.balance-amount
           print("Debited Rs. ",amount)
           print("Balance : ",self.printBalance())
        
    def credit(self,amount):
           self.balance=self.balance+amount
           print("Credited Rs. ",amount)
           print("Balance : ",self.printBalance())
        
    def printBalance(self):
        return self.balance



a1 = Account(5330100200)  # Create account with unique number
a1.debit(30000)  # Deduct amount
a1.printBalance()  # Print updated balance
a1.credit(2500)  # Deduct amount
a1.printBalance()  # Print updated balance
