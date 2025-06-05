# 📱 SocialMauiApp

[![.NET 9](https://img.shields.io/badge/.NET-9-blueviolet)](https://dotnet.microsoft.com/en-us/)
[![Platform](https://img.shields.io/badge/Platform-Android-green)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**SocialMauiApp** is a simple social media application built with **.NET MAUI** and **.NET 9**.  
It allows users to register, post content, and interact with others.  
The app supports basic user account management and is currently optimized for **Android only**.

---

## 📚 Table of Contents

- [Features](#features)
- [Technology Stack](#technology-stack)
- [System Requirements](#system-requirements)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Development Status](#development-status)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## ✨ Features

### ✅ Available

- 📧 Email registration and login  
- 🔐 Password change  
- 📝 Create and view posts  
- 💬 Comment on posts  
- 📰 View all user feeds  
- 👤 Basic user administration (admin-only)

### 🚫 Not yet implemented

- ❌ Friend list management  
- ❌ QR code scanning  
- ⚠️ User administration is currently limited (e.g., no role filtering)

---

## 🛠 Technology Stack

- [.NET MAUI](https://learn.microsoft.com/en-us/dotnet/maui/) – Cross-platform UI framework  
- [.NET 9 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/9.0)  
- [ASP.NET Core Web API](https://learn.microsoft.com/en-us/aspnet/core/web-api/) – Backend services  
- [Entity Framework Core](https://learn.microsoft.com/en-us/ef/core/) – ORM  
- [SQLite](https://www.sqlite.org/index.html) – Local data storage  
- C# – Programming language

---

## ⚙️ System Requirements

- **Visual Studio 2022** or later
- **.NET 9 SDK**
- **.NET MAUI workload** installed  
  Run the following command if not installed:
  dotnet workload install maui
Android Emulator or Physical Android Device

⚠️ The app is currently tested and stable only on Android.
Other platforms (iOS, macOS, Windows) may build successfully but are not fully functional yet.

🚀 Getting Started
1. Clone the repository
git clone https://github.com/PhamTrung1204/SocialMauiApp.git

3. Open the solution
Open SocialMauiApp.sln using Visual Studio 2022+

4. Build & Run
Set SocialMauiApp as the startup project

Choose an Android device/emulator

Click Run or press F5

📁 Project Structure

SocialMauiApp/            -> .NET MAUI mobile frontend (Android UI)

SocialMauiApp.Api/        -> ASP.NET Core Web API backend

SocialMediaMaui.Shared/   -> Shared DTOs and models between client and server

📊 Development Status
Feature	Status
Android Support	✅ Stable

iOS / macOS / Windows	⚠️ Builds but unstable

Email Registration	✅ Complete

Change Password	✅ Complete

Post & Comment	✅ Complete

QR Code Scanning	❌ Not available

Friend List Management	❌ Not available

User Administration (Admin)	⚠️ Limited

🤝 Contributing
Contributions are welcome! 🚀

Fork this repo

Create a new branch:

git checkout -b feature/my-feature
Make changes and commit:

git commit -m "Add feature XYZ"
Push to the branch:

git push origin feature/my-feature
Open a Pull Request

📄 License
This project is licensed under the MIT License.
See the LICENSE file for more information.

📬 Contact
Author: PhamTrung1204

Email: phamtrung2004py@gmail.com

