# List all available commands (default)
default:
    @just --list

# Install all dependencies required for development
setup:
    @echo "Installing Ruby dependencies..."
    bundle install
    @echo ""
    @echo "Setup complete! You can now run 'just dev' to start the development server."

# Start local development server
dev:
    @echo "Starting Jekyll development server..."
    @echo "Site will be available at http://localhost:4000"
    bundle exec jekyll serve --livereload
