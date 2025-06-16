from flask import Flask
from flask import Flask, render_template,request,redirect, url_for, send_file
import sys
import  subprocess


app = Flask(__name__)

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

    # ✅ Run Robot Framework with captured form inputs
    print(f"✅ Selected Script: {script_name}")
    print(f"✅ Username: {username}")
    print(f"✅ Password: {password}")
    print(f"✅ Enviornment: {environment}")
    print(f"✅ Browser: {browser}")
    
    print(f"✅ Flask received inputs: Script={script_name}, Username={username}, Password={password}", flush=True)
    
    return execute_robot_tests(script_name, browser, "https://development.d36z6oo50ky8dh.amplifyapp.com/login", username, password)

# ✅ Function to Execute Robot Framework Tests
def execute_robot_tests(script_name, browser, environment_url, username, password):
    robot_test_suite = f"tests/francescas/{script_name}.robot"

    try:
        command = [
        "robot",
        f"--variable", f"ENV_URL:{environment_url}",
        f"--variable", f"USERNAME:{username}",
        f"--variable", f"PASSWORD:{password}",
        "--outputdir", "ctt-qa-tests/reports",  # ✅ Correct output directory
        robot_test_suite
        ]   
        print(f"✅ Executing command: {' '.join(command)}", flush=True)  # Debugging print

        print(f"✅ Running Robot Framework Test: {robot_test_suite}")
        result = subprocess.run(command, capture_output=True, text=True)
        print(f"✅ Flask passing: ENV_URL={environment_url}, USERNAME={username}, PASSWORD={password}", flush=True)

        print("✅ Robot Test Output:\n", result.stdout)

        # return f"✅ Test Results:<br>{result.stdout.replace('\n', '<br>')}"
        return redirect(url_for('show_report'))

    except Exception as e:
        print(f"⚠️ Error running Robot Framework tests: {e}")
        return f"⚠️ Test execution failed: {str(e)}", 500

@app.route('/report')
def show_report():
    return send_file("ctt-qa-tests/reports/report.html")  # ✅ Fix the path

if __name__ == "__main__":
    app.run(debug=True, port=8086)  # You can change the port number if needed