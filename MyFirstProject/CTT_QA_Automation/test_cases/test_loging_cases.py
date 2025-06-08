'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''
from base_pages.base_setup import BaseSetupSteps

class LoginFunctionality(BaseSetupSteps):
    def __init__(self, config_file=r"C:\Users\sonyarani.dhara\WorkingDrive\BitBucket\ctt-qa-automation\MyFirstProject\CTT_QA_Automation\configurations\config.json"):
        super().__init__(config_file)  # Pass the config file correctly to parent class

# Instantiate the class to check if the constructor is called
test = LoginFunctionality()
        
# ✅ test_valid_login – Verify login with correct credentials
# ✅ test_invalid_login – Attempt login with incorrect credentials
# ✅ test_empty_credentials – Login attempt with blank username/password
# ✅ test_login_with_locked_account – Verify behavior for locked user accounts
# ✅ test_session_after_login – Ensure session management post-login
