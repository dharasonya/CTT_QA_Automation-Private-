'''
Created on 08-Jun-2025

@author: sonyarani.dhara
# '''

import pytest
from base_pages.login_page import LoginPage
from utils.read_properties import Read_Config

def test_valid_login(setup): 
    '''Verify login with correct credentials'''
    login_page = LoginPage(setup)  
    login_page.enter_username(Read_Config.get_username())
    login_page.enter_password(Read_Config.get_password())
    login_page.click_login_button()
  
    
def test_invaldvalid_login(setup): 
    '''Attempt login with incorrect credentials'''
    login_page = LoginPage(setup)  
    login_page.enter_username(Read_Config.get_invalid_username())
    login_page.enter_password(Read_Config.get_invalid_password())
    login_page.click_login_button()

def test_test_valid_credentials_invalid_password(setup): 
    login_page = LoginPage(setup)  
    login_page.enter_username(Read_Config.get_username())
    login_page.enter_password(Read_Config.get_invalid_password())

    login_page.click_login_button()



# ✅ test_empty_credentials – Login attempt with blank username/password
# ✅ test_login_with_locked_account – Verify behavior for locked user accounts
# ✅ test_session_after_login – Ensure session management post-login

