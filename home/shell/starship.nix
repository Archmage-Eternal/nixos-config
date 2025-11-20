{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      format = "$all";
      right_format = "";
      continuation_prompt = "[∙](bright-black) ";
      scan_timeout = 30;
      command_timeout = 500;
      add_newline = true;
      follow_symlinks = true;
      palettes = {};
      profiles = {};
      aws = {
        format = "on [$symbol($profile )(\\($region\\) )(\\[$duration\\] )]($style)";
        symbol = "  ";
        style = "bold yellow";
        disabled = false;
        expiration_symbol = "X";
        force_display = false;
        region_aliases = {};
        profile_aliases = {};
      };
      azure = {
        format = "on [$symbol($subscription)]($style) ";
        symbol = "󰠅 ";
        style = "blue bold";
        disabled = true;
        subscription_aliases = {};
      };
      battery = {
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        unknown_symbol = "󰁽 ";
        empty_symbol = "󰂎 ";
        disabled = false;
        format = "[$symbol$percentage]($style) ";
        display = [
          {
            threshold = 10;
            style = "red bold";
          }
        ];
      };
      buf = {
        format = "with [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold blue";
        disabled = false;
        detect_extensions = [];
        detect_files = ["buf.yaml" "buf.gen.yaml" "buf.work.yaml"];
        detect_folders = [];
      };
      bun = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold red";
        disabled = false;
        detect_extensions = [];
        detect_files = ["bun.lock" "bun.lockb" "bunfig.toml"];
        detect_folders = [];
      };
      c = {
        format = "via [$symbol($version(-$name) )]($style)";
        version_format = "v\${raw}";
        style = "149 bold";
        symbol = " ";
        disabled = false;
        detect_extensions = ["c" "h"];
        detect_files = [];
        detect_folders = [];
        commands = [
          ["cc" "--version"]
          ["gcc" "--version"]
          ["clang" "--version"]
        ];
      };
      character = {
        format = "$symbol ";
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
        vimcmd_visual_symbol = "[❮](bold yellow)";
        vimcmd_replace_symbol = "[❮](bold purple)";
        vimcmd_replace_one_symbol = "[❮](bold purple)";
        disabled = false;
      };
      cmake = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold blue";
        disabled = false;
        detect_extensions = [];
        detect_files = ["CMakeLists.txt" "CMakeCache.txt"];
        detect_folders = [];
      };
      cmd_duration = {
        min_time = 2000;
        format = "took [$duration]($style) ";
        style = "yellow bold";
        show_milliseconds = false;
        disabled = false;
        show_notifications = false;
        min_time_to_notify = 45000;
      };
      cobol = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "⚙️ ";
        style = "bold blue";
        disabled = false;
        detect_extensions = ["cbl" "cob" "CBL" "COB"];
        detect_files = [];
        detect_folders = [];
      };
      conda = {
        truncation_length = 1;
        format = "via [$symbol$environment]($style) ";
        symbol = " ";
        style = "green bold";
        ignore_base = true;
        detect_env_vars = ["!PIXI_ENVIRONMENT_NAME"];
        disabled = false;
      };
      container = {
        format = "[$symbol \\[$name\\]]($style) ";
        symbol = "⬢";
        style = "red bold dimmed";
        disabled = false;
      };
      cpp = {
        format = "via [$symbol($version(-$name) )]($style)";
        version_format = "v\${raw}";
        style = "149 bold";
        symbol = " ";
        disabled = true;
        detect_extensions = ["cpp" "cc" "cxx" "c++" "hpp" "hh" "hxx" "h++" "tcc"];
        detect_files = [];
        detect_folders = [];
        commands = [
          ["c++" "--version"]
          ["g++" "--version"]
          ["clang++" "--version"]
        ];
      };
      crystal = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold red";
        disabled = false;
        detect_extensions = ["cr"];
        detect_files = ["shard.yml"];
        detect_folders = [];
      };
      daml = {
        symbol = "Λ ";
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        style = "bold cyan";
        disabled = false;
        detect_extensions = [];
        detect_files = ["daml.yaml"];
        detect_folders = [];
      };
      dart = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold blue";
        disabled = false;
        detect_extensions = ["dart"];
        detect_files = ["pubspec.yaml" "pubspec.yml" "pubspec.lock"];
        detect_folders = [".dart_tool"];
      };
      deno = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "green bold";
        disabled = false;
        detect_extensions = [];
        detect_files = ["deno.json" "deno.jsonc" "deno.lock" "mod.ts" "deps.ts" "mod.js" "deps.js"];
        detect_folders = [];
      };
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 0;
        use_logical_path = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        style = "cyan bold";
        disabled = false;
        read_only = " 󰌾";
        read_only_style = "red";
        truncation_symbol = "";
        home_symbol = "~";
        use_os_path_sep = true;
        substitutions = {};
      };
      direnv = {
        format = "[$symbol$loaded/$allowed]($style) ";
        symbol = "direnv ";
        style = "bold bright-yellow";
        disabled = true;
        detect_extensions = [];
        detect_env_vars = ["DIRENV_FILE"];
        detect_files = [".envrc"];
        detect_folders = [];
        allowed_msg = "allowed";
        not_allowed_msg = "not allowed";
        denied_msg = "denied";
        loaded_msg = "loaded";
        unloaded_msg = "not loaded";
      };
      docker_context = {
        symbol = " ";
        style = "blue bold";
        format = "via [$symbol$context]($style) ";
        only_with_files = true;
        disabled = false;
        detect_extensions = [];
        detect_files = ["docker-compose.yml" "docker-compose.yaml" "Dockerfile"];
        detect_folders = [];
      };
      dotnet = {
        format = "via [$symbol($version )(🎯 $tfm )]($style)";
        version_format = "v\${raw}";
        symbol = ".NET ";
        style = "blue bold";
        heuristic = true;
        disabled = false;
        detect_extensions = ["csproj" "fsproj" "xproj"];
        detect_files = ["global.json" "project.json" "Directory.Build.props" "Directory.Build.targets" "Packages.props"];
        detect_folders = [];
      };
      elixir = {
        format = "via [$symbol($version \\(OTP $otp_version\\) )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold purple";
        disabled = false;
        detect_extensions = [];
        detect_files = ["mix.exs"];
        detect_folders = [];
      };
      elm = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "cyan bold";
        disabled = false;
        detect_extensions = ["elm"];
        detect_files = ["elm.json" "elm-package.json" ".elm-version"];
        detect_folders = ["elm-stuff"];
      };
      env_var = {};
      erlang = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold red";
        disabled = false;
        detect_extensions = [];
        detect_files = ["rebar.config" "erlang.mk"];
        detect_folders = [];
      };
      fennel = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold green";
        disabled = true;
        detect_extensions = ["fnl"];
        detect_files = [];
        detect_folders = [];
      };
      fill = {
        style = "bold black";
        symbol = ".";
        disabled = false;
      };
      fossil_branch = {
        format = "on [$symbol$branch]($style) ";
        symbol = " ";
        style = "bold purple";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        disabled = true;
      };
      fossil_metrics = {
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        added_style = "bold green";
        deleted_style = "bold red";
        only_nonzero_diffs = true;
        disabled = true;
      };
      gcloud = {
        format = "on [$symbol$account(@$domain)(\\($region\\))]($style) ";
        symbol = "  ";
        style = "bold blue";
        disabled = false;
        detect_env_vars = [];
        region_aliases = {};
        project_aliases = {};
      };
      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        symbol = " ";
        style = "bold purple";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        only_attached = false;
        always_show_remote = false;
        ignore_branches = [];
        disabled = false;
      };
      git_commit = {
        commit_hash_length = 7;
        format = "[\\($hash$tag\\)]($style) ";
        style = "green bold";
        only_detached = true;
        disabled = false;
        tag_symbol = "  ";
        tag_disabled = true;
        tag_max_candidates = 0;
      };
      git_metrics = {
        added_style = "bold green";
        deleted_style = "bold red";
        only_nonzero_diffs = true;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        disabled = true;
        ignore_submodules = false;
      };
      git_state = {
        rebase = "REBASING";
        merge = "MERGING";
        revert = "REVERTING";
        cherry_pick = "CHERRY-PICKING";
        bisect = "BISECTING";
        am = "AM";
        am_or_rebase = "AM/REBASE";
        style = "bold yellow";
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        disabled = false;
      };
      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "red bold";
        stashed = "\\$";
        ahead = "⇡";
        behind = "⇣";
        up_to_date = "";
        diverged = "⇕";
        conflicted = "=";
        deleted = "✘";
        renamed = "»";
        modified = "!";
        staged = "+";
        untracked = "?";
        typechanged = "";
        ignore_submodules = false;
        disabled = false;
        use_git_executable = false;
      };
      gleam = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "⭐ ";
        style = "bold #FFAFF3";
        disabled = false;
        detect_extensions = ["gleam"];
        detect_files = ["gleam.toml"];
        detect_folders = [];
      };
      golang = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold cyan";
        disabled = false;
        not_capable_style = "bold red";
        detect_extensions = ["go"];
        detect_files = ["go.mod" "go.sum" "go.work" "glide.yaml" "Gopkg.yml" "Gopkg.lock" ".go-version"];
        detect_folders = ["Godeps"];
      };
      gradle = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold bright-cyan";
        disabled = false;
        recursive = false;
        detect_extensions = ["gradle" "gradle.kts"];
        detect_files = [];
        detect_folders = ["gradle"];
      };
      guix_shell = {
        format = "via [$symbol]($style) ";
        symbol = " ";
        style = "yellow bold";
        disabled = false;
      };
      haskell = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold purple";
        disabled = false;
        detect_extensions = ["hs" "cabal" "hs-boot"];
        detect_files = ["stack.yaml" "cabal.project"];
        detect_folders = [];
      };
      haxe = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold fg:202";
        disabled = false;
        detect_extensions = ["hx" "hxml"];
        detect_files = ["haxelib.json" "hxformat.json" ".haxerc"];
        detect_folders = [".haxelib" "haxe_libraries"];
      };
      helm = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "⎈ ";
        style = "bold white";
        disabled = false;
        detect_extensions = [];
        detect_files = ["helmfile.yaml" "Chart.yaml"];
        detect_folders = [];
      };
      hg_branch = {
        symbol = " ";
        style = "bold purple";
        format = "on [$symbol$branch(:$topic)]($style) ";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        disabled = true;
      };
      hostname = {
        ssh_only = true;
        ssh_symbol = " ";
        trim_at = ".";
        detect_env_vars = [];
        format = "[$ssh_symbol$hostname]($style) in ";
        style = "green dimmed bold";
        disabled = false;
        aliases = {};
      };
      java = {
        disabled = false;
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        style = "red dimmed";
        symbol = " ";
        detect_extensions = ["java" "class" "jar" "gradle" "clj" "cljc"];
        detect_files = ["pom.xml" "build.gradle.kts" "build.sbt" ".java-version" "deps.edn" "project.clj" "build.boot" ".sdkmanrc"];
        detect_folders = [];
      };
      jobs = {
        threshold = 1;
        symbol_threshold = 1;
        number_threshold = 2;
        format = "[$symbol$number]($style) ";
        symbol = "✦";
        style = "bold blue";
        disabled = false;
      };
      julia = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold purple";
        disabled = false;
        detect_extensions = ["jl"];
        detect_files = ["Project.toml" "Manifest.toml"];
        detect_folders = [];
      };
      kotlin = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold blue";
        kotlin_binary = "kotlin";
        disabled = false;
        detect_extensions = ["kt" "kts"];
        detect_files = [];
        detect_folders = [];
      };
      kubernetes = {
        symbol = "☸ ";
        format = "[$symbol$context( \\($namespace\\))]($style) in ";
        style = "cyan bold";
        disabled = true;
        detect_extensions = [];
        detect_files = [];
        detect_folders = [];
        detect_env_vars = [];
        contexts = [];
        context_aliases = {};
        user_aliases = {};
      };
      line_break = {
        disabled = false;
      };
      localip = {
        ssh_only = true;
        format = "[$localipv4]($style) ";
        style = "yellow bold";
        disabled = true;
      };
      lua = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold blue";
        lua_binary = "lua";
        disabled = false;
        detect_extensions = ["lua"];
        detect_files = [".lua-version"];
        detect_folders = ["lua"];
      };
      memory_usage = {
        threshold = 75;
        format = "via $symbol[$ram( | $swap)]($style) ";
        style = "white bold dimmed";
        symbol = "󰍛 ";
        disabled = true;
      };
      meson = {
        truncation_length = 4294967295;
        truncation_symbol = "…";
        format = "via [$symbol$project]($style) ";
        symbol = "󰔷 ";
        style = "blue bold";
        disabled = false;
      };
      mise = {
        format = "[$symbol$health]($style) ";
        symbol = "mise ";
        style = "bold purple";
        disabled = true;
        detect_extensions = [];
        detect_files = ["mise.toml" "mise.local.toml" ".mise.toml" ".mise.local.toml"];
        detect_folders = [".mise"];
        healthy_symbol = "healthy";
        unhealthy_symbol = "unhealthy";
      };
      mojo = {
        format = "with [$symbol($version )]($style)";
        symbol = "🔥 ";
        style = "bold 208";
        disabled = false;
        detect_extensions = ["mojo" "🔥"];
        detect_files = [];
        detect_folders = [];
      };
      nats = {
        format = "[$symbol($name )]($style)";
        symbol = "✉️ ";
        style = "bold purple";
        disabled = true;
      };
      netns = {
        format = "[$symbol \\[$name\\]]($style) ";
        symbol = "🛜";
        style = "blue bold dimmed";
        disabled = false;
      };
      nim = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "󰆥 ";
        style = "yellow bold";
        disabled = false;
        detect_extensions = ["nim" "nims" "nimble"];
        detect_files = ["nim.cfg"];
        detect_folders = [];
      };
      nix_shell = {
        format = "via [$symbol$state( \\($name\\))]($style) ";
        symbol = " ";
        style = "bold blue";
        impure_msg = "impure";
        pure_msg = "pure";
        unknown_msg = "";
        disabled = false;
        heuristic = false;
      };
      nodejs = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold green";
        disabled = false;
        not_capable_style = "bold red";
        detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
        detect_files = ["package.json" ".node-version" ".nvmrc" "!bunfig.toml" "!bun.lock" "!bun.lockb"];
        detect_folders = ["node_modules"];
      };
      ocaml = {
        format = "via [$symbol($version )(\\($switch_indicator$switch_name\\) )]($style)";
        version_format = "v\${raw}";
        global_switch_indicator = "";
        local_switch_indicator = "*";
        symbol = " ";
        style = "bold yellow";
        disabled = false;
        detect_extensions = ["opam" "ml" "mli" "re" "rei"];
        detect_files = ["dune" "dune-project" "jbuild" "jbuild-ignore" ".merlin"];
        detect_folders = ["_opam" "esy.lock"];
      };
      odin = {
        format = "via [$symbol($version )]($style)";
        show_commit = false;
        symbol = "Ø ";
        style = "bold bright-blue";
        disabled = false;
        detect_extensions = ["odin"];
        detect_files = [];
        detect_folders = [];
      };
      opa = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "🪖  ";
        style = "bold blue";
        disabled = false;
        detect_extensions = ["rego"];
        detect_files = [];
        detect_folders = [];
      };
      openstack = {
        format = "on [$symbol$cloud(\\($project\\))]($style) ";
        symbol = "☁️  ";
        style = "bold yellow";
        disabled = false;
      };
      os = {
        format = "[$symbol]($style)";
        style = "bold white";
        disabled = true;
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
      package = {
        format = "is [$symbol$version]($style) ";
        symbol = "󰏗 ";
        style = "208 bold";
        display_private = false;
        disabled = false;
        version_format = "v\${raw}";
      };
      perl = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "149 bold";
        disabled = false;
        detect_extensions = ["pl" "pm" "pod"];
        detect_files = ["Makefile.PL" "Build.PL" "cpanfile" "cpanfile.snapshot" "META.json" "META.yml" ".perl-version"];
        detect_folders = [];
      };
      php = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "147 bold";
        disabled = false;
        detect_extensions = ["php"];
        detect_files = ["composer.json" ".php-version"];
        detect_folders = [];
      };
      pijul_channel = {
        symbol = " ";
        style = "bold purple";
        format = "on [$symbol$channel]($style) ";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        disabled = true;
      };
      pixi = {
        pixi_binary = ["pixi"];
        show_default_environment = true;
        format = "via [$symbol($version )(\\($environment\\) )]($style)";
        version_format = "v\${raw}";
        symbol = "󰏗 ";
        style = "yellow bold";
        disabled = false;
        detect_extensions = [];
        detect_files = ["pixi.toml" "pixi.lock"];
        detect_folders = [".pixi"];
      };
      pulumi = {
        format = "via [$symbol($username@)$stack]($style) ";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold 5";
        disabled = false;
        search_upwards = true;
      };
      purescript = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "<=> ";
        style = "bold white";
        disabled = false;
        detect_extensions = ["purs"];
        detect_files = ["spago.dhall" "spago.yaml" "spago.lock"];
        detect_folders = [];
      };
      python = {
        pyenv_version_name = false;
        pyenv_prefix = "pyenv ";
        python_binary = [
          ["python"]
          ["python3"]
          ["python2"]
        ];
        format = "via [\${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\) )]($style)";
        version_format = "v\${raw}";
        style = "yellow bold";
        symbol = " ";
        disabled = false;
        detect_extensions = ["py" "ipynb"];
        detect_files = ["requirements.txt" ".python-version" "pyproject.toml" "Pipfile" "tox.ini" "setup.py" "__init__.py"];
        detect_folders = [];
        detect_env_vars = ["VIRTUAL_ENV"];
      };
      quarto = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "⨁ ";
        style = "bold #75AADB";
        disabled = false;
        detect_extensions = ["qmd"];
        detect_files = ["_quarto.yml"];
        detect_folders = [];
      };
      raku = {
        format = "via [$symbol($version-$vm_version )]($style)";
        version_format = "\${raw}";
        symbol = "🦋 ";
        style = "149 bold";
        disabled = false;
        detect_extensions = ["p6" "pm6" "pod6" "raku" "rakumod"];
        detect_files = ["META6.json"];
        detect_folders = [];
      };
      red = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "🔺 ";
        style = "red bold";
        disabled = false;
        detect_extensions = ["red" "reds"];
        detect_files = [];
        detect_folders = [];
      };
      rlang = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        style = "blue bold";
        symbol = "󰟔 ";
        disabled = false;
        detect_extensions = ["R" "Rd" "Rmd" "Rproj" "Rsx"];
        detect_files = ["DESCRIPTION"];
        detect_folders = [".Rproj.user"];
      };
      ruby = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold red";
        disabled = false;
        detect_extensions = ["rb"];
        detect_files = ["Gemfile" ".ruby-version"];
        detect_folders = [];
        detect_variables = ["RUBY_VERSION" "RBENV_VERSION"];
      };
      rust = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "󱘗 ";
        style = "bold red";
        disabled = false;
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
        detect_folders = [];
      };
      scala = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        disabled = false;
        style = "red bold";
        symbol = " ";
        detect_extensions = ["sbt" "scala"];
        detect_files = [".scalaenv" ".sbtenv" "build.sbt"];
        detect_folders = [".metals"];
      };
      shell = {
        format = "[$indicator]($style) ";
        bash_indicator = "bsh";
        fish_indicator = "fsh";
        zsh_indicator = "zsh";
        powershell_indicator = "psh";
        ion_indicator = "ion";
        elvish_indicator = "esh";
        tcsh_indicator = "tsh";
        nu_indicator = "nu";
        xonsh_indicator = "xsh";
        cmd_indicator = "cmd";
        unknown_indicator = "";
        style = "white bold";
        disabled = true;
      };
      shlvl = {
        threshold = 2;
        format = "[$symbol$shlvl]($style) ";
        symbol = "↕️  ";
        repeat = false;
        repeat_offset = 0;
        style = "bold yellow";
        disabled = true;
      };
      singularity = {
        symbol = "";
        format = "[$symbol\\[$env\\]]($style) ";
        style = "blue bold dimmed";
        disabled = false;
      };
      solidity = {
        format = "via [$symbol($version)]($style)";
        version_format = "v\${major}.\${minor}.\${patch}";
        disabled = false;
        style = "bold blue";
        symbol = "S ";
        compiler = ["solc"];
        detect_extensions = ["sol"];
        detect_files = [];
        detect_folders = [];
      };
      spack = {
        truncation_length = 1;
        format = "via [$symbol$environment]($style) ";
        symbol = "🅢 ";
        style = "blue bold";
        disabled = false;
      };
      status = {
        format = "[$symbol$status]($style) ";
        symbol = "❌";
        success_symbol = "";
        not_executable_symbol = "🚫";
        not_found_symbol = "🔍";
        sigint_symbol = "🧱";
        signal_symbol = "⚡";
        style = "bold red";
        map_symbol = false;
        recognize_signal_code = true;
        pipestatus = false;
        pipestatus_separator = "|";
        pipestatus_format = "\\[$pipestatus\\] => [$symbol$common_meaning$signal_name$maybe_int]($style) ";
        disabled = true;
      };
      sudo = {
        format = "[as $symbol]($style)";
        symbol = "🧙 ";
        style = "bold blue";
        allow_windows = false;
        disabled = true;
      };
      swift = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold 202";
        disabled = false;
        detect_extensions = ["swift"];
        detect_files = ["Package.swift"];
        detect_folders = [];
      };
      terraform = {
        format = "via [$symbol$workspace]($style) ";
        version_format = "v\${raw}";
        symbol = "💠 ";
        style = "bold 105";
        disabled = false;
        detect_extensions = ["tf" "tfplan" "tfstate"];
        detect_files = [];
        detect_folders = [".terraform"];
      };
      time = {
        format = "at [$time]($style) ";
        style = "bold yellow";
        use_12hr = false;
        disabled = true;
        utc_time_offset = "local";
        time_range = "-";
      };
      typst = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "t ";
        style = "bold #0093A7";
        disabled = false;
        detect_extensions = ["typ"];
        detect_files = ["template.typ"];
        detect_folders = [];
      };
      username = {
        detect_env_vars = [];
        format = "[$user]($style) in ";
        style_root = "red bold";
        style_user = "yellow bold";
        show_always = false;
        disabled = false;
        aliases = {};
      };
      vagrant = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "⍱ ";
        style = "cyan bold";
        disabled = false;
        detect_extensions = [];
        detect_files = ["Vagrantfile"];
        detect_folders = [];
      };
      vcsh = {
        symbol = "";
        style = "bold yellow";
        format = "vcsh [$symbol$repo]($style) ";
        disabled = false;
      };
      vlang = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = "V ";
        style = "blue bold";
        disabled = false;
        detect_extensions = ["v"];
        detect_files = ["v.mod" "vpkg.json" ".vpkg-lock.json"];
        detect_folders = [];
      };
      zig = {
        format = "via [$symbol($version )]($style)";
        version_format = "v\${raw}";
        symbol = " ";
        style = "bold yellow";
        disabled = false;
        detect_extensions = ["zig"];
        detect_files = [];
        detect_folders = [];
      };
      custom = {};
    };
  };
}
