# 🚀 Flutter Multi-Package Enterprise Template (`flutter-pro-core`)

A production-ready Flutter starter template enforcing **Clean Architecture**, **strict package isolation**, **Formz validation**, and **BLoC state management**. Powered natively by **Dart Workspaces** (Dart 3.5+) and fully automated via a robust **Makefile workflow**.

---

## ⚡ Quick Start

### 1. Create & Clone Your Project
Click **"Use this template"** on GitHub or clone directly:
```bash
git clone https://github.com/Myrat204209/flutter-pro-core.git my_app
cd my_app
```

### 2. Rename Project & Bundle Identifier
Use the built-in Makefile task to rename the app and bundle ID across Android and iOS in one step:
```bash
make init-project name="My Awesome App" bundle="com.mycompany.awesomeapp"
```

### 3. Update Visuals & Native Splash
Replace placeholder branding files in `assets/`:
* `assets/icon/app_icon.png` (1024x1024 app icon)
* `assets/splash/splash_logo.png` (splash logo)

Generate native launcher icons and splash screens:
```bash
make gen-native-ui
```

### 4. Setup Workspace & Run
```bash
make setup
flutter run
```

---

## 🏗️ Architecture & Package Isolation

This monorepo uses native **Dart Workspaces** to enforce architectural boundaries and share dependencies via a single root `pubspec.lock`.

```
├── lib/                             # Application Layer (Orchestration, BLoC, Views)
│   ├── app/                         # App widget, theme routing, localization
│   ├── bootstrap.dart               # Startup pipeline, logging, error handling
│   ├── di/                          # Service Locator (get_it)
│   ├── features/                    # Feature-driven modules (e.g. login, home)
│   └── main.dart                    # Application entrypoint
│
├── packages/
│   ├── app_ui/                      # Presentation Layer (Design System)
│   │   ├── assets/                  # Images, SVGs, and Fonts
│   │   └── lib/src/                 # AppColors, AppTheme, AppTypography, Reusable Widgets
│   │                                # (Cannot depend on data_provider or lib)
│   │
│   ├── data_provider/               # Data Layer (Networking, Persistence, DTOs)
│   │   └── lib/src/                 # ApiClient (Dio + Talker), Models, TokenStorage, Repositories
│   │                                # (Cannot depend on app_ui or lib)
│   │
│   └── form_inputs/                 # Validation Layer (Domain Form Inputs)
│       └── lib/src/                 # Pure Dart Formz models (Email, Password)
```

### Dependency Flow Rules
```
┌────────────────────────────────────────────────────────┐
│               lib/ (Application Layer)                 │
│         BLoCs, Feature Views, Service Locator          │
└────────────┬──────────────────┬──────────────────┬─────┘
             │                  │                  │
             ▼                  ▼                  ▼
┌──────────────────────┐ ┌──────────────┐ ┌────────────────┐
│  packages/app_ui     │ │ packages/    │ │ packages/      │
│  Design System,      │ │ data_provider│ │ form_inputs    │
│  Theme, UI Widgets   │ │ Dio, Storage │ │ Formz Models   │
└──────────────────────┘ └──────────────┘ └────────────────┘
```
* **`app_ui`** is strictly isolated and never depends on `data_provider` or network logic.
* **`data_provider`** handles data persistence, models, and HTTP clients without UI knowledge.
* **`form_inputs`** contains pure validation rules without Flutter dependencies.
* **`lib/`** depends on all three packages to assemble features.

---

## 🛠️ Developer Workflow (Makefile)

| Command | Description |
| :--- | :--- |
| `make setup` | **The Master Setup.** Fetches all workspace dependencies and triggers code/asset generators. |
| `make test` | Runs unit, widget, and architecture tests across root and all packages. |
| `make analyze` | Runs static analysis across the entire workspace (`flutter analyze`). |
| `make gen-native-ui` | Regenerates native Android & iOS app icons and splash screens. |
| `make gen-assets` | Runs FlutterGen inside `app_ui` for type-safe SVG and image references. |
| `make build-data` | Runs `build_runner` inside `data_provider` (Retrofit, Hive, JSON). |
| `make clean` | Cleans root project artifacts and updates dependencies. |
| `make clean-all` | Deep cleans build caches across root, `app_ui`, `data_provider`, and `form_inputs`. |
| `make init-project` | Renames the application title and native bundle IDs using the modern `rename` CLI. |
| `make build-android-apk` | Builds an obfuscated release APK with split debug symbols. |
| `make build-android-aab` | Builds an obfuscated release Android App Bundle for Google Play. |
| `make build-ios-adhoc` | Builds an iOS release IPA using Ad-Hoc export options. |
| `make build-ios-appstore` | Builds an iOS release IPA ready for TestFlight / App Store submission. |

---

## 🧪 Testing & Verification

Every layer contains dedicated tests:
```bash
# Run all workspace tests:
make test
```
* **`packages/form_inputs`**: Validates pure input states, regex, and validation rules.
* **`packages/app_ui`**: Verifies `AppTheme` Material 3 definitions, contrast, and `AppButton` tap interactions.
* **`packages/data_provider`**: Verifies model JSON serialization, equality, and repository authentication handling.
* **Root (`lib/`)**: Full widget integration tests validating view rendering, state emissions, and navigation.
