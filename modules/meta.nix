{lib, ...}: {
  options.meta.username = lib.mkOption {
    type = lib.types.str;
    description = "Primary system username";
  };

  config.meta.username = "david";
}
