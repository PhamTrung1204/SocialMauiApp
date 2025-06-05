📱 SocialMauiApp
SocialMauiApp is a cross-platform social media application built with .NET MAUI and .NET 9. It enables users to register via email, post content, comment on others' posts, and manage their personal accounts. The app also includes a basic user administration feature for admin users.

🚀 Features
📧 Email Registration – Sign up using an email address.

🔐 Login / Logout – Secure authentication.

🔄 Change Password – Update password directly in-app.

📝 Create Posts – Share posts with text and images.

💬 Comment on Posts – Interact with others through comments.

📰 User Feed – Scrollable list of shared posts.

🛠️ Basic User Administration – View and manage registered users (admin only).

⚠️ Limitations:

❌ Friend list management is not implemented.

❌ QR code scanning is not integrated yet.

⚠️ User administration is available but still limited in features (e.g., no role management, filtering, or audit logs).

✅ Only Android is fully supported. iOS, Windows, and macOS may compile but could crash or misbehave.

🛠️ Tech Stack
.NET MAUI – UI for mobile and desktop apps

.NET 9 – Latest SDK/runtime

ASP.NET Core Web API – Backend services

Entity Framework Core – ORM for data handling

SQLite – Local storage for mobile clients

C# – Main programming language

📁 Project Structure
less
Sao chép
Chỉnh sửa
SocialMauiApp/           // .NET MAUI frontend
SocialMauiApp.Api/       // ASP.NET Core Web API backend
SocialMediaMaui.Shared/  // Shared DTOs and models
⚙️ Requirements
Visual Studio 2022 or later

.NET 9 SDK

.NET MAUI workload installed

Android emulator or real device

🧪 Current Status
Feature	Status
Android Support	✅ Stable
iOS / Windows / macOS	⚠️ Builds but may crash
Email Registration	✅ Complete
Change Password	✅ Complete
Friend Management	❌ Not available
QR Code Scanning	❌ Not available
User Administration (Admin)	⚠️ Basic view-only management

🚀 Getting Started
Clone the repository:

bash
Sao chép
Chỉnh sửa
git clone https://github.com/PhamTrung1204/SocialMauiApp.git
Open the solution:

Use Visual Studio 2022.

Open the SocialMauiApp.sln file.

Run on Android:

Set startup project to SocialMauiApp.

Choose Android device/emulator.

Press F5 or click Run.

🤝 Contributing
Contributions are welcome!

Fork the repository

Create a feature branch

Commit and push changes

Submit a pull request

📄 License
This project is licensed under the MIT License. See the LICENSE file for more information.

📬 Contact
Author: PhamTrung1204

Email: phamtrung2004py@gmail.com

