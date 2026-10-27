# Zen browser (home-manager). Contributes a launch command to the keybind
# registry; does not know or care which key launches it.
{inputs, ...}: {
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.browser = {
    config,
    pkgs,
    ...
  }: let
    # rycee's `packages` output is built against a bare nixpkgs with no
    # allowUnfree, so unfree addons (e.g. tampermonkey) are refused. Apply the
    # overlay to our own pkgs instead, so addons build under this config's
    # nixpkgs.config (allowUnfree = true).
    firefox-addons =
      (pkgs.extend inputs.firefox-addons.overlays.default).firefox-addons;
  in {
    imports = [inputs.zen-browser.homeModules.twilight];

    keybinds.apps.browser = "zen-twilight";

    programs.zen-browser = {
      enable = true;
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
      profiles."default" = {
        containersForce = true;
        containers = {
          Personal = {
            color = "purple";
            icon = "fingerprint";
            id = 1;
          };
          Finance = {
            color = "green";
            icon = "dollar";
            id = 2;
          };
          Research = {
            color = "orange";
            icon = "circle";
            id = 3;
          };
          Shopping = {
            color = "yellow";
            icon = "cart";
            id = 4;
          };
        };
        spacesForce = true;
        spaces = let
          containers = config.programs.zen-browser.profiles."default".containers;
        in {
          "Home" = {
            id = "217e852f-6bfa-4303-9468-1b5fe7e28fb0";
            icon = "🏠";
            container = containers."Personal".id;
            position = 1000;
          };
          "Accounts" = {
            id = "9b66fa68-88b2-4a90-9ae9-0cee470d46c1";
            icon = "💳";
            container = containers."Personal".id;
            position = 2000;
          };
          "Research" = {
            id = "ce3a4ea9-43a3-44ce-8bd0-716384ab8df0";
            icon = "🔬";
            container = containers."Research".id;
            position = 3000;
          };
          "CSE" = {
            id = "15596769-b3ae-47e1-920c-ebc77aab8d8c";
            icon = "🖥️";
            container = containers."Research".id;
            position = 4000;
          };
          "Hobbies" = {
            id = "73a7b38b-3111-41bc-a1da-2d0c40779cb0";
            icon = "🎨";
            container = containers."Personal".id;
            position = 5000;
          };
        };

        # Extensions from rycee's firefox-addons. `force` lets the declarative
        # install overwrite any manually-installed copy of the same addon.
        extensions = {
          force = true;
          packages = with firefox-addons; [
            ublock-origin
            vimium-c
            privacy-badger
            violentmonkey
            sponsorblock
            skip-redirect
            don-t-fuck-with-paste
            the-camelizer-price-history-ch
            istilldontcareaboutcookies
            zotero-connector
            bitwarden
          ];
        };
      };
    };
  };
}
