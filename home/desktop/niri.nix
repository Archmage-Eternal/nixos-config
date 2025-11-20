{ ... }: {
	programs.niri = {
		enable = true;

		settings = {
			# Input modifier keys
			input = { "mod-key" = "Super"; "mod-key-nested" = "Alt"; };

			# Keybinds: use the helper functions from config.lib.niri.actions
			binds = with config.lib.niri.actions; let
				# helper to run shell commands (preserves quoting and allows full shell expressions)
				sh = spawn "sh" "-c";
			in {
				# Navigation (focus) - Vim-like hjkl
				"Mod+H".action = focus-window-or-monitor-left;
				"Mod+J".action = focus-window-or-monitor-down;
				"Mod+K".action = focus-window-or-monitor-up;
				"Mod+L".action = focus-window-or-monitor-right;

				# Movement (move/swap windows)
				"Mod+Shift+H".action = swap-window-left;
				"Mod+Shift+J".action = move-window-down;
				"Mod+Shift+K".action = move-window-up;
				"Mod+Shift+L".action = swap-window-right;

				# Workspace management
				"Mod+Ctrl+K".action = focus-workspace-up;
				"Mod+Ctrl+J".action = focus-workspace-down;

				# Move column to workspace (and focus it)
				"Mod+Ctrl+Shift+K".action.move-column-to-workspace-up = { focus = true; };
				"Mod+Ctrl+Shift+J".action.move-column-to-workspace-down = { focus = true; };

				# Column width presets and maximize
				"Mod+W".action = switch-preset-column-width "next";
				"Mod+M".action = maximize-column;

				# Consume/expel windows between columns
				"Mod+Alt+H".action = consume-or-expel-window-left;
				"Mod+Alt+L".action = consume-or-expel-window-right;

				# Floating / tiling toggles
				"Mod+F".action = toggle-window-floating;
				"Mod+Shift+F".action = switch-focus-between-floating-and-tiling;

				# Overview and launchers
				"Mod+O".action = open-overview;
				"Mod+Return".action = spawn "ghostty"; # change to your preferred terminal
				"Mod+D".action = spawn ""; # use dms launcher

				# Meta actions
				"Mod+Shift+Q".action.quit = { skip-confirmation = true; };
				"Mod+Q".action = close-window;

				# Fullscreen and layout cycling
				"Mod+F11".action = toggle-windowed-fullscreen;
				"Mod+Space".action = switch-layout "next";

				# Screenshot examples (use slurp + grim + wl-copy). These spawn a shell so you can use shell pipelines.
				"Print".action = sh ''grim - | wl-copy'';
                                # Check path and replace Pictues with $XDG_HOME:PICTURES
				"Mod+Shift+S".action = sh ''grim -g "$(slurp)" ~/Pictures/Screenshots/screenshot-$(date +%s).png && notify-send "Saved screenshot"'';

				# Recording example (wf-recorder). Use spawn directly for simple commands.
				"Mod+Shift+R".action = spawn "wf-recorder -f ~/Videos/recording-$(date +%s).mkv";

				# Help overlay
				"Mod+?".action = show-hotkey-overlay;
				"Mod+Shift+/".action = show-hotkey-overlay;

				# Example: scratchpad toggle (you may want to script this to spawn and hide a terminal)
				"Mod+S".action = spawn "~/.local/bin/toggle-scratchpad";

			};
		};
	};
}
Meta
