
 Health Tracker App (Flutter)
A simple Flutter application for tracking basic health measurements such as Blood Pressure and Blood Sugar, with clear results and predefined normal ranges.

 This project is for educational purposes only and does not provide medical diagnosis.

Application Overview
The Health Tracker App allows users to:

Enter health values

Validate inputs

Display health status results

View normal ranges for each measurement

The app focuses on clean UI, simple logic, and Flutter fundamentals.

 Features
Blood Pressure input:

Systolic (SYS)

Diastolic (DIA)

Blood Sugar input

One-click Check button to evaluate results

Results displayed below inputs

Clear normal ranges for each measurement

Reset all inputs easily

User-friendly and responsive UI

 Health Rules Used (Demo Only)
Blood Pressure – Systolic (SYS)
Status	Range
Low	< 90
Normal	90 – 119
Elevated	120 – 139
High	≥ 140

Blood Pressure – Diastolic (DIA)
Status	Range
Low	< 60
Normal	60 – 79
Elevated	80 – 89
High	≥ 90

Blood Sugar
Status	Range
Low	< 70 mg/dL
Normal	70 – 140 mg/dL
High	> 140 mg/dL

🛠 Built With
Flutter

Dart

Material Design (Material 3)

 Getting Started
Prerequisites
Flutter SDK installed

VS Code or Android Studio

Emulator or physical device

Installation & Run
bash
نسخ الكود
flutter pub get
flutter run
 Project Structure
vbnet
نسخ الكود
lib/
 ├── main.dart
 └── health_tracker_page.dart
test/
 └── widget_test.dart (optional)
 What This Project Demonstrates
StatefulWidget usage

TextEditingController

Input validation

Conditional logic

UI layout using:

Card

ListView

ListTile

Flutter best practices for beginner projects

 
Clean code structure

