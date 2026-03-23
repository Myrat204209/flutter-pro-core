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