'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''
from selenium.webdriver.common.by import By
from seleniumpagefactory.Pagefactory import PageFactory
from utils.selenium_wrappers import SeleniumWrapper  

class LoginPage(PageFactory):
    
    def __init__(self, driver):
        self.driver = driver
        self.wrapper = SeleniumWrapper(driver)

        self.username_locator = (By.ID, "username")
        self.password_locator = (By.ID, "password")
        self.login_button_locator = (By.CSS_SELECTOR, "button[type='button']")
        
    def enter_username(self, user):
        """Enter username in the field"""
        self.wrapper.enter_text(*self.username_locator, user)

    def enter_password(self, pwd):
        """Enter password in the field"""
        self.wrapper.enter_text(*self.password_locator, pwd)

    def click_login_button(self):
        """Click the login button"""
        self.wrapper.click_element(*self.login_button_locator)

        

      
    