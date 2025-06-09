'''
Created on 08-Jun-2025

@author: sonyarani.dhara
# '''

import pytest
from base_pages.login_page import LoginPage
from utils.read_properties import Read_Config

# test_login_cases.py
# def test_login_cases():
#     print("Executing test cases...")
#     return "Test Execution Completed-0"
#
# def test_valid_login(setup):
#     '''Verify login with correct credentials'''
#     login_page = LoginPage(setup)
#     login_page.enter_username(Read_Config.get_username())
#     login_page.enter_password(Read_Config.get_password())
#     login_page.click_login_button()
#     return "Test Execution Completed-1"

def test_valid_login(setup):
    """Verify login with correct credentials"""
    login_page = LoginPage(setup)
    login_page.enter_username(Read_Config.get_username())
    login_page.enter_password(Read_Config.get_password())
    login_page.click_login_button()

    #assert login_page.is_logged_in(), "Login test failed"  # ✅ Use assert to validate success
    return "Test Execution Completed-1" ## enabled for flask
    #print("Test Execution Completed-1")  # enabled for pytest

def test_invalid_username_invalid_password(setup): 
    '''Attempt login with incorrect credentials'''
    login_page = LoginPage(setup)  
    login_page.enter_username(Read_Config.get_invalid_username())
    login_page.enter_password(Read_Config.get_invalid_password())
    login_page.click_login_button()
    return "Test Execution Completed-2"

def test_valid_username_invalid_password(setup): 
    login_page = LoginPage(setup)  
    login_page.enter_username(Read_Config.get_username())
    login_page.enter_password(Read_Config.get_invalid_password())
    login_page.click_login_button()
    return "Test Execution Completed-3"



# ✅ test_empty_credentials – Login attempt with blank username/password
# ✅ test_login_with_locked_account – Verify behavior for locked user accounts
# ✅ test_session_after_login – Ensure session management post-login

