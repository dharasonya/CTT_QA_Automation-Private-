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
# from utils.path_utils import readConfigFile
from utils.read_properties import Read_Config


@pytest.fixture(scope="function")
def setup():
    
    """Pytest fixture for setting up WebDriver using config.ini"""

    browser_name = Read_Config.get_browser_name()
    #print(f"Resolved browser_name: {browser_name}")  # Debugging print
    driver_path = Read_Config.get_chrome_driver_path()
    #print(f"Resolved driver path: {driver_path}")  # Debugging print
    url = Read_Config.get_ctt_page_url()
    #print(f"Resolved url: {url}")  # Debugging print
    
    if not url:
        pytest.fail("URL is missing in the configuration file.")

    # Setup WebDriver
    if browser_name == "chrome":
        service = Service(driver_path)
        driver = webdriver.Chrome(service=service)
    elif browser_name == "firefox":
        service = FirefoxService(driver_path)
        driver = webdriver.Firefox(service=service)
    elif browser_name == "edge":
        service = EdgeService(driver_path)
        driver = webdriver.Edge(service=service)
    else:
        pytest.fail(f"Unsupported browser: {browser_name}")

    driver.maximize_window()
    driver.get(url)

    # Initialize SeleniumWrapper instance
    wrapper = SeleniumWrapper(driver)
    wrapper.wait_for_page_load(10)  

    yield driver  # ✅ Provide WebDriver instance to tests

    print("\nClosing browser session...")
    driver.quit()