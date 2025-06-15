# 🚀 CT-Automation

**Control Tower UI Automation Suite**  
Automated end-to-end tests for Pivotree Control Tower dashboards, built using [Robot Framework](https://robotframework.org/) + SeleniumLibrary.

---

## 📁 Project Structure

```
CT-Automation/
├── page-objects/      # Page object keywords for each screen/module
├── resources/         # Common resources, variables, selectors, waits
├── tests/             # Robot test cases (organized per customer)
├── .venv/             # Python virtual environment (excluded from Git)
├── requirements.txt   # Required Python libraries
├── utils/             # Util libraries
├── api/               # API libraries
├── tests/francescas   # Example Robot test cases (organized for customer francescas)
└── README.md          # You're here!
```

---

## ⚙️ Setup Instructions

### 🐍 1. Create virtual environment

```bash
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
```

### 📦 2. Install dependencies

```bash
pip install -r requirements.txt
```

> ✅ Dependencies include:
> - `robotframework`
> - `robotframework-seleniumlibrary`
> - `robotframework-requests`
> - `robotframework-jsonlibrary`
> - `pandas openpyxl`

---

## 🧪 Running Tests

```bash
robot -d results tests/
```

You can also run a specific test file:

```bash
robot -d results tests/dashboard_smoke.robot
```

---

## 🔐 Environment Setup

Update environment configs in:

```robot
resources/config.robot
```

> Store credentials & URLs here (use secrets manager or `.env` file for real secrets).

---

## ✅ CI/CD Integration (Optional)

Coming soon: Bitbucket Actions config to run tests on push and PRs.

---

## 📦 Sample Test Execution Output

Reports and logs are stored in the `results/` folder after every run:

- `log.html` – Detailed execution log
- `report.html` – High-level report
- `output.xml` – Robot's raw output file

---

## 🙌 Contributing

- Use meaningful commit messages
- Keep test cases modular and readable
- Reuse page-object keywords wherever possible

---

## 👨‍💻 Maintainers
- `@Karthikeyan` `@Ponmanimaran` – Architect
- `@Teju` – Automation Lead
- `@Roshini` `@Anitha` `@Saravanan` – Contributor

---

## 📄 License

