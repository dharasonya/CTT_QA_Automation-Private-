from flask import Flask, render_template, request
import sys
import inspect
import subprocess
from scripts.conftest import setup  # ✅ Import the WebDriver setup function
import importlib

app = Flask(__name__)

@app.route('/')
def index():
    print("✅ Rendering Form Page", flush=True)  # ✅ Corrected Debugging
    return render_template('form.html')  # ✅ Ensure `form.html` exists inside `templates/`

@app.route('/automation', methods=['POST'])
def run_automation():
    print(f"✅ Form data received: {request.form}", flush=True)
    # print(f"✅ Form keys: {list(request.form.keys())}", flush=True)

    # ✅ Environment mapping dictionary
    environment_map = {
        "development": "https://development.d36z6oo50ky8dh.amplifyapp.com/login",
        "staging": "https://www.oranecrm.com/",
        "production": "https://crm.orangemindz.in/admin/users/login"
    }

    # environment_map = {
    #     "development": "https://development.d36z6oo50ky8dh.amplifyapp.com/login",
    #     "staging": "https://staging.example.com/login",
    #     "production": "https://production.example.com/login"
    # }
    
    # ✅ Retrieve inputs from the form
    script_name = request.form.get("script_name")
    username = request.form.get("username")
    password = request.form.get("password")
    environment = request.form.get("environment")
    browser = request.form.get("browser")  # ✅ Capture browser selection

    # ✅ Get the mapped URL based on the selected environment
    environment_url = environment_map.get(environment, "⚠️ Invalid Environment")

    # ✅ Define driver path manually for now (you can retrieve it dynamically)
    driver_path = "C:\\Users\\sonyarani.dhara\\WorkingDrive\\BitBucket\\ctt-qa-automation\\MyFirstProject\\CTT_QA_Automation\\drivers\\chromedriver.exe"
    print(f"✅ Flask Mapped Environment: {environment} -> {environment_url}", flush=True)

    print(f"✅ Selected Script: {script_name}")
    print(f"✅ Username: {username}")
    print(f"✅ Password: {password}")
    print(f"✅ Environment: {environment_url}")
    print(f"✅ Browser: {browser}")

    module_name = f'scripts.{script_name}'

    try:
        # ✅ Import the selected test script dynamically
        test_module = importlib.import_module(module_name)

        # ✅ Pick up functions starting with "test_" (modify if needed)
        selenium_functions = [
            func for func, _ in inspect.getmembers(test_module, inspect.isfunction)
            if func.startswith("test_")
        ]

        # ✅ Print selected test cases before execution
        print(f"✅ Test cases picked from {module_name}: {selenium_functions}", flush=True)


        results = []

        for func_name in selenium_functions:
            func = getattr(test_module, func_name)
            args = inspect.signature(func).parameters

            setup_driver = setup(browser, driver_path, environment_url, username, password)
            # setup_driver, username, password = setup(browser, driver_path, environment_url, username, password)
            # print("--type---",type(setup_driver))  # Check what setup_driver contains  
            try:
                if "setup" in args:
                    result = func(setup_driver)  # ✅ Pass fresh WebDriver instance
                else:
                    result = func()
            finally:
                if setup_driver:
                    print(f"✅ Closing browser session for {func_name}...")
                    # setup_driver.quit()  # ✅ Close WebDriver after executing the test

            results.append(f"{func_name}: {result}")

        return "<br>".join(results)

    except ModuleNotFoundError:
        return f"⚠️ Error: Script '{module_name}' not found", 404

    except Exception as e:
        print(f"⚠️ Exception occurred: {e}", flush=True)
        return f"⚠️ An error occurred: {str(e)}", 500  # ✅ Return error properly


# '''Starting_Point''''
if __name__ == "__main__":
    app.run(debug=True, port=8082)  