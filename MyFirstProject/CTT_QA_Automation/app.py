from flask import Flask, render_template, request

import importlib
import os
import sys
import inspect
from scripts.conftest import get_driver # ✅ Import the WebDriver setup function

# Handle different environments (PyInstaller bundle or normal)
if getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS'):
    # If running as a PyInstaller bundle, use _MEIPASS to locate templates and static folders
    template_dir = os.path.join(sys._MEIPASS, 'templates')
    static_dir = os.path.join(sys._MEIPASS, 'static')
    app = Flask(__name__, template_folder=template_dir, static_folder=static_dir)
else:
    # Normal environment, default template and static folder
    app = Flask(__name__, template_folder='Template')

@app.route('/')
def index():
    return render_template('form.html')
    print("Received Form Data:", request.form)  # Debugging statement


@app.route('/automation', methods=['POST'])
def run_automation():
    #print(f"Hi form data {request.form}")
    #print(request.form.keys())
    search_key = request.form.get("script_name")
    print(f"Dynamic form data {search_key}")
    #search_key = "test_login_cases"
    
    if not search_key:
        return "No script name provided", 400

    module_name = f'scripts.{search_key}'

    try:
        test_module = importlib.import_module(module_name)

        # Pick up functions starting with "selenium_" (modify if needed)
        selenium_functions = [
            func for func, _ in inspect.getmembers(test_module, inspect.isfunction)
            if func.startswith("test_")
        ]

        results = []
        for func_name in selenium_functions:
            func = getattr(test_module, func_name)
            args = inspect.signature(func).parameters

            setup_driver = get_driver()  # ✅ Launch NEW WebDriver instance for EACH test
 
            try:
                if "setup" in args:
                    result = func(setup_driver)  # ✅ Pass fresh WebDriver instance
                else:
                    result = func()
            finally:
                print(f"\nClosing browser session for {func_name}...")
                setup_driver.quit()  # ✅ Close WebDriver after executing the test

            results.append(f"{func_name}: {result}")

        return "<br>".join(results)

    except ModuleNotFoundError:
        return f"Script '{module_name}' not found"
    except Exception as e:
        return f"An error occurred: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)




