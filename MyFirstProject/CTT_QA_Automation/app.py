from flask import Flask, render_template, request
import configparser
import importlib
import inspect
import os
from scripts.conftest import setup  # ✅ WebDriver setup function

app = Flask(__name__)

# ✅ Function to Load Configuration
def load_config():
    config = configparser.ConfigParser()
    config.read(os.path.abspath(".\\configurations\\config.ini"))
    return config

config = load_config()

# ✅ Function to Fetch Environment Mapping
def get_environment_map():
    if "ENVIRONMENT" in config:
        return dict(config["ENVIRONMENT"])
    else:
        print("⚠️ Error: 'ENVIRONMENT' section not found in config.ini")
        return {}

environment_map = get_environment_map()

# ✅ Function to Get Driver Path
def get_driver_path():
    if "ctt login info" in config:
        return config["ctt login info"].get("chrome_driver_path", ".\\drivers\\chromedriver.exe")
    else:
        print("⚠️ Error: 'ctt login info' section not found in config.ini")
        return ".\\drivers\\chromedriver.exe"

@app.route('/')
def index():
    print("✅ Rendering Form Page", flush=True)
    return render_template('form.html')

@app.route('/automation', methods=['POST'])
def run_automation():
    print(f"✅ Form data received: {request.form}", flush=True)

    # ✅ Retrieve inputs from the form
    script_name = request.form.get("script_name")
    username = request.form.get("username")
    password = request.form.get("password")
    environment = request.form.get("environment")
    browser = request.form.get("browser")

    # ✅ Get environment URL
    environment_url = environment_map.get(environment, "⚠️ Invalid Environment")
    driver_path = get_driver_path()

    print(f"✅ Selected Environment: {environment} -> {environment_url}")
    print(f"✅ Selected Script: {script_name}")
    print(f"✅ Username: {username}")
    print(f"✅ Browser: {browser}")

    return execute_tests(script_name, browser, driver_path, environment_url, username, password)

# ✅ Function to Execute Tests
def execute_tests(script_name, browser, driver_path, environment_url, username, password):
    module_name = f'scripts.{script_name}'

    try:
        test_module = importlib.import_module(module_name)

        selenium_functions = [
            func for func, _ in inspect.getmembers(test_module, inspect.isfunction)
            if func.startswith("test_")
        ]

        print(f"✅ Test cases picked from {module_name}: {selenium_functions}", flush=True)

        results = []

        for func_name in selenium_functions:
            func = getattr(test_module, func_name)
            args = inspect.signature(func).parameters

            setup_driver = setup(browser, driver_path, environment_url, username, password)

            try:
                result = func(setup_driver) if "setup" in args else func()
            finally:
                if setup_driver:
                    print(f"✅ Closing browser session for {func_name}...")
            results.append(f"{func_name}: {result}")

        return "<br>".join(results)

    except ModuleNotFoundError:
        return f"⚠️ Error: Script '{module_name}' not found", 404

    except Exception as e:
        print(f"⚠️ Exception occurred: {e}", flush=True)
        return f"⚠️ An error occurred: {str(e)}", 500

# ✅ Start Flask Server
if __name__ == "__main__":
    app.run(debug=True, port=8084)