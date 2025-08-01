Pre-Install Steps
For Nixcord if using Dorion
Dorion Setup Requirements

Important

Before enabling Dorion with nixcord, you must first launch Dorion once to create the necessary LocalStorage databases for Vencord settings

    Initial setup: Run Dorion temporarily to set up the initial environment:

## Using nix run
nix run github:KaylorBen/nixcord#dorion

# Or using legacy nix-build
nix-build https://github.com/KaylorBen/nixcord/archive/main.tar.gz -A packages.$(nix-instantiate --eval -E 'builtins.currentSystem' | tr -d '"').dorion

    Login: In Dorion, log into your Discord account, then close Dorion completely.

    Configure and rebuild: Now enable Dorion in your Home Manager configuration and rebuild

This step is required because nixcord automatically configures Vencord settings in Dorion's LocalStorage database, but these databases only exist after the first launch and login

## To-do
1. Disable Discord and Dorion in nixcord
