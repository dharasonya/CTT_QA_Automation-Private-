'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class SeleniumWrapper:
    """Wrapper class for common Selenium actions"""

    def __init__(self, driver):
        self.driver = driver

    def enter_text(self, locator_type, locator_value, text):
        """Enter text into a field"""
        element = WebDriverWait(self.driver, 10).until(
            EC.presence_of_element_located((locator_type, locator_value))
        )
        element.clear()  # Clear any existing text
        element.send_keys(text)

    def click_element(self, locator_type, locator_value):
        """Click on an element"""
        element = WebDriverWait(self.driver, 10).until(
            EC.element_to_be_clickable((locator_type, locator_value))
        )
        element.click()

    def wait_for_page_load(self, timeout):
        """Wait for page to fully load"""
        WebDriverWait(self.driver, timeout).until(
            EC.presence_of_element_located((By.TAG_NAME, "body"))
        )
