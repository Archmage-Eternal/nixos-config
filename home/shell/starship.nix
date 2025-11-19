{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      add_newline = true;

      format = lib.concatStrings [
        "$nix_shell"
        "$hostname"
        "$directory"
        "$package"
      ];
      right_format = lib.concatStrings [
        "$os"
        "$shell"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$line_break"
        "$character"
      ];

      os = {
        disabled = false;
        style = "bold white";
        format = "[$symbol]($style) ";
        symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CachyOS = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          Nobara = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };
      };

      battery = {
        disabled = false;
        format = "[$symbol$percentage]($style) ";
        charging_symbol = "";
        discharging_symbol = "";
        empty_symbol = "";
        full_symbol = "";
        unknown_symbol = "";
        display = [
          {
            style = "red bold";
            threshold = 10;
          }
        ];
      };

      directory = {
        truncation_length = 5;
        read_only = " 󰌾";
      };

      hostname = {
        ssh_symbol = " ";
        format = "[$ssh_symbol$hostname]($style) ";
      };

      shell = {
        disabledd = false;
        format = "[$indicator][$style]";
        style = "white bold";
        bash_indicator = "bsh";
        nu_indicator = "nu";
        zsh_indicator = "zsh";
        powershell_indicator = "_";
        cmd_indicator = "cmd";
        fish_indicator = "";
        elvish_indicator = "esh";
        ion_indicator = "ion";
        tcsh_indicator = "tsh";
        xonsh_indicator = "xsh";
        unknown_indicator = "mystery shell";
      };

      nix_shell = {
        symbol = " ";
        format = "[$symbol]($style) ";
      };

      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
        style = "bold purple";
      };

      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "cyan";
      };

      git_status = {
        style = "yellow";
        conflicted = "!";
        ahead = "⇡";
        behind = "⇣";
        deleted = "✕";
        renamed = "»";
        stashed = "≡";
        format = "([$conflicted$untracked$modified$staged$renamed$deleted]($style)) ";
      };

      aws = {
        disabled = false;
        symbol = " ";
      };
      buf = {
        disabled = false;
        symbol = " ";
      };
      bun = {
        disabled = false;
        symbol = " ";
      };
      c = {
        disabled = false;
        symbol = " ";
      };
      cpp = {
        disabled = false;
        symbol = " ";
      };
      cmake = {
        disabled = false;
        symbol = " ";
      };
      conda = {
        disabled = false;
        symbol = " ";
      };
      crystal = {
        disabled = false;
        symbol = " ";
      };
      dart = {
        disabled = false;
        symbol = " ";
      };
      deno = {
        disabled = false;
        symbol = " ";
      };
      docker_context = {
        disabled = false;
        symbol = " ";
      };
      elixir = {
        disabled = false;
        symbol = " ";
      };
      elm = {
        disabled = false;
        symbol = " ";
      };
      fennel = {
        disabled = false;
        symbol = " ";
      };
      fossil_branch = {
        disabled = false;
        symbol = " ";
      };
      gcloud = {
        disabled = false;
        symbol = " ";
      };
      git_commit = {
        disabled = false;
        tag_symbol = "  ";
      };
      golang = {
        disabled = false;
        symbol = " ";
      };
      gradle = {
        disabled = false;
        symbol = " ";
      };
      guix_shell = {
        disabled = false;
        symbol = " ";
      };
      haskell = {
        disabled = false;
        symbol = " ";
      };
      haxe = {
        disabled = false;
        symbol = " ";
      };
      hg_branch = {
        disabled = false;
        symbol = " ";
      };
      java = {
        disabled = false;
        symbol = " ";
      };
      julia = {
        disabled = false;
        symbol = " ";
      };
      kotlin = {
        disabled = false;
        symbol = " ";
      };
      lua = {
        disabled = false;
        symbol = " ";
      };
      memory_usage = {
        disabled = false;
        symbol = "󰍛 ";
      };
      meson = {
        disabled = false;
        symbol = "󰔷 ";
      };
      nim = {
        disabled = false;
        symbol = "󰆥 ";
      };
      nodejs = {
        disabled = false;
        symbol = " ";
      };
      ocaml = {
        disabled = false;
        symbol = " ";
      };
      package = {
        disabled = false;
        symbol = "󰏗 ";
      };
      perl = {
        disabled = false;
        symbol = " ";
      };
      php = {
        disabled = false;
        symbol = " ";
      };
      pijul_channel = {
        disabled = false;
        symbol = " ";
      };
      pixi = {
        disabled = false;
        symbol = "󰏗 ";
      };
      python = {
        disabled = false;
        symbol = " ";
      };
      rlang = {
        disabled = false;
        symbol = "󰟔 ";
      };
      ruby = {
        disabled = false;
        symbol = " ";
      };
      rust = {
        disabled = false;
        symbol = "󱘗 ";
      };
      scala = {
        disabled = false;
        symbol = " ";
      };
      status = {
        disabled = false;
        symbol = " ";
      };
      swift = {
        disabled = false;
        symbol = " ";
      };
      xmake = {
        disabled = false;
        symbol = " ";
      };
      zig = {
        disabled = false;
        symbol = " ";
      };

      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](blue)";
      };
    };
  };
}
