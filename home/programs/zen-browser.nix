{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight];

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
      # Options for icon briefcase", "cart", "circle", "dollar", "fence", "fingerprint", "gift", "vacation", "food", "fruit", "pet", "tree", "chill"
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
    };
  };
}
