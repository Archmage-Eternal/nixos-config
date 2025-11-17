{
  inputs,
  pkgs,
  ...
}: let
  # package from the zen-browser flake input; used for home.packages and for meta info
  zen = inputs.zen-browser.packages."${system}".default;

  # Helper: generate a container attribute quickly (not necessary, but handy in templates)
  mkContainer = name: id: color: icon: {
    # `name` is only for your readability when editing this file; the attribute key is the important name
    id = id; color = color; icon = icon;
  };

  # Helper: generate a space entry
  mkSpace = name: id: position: containerId: {
    id = id; position = position; container = containerId; # container is optional
  };
in {
  # Make the selected zen package available in your environment
  home.packages = with pkgs; [ zen ];

  # Primary home-manager module for zen-browser
  programs.zen-browser = {
    enable = true;

    # Native messaging hosts - packages that provide native messaging connectors
    # Example: `pkgs.firefoxpwa` or other native hosts you want to allow
    nativeMessagingHosts = [ pkgs.firefoxpwa ];

    # Policies: mirrors Firefox policies structure. Use this to disable telemetry,
    # force certain behaviour, and to set ExtensionSettings (force-install addons).
    # See the README comments for more fields you can set.
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };

    # Preferences: demonstrates how to lock preferences. Use the same shape as the
    # README's mkLockedAttrs helper to lock values if you need to enforce settings.
    preferences = let
      mkLockedAttrs = builtins.mapAttrs (_: value: { Value = value; Status = "locked"; });
    in mkLockedAttrs {
      "browser.tabs.warnOnClose" = false;
    };

    # Extension installation (force-installed) example. The key must be the extension ID,
    # and the value is a short name used to build the install_url above.
    # To add more extensions: add more entries in the map below using the extension ID
    # as the key and the addon slug as the value.
    policiesExtra = {
      ExtensionSettings = builtins.mapAttrs (_: pluginId: { install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi"; installation_mode = "force_installed"; }) {
        "wappalyzer@crunchlabz.com" = "wappalyzer";
        # "<extension-id>" = "<extension-slug>";
      };
    };

    # Profiles, containers and spaces
    # - profiles.<profileName>.containers describes named containers (IDs are numeric)
    # - profiles.<profileName>.spaces describes UI spaces (must use stable UUIDs)
    # Warning: spaces are applied via an activation script and can recreate spaces when
    # the UUIDs change. Close Zen before rebuilding to avoid activation failures.
    profiles = {
      "default" = {
        containersForce = true; # if true, containers not listed will be removed
        containers = {
          # Example containers - add more by copying the block below and changing the id
          Personal = mkContainer "Personal" 1 "purple" "fingerprint";
          Work = mkContainer "Work" 2 "blue" "briefcase";

          # Template: add another container
          # MyContainer = mkContainer "MyContainer" 3 "green" "leaf";
        };

        spacesForce = true; # if true, undeclared spaces may be removed on activation

        # The canonical way to reference container IDs from a space is using
        # `containers."Name".id`. The module example in the README uses `config` to
        # reference containers; below is a safe pattern you can copy.
        spaces = let
          containers = config.programs.zen-browser.profiles."default".containers;
        in {
          Home = mkSpace "Home" "c6de089c-410d-4206-961d-ab11f988d40a" 1000 null;

          # Template: workspace tied to a container
          # WorkSpace = mkSpace "WorkSpace" "cdd10fab-4fc5-494b-9041-325e5759195b" 2000 containers.Work.id;

          # Notes on UUIDs: generate stable UUIDs with `uuidgen` or `python -c 'import uuid;print(uuid.uuid4())'`.
          # Don't change an existing space's id after you apply it unless you are prepared
          # for the space to be recreated (and lose window/tab grouping) under a new id.
        };
      };
    };
  };

  # XDG MIME registrations - optional but useful to make Zen the default browser
  xdg.mimeApps = let
    value = zen.meta.desktopFileName;
    associations = builtins.listToAttrs (map (name: { inherit name value; }) [
      "application/x-extension-html"
      "text/html"
      "application/json"
    ]);
  in { associations.added = associations; defaultApplications = associations; };
}
