import pytest
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.edge.service import Service as EdgeService
from utils.selenium_wrappers import SeleniumWrapper
from utils.read_properties import Read_Config

@pytest.fixture(scope="function")
def setup():
    """Pytest fixture for setting up WebDriver using config.ini"""

    driver = get_driver()  # Use the Flask-accessible WebDriver function

    # Initialize SeleniumWrapper with WebDriver instance
    wrapper = SeleniumWrapper(driver)
    wrapper.wait_for_page_load(10)

    yield driver  # ✅ Provide WebDriver instance directly

    print("\nClosing browser session...")
    driver.quit()

def get_driver():
    """Initialize and return a WebDriver instance for Flask"""
    browser_name = Read_Config.get_browser_name()
    driver_path = Read_Config.get_chrome_driver_path()
    url = Read_Config.get_ctt_page_url()

    if not url:
        raise ValueError("URL is missing in the configuration file.")

    # Setup WebDriver based on browser selection
    driver = None
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
        raise ValueError(f"Unsupported browser: {browser_name}")

    driver.maximize_window()
    driver.get(url)

    return driver  # ✅ Now accessible from Flask