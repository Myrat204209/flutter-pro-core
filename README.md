# flutter-pro-core

# 🚀 Flutter Multi-Package Enterprise Template

A production-ready Flutter template enforcing Clean Architecture, strict package isolation, and BLoC state management. Powered by Dart Workspaces and automated via a robust Makefile workflow.

## 🚀 Getting Started (Using this Template)

1. **Create your repository:** Click the green **"Use this template"** button on GitHub.
2. **Clone your new repo:** `git clone https://github.com/Myrat204209/flutter-pro-core.git`
3. **Initialize your brand:** Use the Makefile to rename the app and bundle ID in one command.

   ```Bash
   make init-project name="My Cool App" bundle="com.mycompany.coolapp"
   ```
4. **Update Visuals:**
    * Replace `assets/icon/app_icon.png` with your 1024x1024 app icon.
    * Replace `assets/splash/splash_logo.png` with your splash screen logo.
    * Run the native generation command:
    ```Bash
    make gen-native-ui
    ```

5. **Generate Code & Run:**

```Bash
make setup
flutter run
```
## 🏗️ Architecture Overview

This project utilizes **Dart Workspaces** (Dart 3.5+) to manage a multi-package architecture. This enforces a strict separation of concerns. 

The workspace is divided into the core app and three isolated packages:

* **`lib/` (Main App):** The application layer. Contains all UI assembly, routing, and **all BLoC state management**. It depends on the packages below.
* **`packages/app_ui/`:** The presentation layer. Contains the design system, generic widgets, and raw assets. **Cannot depend on `lib` or `data_provider`.**
* **`packages/data_provider/`:** The data layer. Handles all external API calls, local storage, and data parsing. **Cannot depend on `lib` or `app_ui`.**
* **`packages/form_inputs/`:** The validation layer. Contains reusable Formz input models. Completely independent.

---

## 📂 Folder Structure & Responsibilities

### 1. The `app_ui` Package (Design System)
All visual elements and raw assets live here.
* **`assets/images/` & `assets/svgs/`:** Place your raw `.png`, `.jpg`, and `.svg` files here. Run `make gen-assets` to generate type-safe references via FlutterGen.
* **`assets/fonts/`:** Place `.ttf` or `.otf` files here.
* **`lib/src/colors/` & `lib/src/theme/`:** Define your `AppColors` and `ThemeData` here.
* **`lib/src/widgets/`:** Pure, stateless, reusable UI components (e.g., `CustomPrimaryButton`, `StyledTextField`). No business logic allowed!

### 2. The `data_provider` Package (Data Layer)
All communication with the outside world happens here.
* **`lib/client/`:** Place your Retrofit API clients (`.dart` and `.g.dart`) here. 
* **`lib/models/`:** Place your data models and Data Transfer Objects (DTOs) here. Use `json_serializable`. Put your API-specific `enums` here as well.
* **`lib/api/`:** Interceptors, error handlers, and base HTTP configurations.
* **`lib/storage/` & `lib/hive/`:** Local persistence logic (Hive boxes, secure storage).
* *Note: Run `make build-data` to generate Retrofit and JSON Serializable files.*

### 3. The `lib` Directory (Main App & Business Logic)
This is where the app is assembled.
* **BLoC / State Management:** All BLoCs, Events, and States live here. We strictly use `Equatable` sealed classes for Events and final classes for States.
* **Features:** Grouped by feature (e.g., `lib/features/login/`). Each feature contains its specific UI screens and BLoCs.

---

## 🛠️ Developer Workflow (Makefile)

We use a `Makefile` to eliminate repetitive command-line tasks. If you can't deploy it from a terminal, the workflow isn't finished!

### ⚙️ Setup & Code Generation
Run these commands when cloning the project, switching branches, or adding new assets/models.

| Command | Description |
| :--- | :--- |
| `make setup` | **The Combo Command.** Runs all generation tasks across all packages. Use this when starting fresh. |
| `make icons` | Generates icon fonts in `app_ui`. |
| `make gen-assets` | Triggers FlutterGen in `app_ui` for type-safe images/SVGs. |
| `make build-data` | Runs `build_runner` in `data_provider` (Retrofit, JSON serialization). |
| `make build-root` | Runs `build_runner` in the root app (Routing, Envied). |

### 🧹 Cleaning
| Command | Description |
| :--- | :--- |
| `make clean` | Cleans the root project and gets pub packages. |
| `make clean-all` | Deep cleans the root app, `app_ui`, and `data_provider`. |

### 🌿 Git Workflow
| Command | Description |
| :--- | :--- |
| `make new-branch b=name`| Creates a new branch `name`, checks it out, and pushes it to origin. |
| `make sync-main` | Switches to `main` and pulls the latest changes. |

### 🚀 Release Builds (CI/CD Ready)
| Command | Description |
| :--- | :--- |
| `make build-android-apk` | Builds a release APK (obfuscated). |
| `make build-android-aab` | Builds a release App Bundle for Google Play. |
| `make build-ios-adhoc` | Builds an iOS IPA for Diawi/Firebase App Distribution. |
| `make build-ios-appstore`| Builds an iOS IPA ready for Apple TestFlight/App Store. |

---
*Built with strict Clean Architecture principles.*
