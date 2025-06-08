'''
Created on 08-Jun-2025

@author: sonyarani.dhara
# '''

import pytest
from base_pages.login_page import LoginPage

def test_login(setup): 
    
    """Test login functionality using fixture-injected WebDriver.""" 
    assert setup is not None, "WebDriver instance was not passed to test function!"
    print("WebDriver instance received successfully!")

    # Instantiate LoginPage using the fixture
    login_page = LoginPage(setup)  
    login_page.login("aarushp123098@gmail.com", "OLOtx095")


# ✅ test_valid_login – Verify login with correct credentials
# ✅ test_invalid_login – Attempt login with incorrect credentials
# ✅ test_empty_credentials – Login attempt with blank username/password
# ✅ test_login_with_locked_account – Verify behavior for locked user accounts
# ✅ test_session_after_login – Ensure session management post-login

