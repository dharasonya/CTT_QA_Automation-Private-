'''
Created on 08-Jun-2025
@author: sonyarani.dhara
'''

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.edge.service import Service as EdgeService
import time
import json

class BaseSetupSteps:
    def __init__(self, config_file):
        """Initialize browser setup with configuration file."""
        try:
            with open(config_file, "r") as file:
                config = json.load(file)
        except FileNotFoundError:
            raise FileNotFoundError(f"Config file not found: {config_file}")
        except json.JSONDecodeError:
            raise ValueError(f"Invalid JSON format in config file: {config_file}")

        self.browser = config.get("browser", "chrome").lower()
        self.driver_path = config.get("driver_path", "")
        self.url = config.get("url", "")

        # Debugging print statements
        print(f"Browser: {self.browser}")
        print(f"Driver Path: {self.driver_path}")
        print(f"URL: {self.url}")

        # Ensure URL is valid before proceeding
        if not self.url:
            raise ValueError("URL is missing in the configuration file.")

        # Setup WebDriver
        self.driver = self.setup_browser(self.browser, self.driver_path)
        self.driver.maximize_window()  # Maximize the browser window
        self.open_url(self.url)

    def setup_browser(self, browser, driver_path):
        """Setup WebDriver based on selected browser."""
        if browser == "chrome":
            service = Service(driver_path)
            return webdriver.Chrome(service=service)
        elif browser == "firefox":
            service = FirefoxService(driver_path)
            return webdriver.Firefox(service=service)
        elif browser == "edge":
            service = EdgeService(driver_path)
            return webdriver.Edge(service=service)
        else:
            raise ValueError(f"Unsupported browser: {browser}")

    def open_url(self, url):
        """Open the specified URL."""
        self.driver.get(url)
        time.sleep(5)  # Keeps browser open for 5 seconds before closing
