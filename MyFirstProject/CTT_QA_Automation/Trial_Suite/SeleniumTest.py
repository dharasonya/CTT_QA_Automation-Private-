'''
Created on 07-Jun-2025

@author: sonyarani.dhara
'''

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
import time

# Set up Chrome WebDriver correctly
service = Service("C:/Users/sonyarani.dhara/WorkingDrive/BitBucket/ctt-qa-automation/myDrivers/chromedriver.exe")
driver = webdriver.Chrome(service=service)

# Maximize the browser window
driver.maximize_window()

# Open a website
driver.get("https://www.google.com")

# Print the page title
print(driver.title)

time.sleep(5)  # Keeps browser open for 30 seconds before closing
driver.quit()