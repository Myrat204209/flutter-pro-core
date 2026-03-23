# ==========================================
# --- VARIABLES ---
# Update these paths if your project structure changes
# ==========================================
TARGET = lib/main/main.dart
SYMBOLS_DIR = ./build/symbols
ENV_PROD = APP_ENV=prod

.PHONY: setup icons gen-native-ui gen-assets build-data build-root clean clean-all build-android-apk build-android-aab build-ios-adhoc build-ios-appstore new-branch sync-main

# ==========================================
# --- 🏗️ 0. BOOTSTRAP NEW PROJECT ---
# ==========================================

# Run this ONLY ONCE when initializing a fresh repository from this template
bootstrap:
	@echo "🚀 Bootstrapping a fresh Flutter Clean Architecture App..."
	@read -p "Enter Project Name (e.g., my_app): " name; \
	read -p "Enter Organization ID (e.g., com.mycompany): " org; \
	read -p "Enter Platforms (comma-separated, e.g., android,ios,web): " platforms; \
	echo "⏳ Creating Flutter app '$$name' with empty template..."; \
	flutter create --empty --org "$$org" --project-name "$$name" --platforms "$$platforms" .; \
	echo "✅ Base app created successfully!"

# ==========================================
# --- 🛠️ 1. SETUP & GENERATION COMMANDS ---
# ==========================================

# The Combo Command: Run this when switching branches or starting fresh
setup:
	@echo "Starting full project generation across all packages..."
	$(MAKE) icons
	$(MAKE) gen-assets
	$(MAKE) build-data
	$(MAKE) build-root
	@echo "🎉 All generation complete! Your project is ready to run."

icons:
	@echo "Generating Icons(App UI)..."
	@cd packages/app_ui && dart run icon_font_generator:generator
	@echo "Icons updated!"

gen-native-ui:
	@echo "Generating App Icons..."
	dart run flutter_launcher_icons
	@echo "Generating Splash Screens..."
	dart run flutter_native_splash:create
	@echo "Native UI generated!"

gen-assets:
	@echo "Generating assets via FlutterGen (App UI)..."
	@cd packages/app_ui && fluttergen -c pubspec.yaml
	@echo "Assets generated!"

build-data:
	@echo "Running build_runner for Data Provider (Hive, Retrofit, JSON)..."
	@cd packages/data_provider && dart run build_runner build -d
	@echo "Data Provider generation complete!"

build-root:
	@echo "Running build_runner for Root (AutoRouter, Envied)..."
	dart run build_runner build -d
	@echo "Root generation complete!"

# ==========================================
# --- 🧹 2. CLEANING COMMANDS ---
# ==========================================

# Cleans just the main app folder
clean:
	@echo "Cleaning root project..."
	flutter clean
	flutter pub get
	@echo "Clean complete!"

# The Combo Clean: Travels through packages and cleans everything
clean-all:
	@echo "Deep cleaning the entire workspace..."
	@echo "Cleaning Root..."
	flutter clean && flutter pub get
	@echo "Cleaning App UI..."
	@cd packages/app_ui && flutter clean && flutter pub get
	@echo "Cleaning Data Provider..."
	@cd packages/data_provider && flutter clean && flutter pub get
	@echo "✨ Deep clean finished! Run 'make setup' to regenerate files."

# ==========================================
# --- 🚀 3. RELEASE BUILD COMMANDS ---
# ==========================================

build-android-apk:
	@echo "Building Android APK (Release)..."
	flutter build apk --target=$(TARGET) --release --obfuscate --split-debug-info=$(SYMBOLS_DIR) --dart-define=$(ENV_PROD)
	@echo "Android APK ready! Find it in build/app/outputs/flutter-apk/"

build-android-aab:
	@echo "Building Android App Bundle (Google Play Store)..."
	flutter build appbundle --target=$(TARGET) --release --obfuscate --split-debug-info=$(SYMBOLS_DIR) --dart-define=$(ENV_PROD)
	@echo "Android AAB ready! Find it in build/app/outputs/bundle/release/"

build-ios-adhoc:
	@echo "Building iOS IPA (Ad-Hoc / Diawi)..."
	flutter build ipa --target=$(TARGET) --release --obfuscate --split-debug-info=$(SYMBOLS_DIR) --dart-define=$(ENV_PROD) --export-options-plist=ios/ExportOptions-AdHoc.plist
	@echo "iOS Ad-Hoc build ready! You can now upload to Diawi."

build-ios-appstore:
	@echo "Building iOS IPA (App Store / TestFlight)..."
	flutter build ipa --target=$(TARGET) --release --obfuscate --split-debug-info=$(SYMBOLS_DIR) --dart-define=$(ENV_PROD) --export-options-plist=ios/ExportOptions-AppStore.plist
	@echo "iOS App Store build ready! Ready for Apple Transporter."

# ==========================================
# --- 🌿 4. GIT WORKFLOW COMMANDS ---
# ==========================================

# Usage: make new-branch b=feature/my-awesome-feature
new-branch:
	@if [ -z "$(b)" ]; then echo "❌ Error: Provide a branch name using 'make new-branch b=branch_name'"; exit 1; fi
	@echo "Creating and switching to branch: $(b)"
	git checkout -b $(b)
	@echo "Pushing new branch to origin..."
	git push -u origin $(b)
	@echo "✅ Branch $(b) is live on the remote!"

sync-main:
	@echo "Switching to main and pulling latest changes..."
	git checkout main
	git pull origin main
	@echo "✅ Main is synced and up to date!"

# ==========================================
# --- 🏗️ 5. TEMPLATE INITIALIZATION ---
# ==========================================

# Usage: make init-project name="My Awesome App" bundle="com.company.awesomeapp"
init-project:
	@if [ -z "$(name)" ] || [ -z "$(bundle)" ]; then \
		echo "❌ Error: Provide both name and bundle. Example: make init-project name=\"App\" bundle=\"com.org.app\""; \
		exit 1; \
	fi
	@echo "🚀 Initializing new project: $(name) ($(bundle))..."
	@echo "Installing rename CLI..."
	dart pub global activate rename
	@echo "Renaming App Name..."
	dart pub global run rename --appname "$(name)"
	@echo "Renaming Bundle ID..."
	dart pub global run rename --bundleId "$(bundle)"
	@echo "Cleaning up..."
	$(MAKE) clean-all
	@echo "✅ Project successfully renamed! Run 'make setup' to generate files."