{...}: {
  flake = {
    nixosModules.mime = {inputs, ...}: {
      home-manager.sharedModules = [inputs.self.homeModules.mime];
    };

    homeModules.mime = {
      lib,
      ...
    }: {
      xdg.configFile."mimeapps.list".force = true;
      xdg.mimeApps = let
        defaultApps = {
          browser = ["zen-beta.desktop"];
          text = ["vim.desktop"];
          image = ["imv-dir.desktop"];
          audio = ["mpv.desktop"];
          video = ["mpv.desktop"];
          directory = ["thunar.desktop"];
          office = ["libreoffice.desktop"];
          reading = ["zathura.desktop"];
          archive = ["file-roller.desktop"];
          discord = ["vesktop.desktop"];
        };
        mimeMap = {
          text = [
            "text/markdown"
            "text/plain"
            "text/x-shellscript"
          ];
          image = [
            "image/bmp"
            "image/gif"
            "image/jpeg"
            "image/png"
            "image/svg+xml"
            "image/tiff"
            "image/vnd.microsoft.icon"
            "image/webp"
          ];
          audio = [
            "audio/aac"
            "audio/flac"
            "audio/mpeg"
            "audio/ogg"
            "audio/opus"
            "audio/wav"
            "audio/webm"
            "audio/x-matroska"
          ];
          video = [
            "video/mp2t"
            "video/mp4"
            "video/mpeg"
            "video/ogg"
            "video/quicktime"
            "video/webm"
            "video/x-flv"
            "video/x-matroska"
            "video/x-msvideo"
          ];
          directory = ["inode/directory"];
          browser = [
            "text/html"
            "application/xhtml+xml"
            "x-scheme-handler/about"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/unknown"
          ];
          office = [
            "application/vnd.oasis.opendocument.text"
            "application/vnd.oasis.opendocument.spreadsheet"
            "application/vnd.oasis.opendocument.presentation"
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            "application/msword"
            "application/vnd.ms-excel"
            "application/vnd.ms-powerpoint"
            "application/rtf"
          ];
          reading = [
            "application/pdf"
            "application/vnd.comicbook+zip"
            "application/vnd.comicbook-rar"
            "application/x-cbr"
            "application/x-cbz"
          ];
          archive = [
            "application/vnd.rar"
            "application/x-7z-compressed"
            "application/x-bzip"
            "application/x-bzip2"
            "application/x-compressed-tar"
            "application/x-gzip"
            "application/x-tar"
            "application/x-xz"
            "application/zip"
          ];
          discord = ["x-scheme-handler/discord"];
        };
        associations = with lib.lists;
          lib.listToAttrs (
            flatten (
              lib.mapAttrsToList (
                key: map (type: lib.attrsets.nameValuePair type defaultApps.${key})
              )
              mimeMap
            )
          );
      in {
        enable = true;
        associations.added = associations;
        defaultApplications = associations;
      };
    };
  };
}