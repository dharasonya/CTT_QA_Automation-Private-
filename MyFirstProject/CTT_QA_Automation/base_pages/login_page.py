'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''
from selenium.webdriver.common.by import By
from seleniumpagefactory.Pagefactory import PageFactory

class LoginPage(PageFactory):
    
    def __init__(self, driver):
        self.driver = driver
    
        # Correct way to define locators
        self.username = self.driver.find_element(By.ID, "user")
        self.password = self.driver.find_element(By.ID, "pass")
        self.login_button = self.driver.find_element(By.ID, "login")
        

    def login(self, user, pwd):
        self.username.send_keys(user)  # Correct method for entering text
        self.password.send_keys(pwd)   # Correct method for password input
        self.login_button.click()
       
    