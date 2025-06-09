'''
Created on 09-Jun-2025

@author: sonyarani.dhara
'''
import configparser
import os
from pathlib import Path

current_dir = os.getcwd()  # Gets current directory path
print("current_dir :",current_dir)

# Extract base path up to 'CTT_QA_Automation'
base_path = os.path.join(current_dir.split("CTT_QA_Automation")[0], "CTT_QA_Automation")
# Append your custom path
config_path = os.path.join(base_path, "Configurations", "config.ini")

config=configparser.RawConfigParser()

# config.read(config_path)
config.read(config_path)
print(f"Sections found: {config.sections()}")

# Read relative driver path from config file
relative_driver_path = config.get("ctt login info", "chrome_driver_path")

# Generate full driver path
# Ensure base_path is a Path object
base_path = Path(base_path)  # Convert string to Path object
# Append relative path correctly
driver_path = base_path / relative_driver_path  # This works since base_path is now a Path object
print("Driver Chrome Path:", driver_path)


class Read_Config:
    
    @staticmethod
    def get_ctt_page_url():
        url=config.get('ctt login info','ctt_page_url')
        return url
    
    @staticmethod
    def get_chrome_driver_path():
        """Returns the resolved Chrome driver path."""
       
        return str(driver_path)  # Convert to string if required

    
    
    @staticmethod
    def get_username():
        username=config.get('ctt login info','username')
        return username
    
    @staticmethod
    def get_password():
        password=config.get('ctt login info','password')
        return password
    
    @staticmethod
    def get_invalid_username():
        invalid_username=config.get('ctt login info','invalid_username')
        return invalid_username
    
    @staticmethod
    def get_invalid_password():
        invalid_password=config.get('ctt login info','invalid_password')
        return invalid_password
    
    @staticmethod
    def get_browser_name():
        browser=config.get('ctt login info','browser')
        return browser