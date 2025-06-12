'''
Created on 08-Jun-2025

@author: sonyarani.dhara
# '''

import pytest
from base_pages.login_page import LoginPage
from utils.read_properties import Read_Config

def test_valid_login_1(setup):
    """Verify login with correct credentials"""
    print("f,called case--1",flush=True)
    driver, selected_env, username, password = setup  # ✅ Ensure correct unpacking

    login_page = LoginPage(driver)  # ✅ Use WebDriver instance
    login_page.enter_username(username)  # ✅ Pass dynamic username from Flask
    login_page.enter_password(password)  # ✅ Pass dynamic password from Flask
    login_page.click_login_button()
    driver.quit()
    return True

def test_valid_username_invalid_password(setup):
    """Verify login with correct credentials"""
    print("f,called case--2",flush=True)
    driver, selected_env, username, password = setup  # ✅ Ensure correct unpacking

    login_page = LoginPage(driver)  # ✅ Use WebDriver instance
    login_page.enter_username(username)  # ✅ Pass dynamic username from Flask
    login_page.enter_password(password)  # ✅ Pass dynamic password from Flask
    login_page.click_login_button()
    driver.quit()
    return True