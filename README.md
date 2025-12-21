# Industry 4.0 Series: Brake Disk Quality Prediction

[![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)](https://www.python.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17%2F18-blue.svg)](https://www.postgresql.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📌 Project Overview
This repository is the first of a specialized series focused on **Industrial IoT and Smart Manufacturing**. It implements an end-to-end Machine Learning solution to predict the quality of brake disks during the machining process in an automotive parts factory.

The system uses real-time sensor data (Temperature, Vibration, and Pressure) to classify whether a part is **Approved** or **Rejected**, preventing defective units from reaching the assembly line.

---

## 🏗️ System Architecture

| Layer | Component | Description |
| :--- | :--- | :--- |
| **Data Generation** | `simulator.py` | A Python pipeline that creates synthetic sensor data with industrial failure logic. |
| **Storage** | **PostgreSQL** | Relational database running in Docker to store production logs and ML results. |
| **Intelligence** | **Scikit-Learn** | Machine Learning model trained to identify patterns of structural defects. |
| **Delivery** | **FastAPI** | RESTful API that provides real-time quality predictions via JSON endpoints. |

---

## 📊 Sensor Data Schema

To simulate a real factory environment, the following telemetry is collected for every produced part:

| Variable | Unit | Critical Threshold (Failure Trigger) |
| :--- | :--- | :--- |
| **Temperature** | °C | Values > 85°C indicate cooling system failure or tool wear. |
| **Vibration** | RMS | Values > 4.8 RMS suggest bearing instability or misalignment. |
| **Pressure** | bar | Pressure drops below 90 bar lead to unstable machining. |
| **Cycle Time** | seconds | Deviations from the 45s standard indicate process anomalies. |

---

## 🚀 How to Run (Local Development)

### Prerequisites
* **Visual Studio Code** (Recommended IDE)
* **Git** for version control

### Setup Instructions
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/lucas-aoki02/industry40-quality-prediction-brake-disk.git]
   cd industry40-quality-prediction-brake-disk
