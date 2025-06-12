'''
Created on 08-Jun-2025
@author: sonyarani.dhara
'''

import pytest
import json
import time 
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.edge.service import Service as EdgeService
from utils.selenium_wrappers import SeleniumWrapper
from utils.read_properties import Read_Config  # ✅ Ensure correct import

# def pytest_addoption(parser):
#     """Pytest command-line options"""
#     print("✅ Routed to Conftest", flush=True)  # ✅ Debugging print
#
#     parser.addoption("--env", action="store", help="Environment URL for tests")
#     parser.addoption("--username", action="store", help="Login Username")
#     parser.addoption("--password", action="store", help="Login Password")
#     parser.addoption("--browser", action="store", help="Browser Type (chrome/firefox/edge)")

def setup(browser_name, driver_path, url, username, password):
    """Initialize WebDriver, launch browser, and navigate to the environment URL"""
    print("url : ",url)
    selected_env="https://development.d36z6oo50ky8dh.amplifyapp.com/login"
    print("** Launching Browser Setup ***")
    print(f"✅ Flask Inputs - driver_path: {driver_path}")
    print(f"✅ Flask Inputs - Environment: {url}")
    print(f"✅ Flask Inputs - Username: {username}")
    print(f"✅ Flask Inputs - Password: {password}")
    print(f"✅ Flask Inputs - Browser: {browser_name}")

    # ✅ Mapping browser names to WebDriver services dynamically
    browser_services = {
        "chrome": (Service, webdriver.Chrome),
        "firefox": (FirefoxService, webdriver.Firefox),
        "edge": (EdgeService, webdriver.Edge)
    }

    # ✅ Check if the selected browser exists in the dictionary
    if browser_name.lower() in browser_services:
        service_class, driver_class = browser_services[browser_name.lower()]
        service = service_class(driver_path)
        driver = driver_class(service=service)
    else:
        raise ValueError(f"⚠️ Error: Unsupported browser - {browser_name}")

    # ✅ Maximize window and navigate to the correct environment URL
    driver.maximize_window()
    driver.get(url)

    print(f"✅ Browser launched successfully! Navigated to {url}", flush=True)

    return driver, selected_env, username, password  # ✅ Return WebDriver & credentials