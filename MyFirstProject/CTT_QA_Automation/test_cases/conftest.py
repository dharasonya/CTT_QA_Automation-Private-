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
from utils.path_utils import readConfigFile

@pytest.fixture(scope="session")
def setup():
    
    """Pytest fixture for setting up WebDriver using config.json."""
    print("Test")
    config_file = readConfigFile.get_project_file_path("configurations/config.json")

    try:
        with open(config_file, "r") as file:
            config = json.load(file)
    except FileNotFoundError:
        pytest.fail(f"Config file not found: {config_file}")
    except json.JSONDecodeError:
        pytest.fail(f"Invalid JSON format in config file: {config_file}")

    browser_name = config.get("browser", "chrome").lower()
    driver_path = config.get("driver_path", "")
    url = config.get("url", "")

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