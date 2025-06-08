'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''
from base_pages.base_setup import BaseSetupSteps
from utils.path_utils import readConfigFile  # Import utility class
import os

# Correct class implementation
class LoginFunctionality(BaseSetupSteps):
    def __init__(self):
        config_file = readConfigFile.get_project_file_path("configurations/config.json")  # Use the utility method
        super().__init__(config_file)


# Instantiate the class to check if the constructor is called
test = LoginFunctionality()
        
# ✅ test_valid_login – Verify login with correct credentials
# ✅ test_invalid_login – Attempt login with incorrect credentials
# ✅ test_empty_credentials – Login attempt with blank username/password
# ✅ test_login_with_locked_account – Verify behavior for locked user accounts
# ✅ test_session_after_login – Ensure session management post-login
