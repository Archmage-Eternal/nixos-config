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
#
    # profiles."default" = {
    #   contianersForce = true;
    #   containers = {
    #     Personal = {};
    #     Work = {};
    #     Finance = {};
    #     Shopping = {};
    #     Study = {};
    #     Dev = {};
    #   };
    #
    #   spacesForce = true;
    #   spaces = let
    #     containers = config.programs.zen-browser.profiles."default".containers;
    #   in {
    #     "Home" = {
    #       id = "";
    #       icon = "";
    #       container = containers."".id;
    #       position = 1234;
    #     };
    #
    #     "Socials" = {};
    #     "Books" = {};
    #     "Programming" = {};
    #     "Nix" = {};
    #     "Hobbies" = {};
    #     "Music" = {};
    #   };
    # };
  };
}
