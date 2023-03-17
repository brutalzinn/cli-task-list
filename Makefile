# CHAT CHAPT HELP ME GENERATE THIS. I LOVE IT
# Setup commands for Windows
setup-windows:
	@echo "Setting up for Windows"
	OAUTH_AUTHORIZE_URL=http://localhost:9000/oauth/authorize"
	OAUTH_TOKEN_URL=http://localhost:9000/oauth/token
	OAUTH_REDIRECT_URL=http://localhost:8888
	CLIENT_ID=22dd3275-4e1b-459f-a80a-3ca7c110cf45
	CLIENT_SECRET=0e6f9912-21de-4326-832b-fc216b5e0b79
	dart compile exe lib/main.dart -o task-note-cli.exe

# Setup commands for Linux
setup-linux:
	@echo "Setting up for Linux"
	dart compile exe lib/main.dart -o bin/task-note-cli
	chmod +x bin/task-note-cli
	sudo ln -sf $(CURDIR)/bin/task-note-cli /usr/local/bin/task-note-cli

# Install command for Windows
install-windows:
	@echo "Installing for Windows"
	setx PATH "%PATH%;$(CURDIR)\bin"
	mklink %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\task-note-cli.lnk $(CURDIR)\bin\task-note-cli.exe

# Install command for Linux
install-linux:
	@echo "Installing for Linux"
	sudo ln -sf $(CURDIR)/bin/task-note-cli /usr/local/bin/task-note-cli

# Default target
all: setup-windows setup-linux

# Install target
install: install-windows install-linux
