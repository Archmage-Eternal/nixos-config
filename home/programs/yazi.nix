{...}: {
    programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;

        # User provided configuration for yazi (home-manager module)
        settings = {
            log = {
                enabled = false;
            };
            mgr = {
                show_hidden = false;
                sort_by = "natural";
                sort_dir_first = true;
                sort_reverse = false;
                show_symlink = true;
                linemode = "none";
                # title_format = {cwd};
            };
            preview = {
                wrap = "yes";
                # max_width = ;
                # max_height = ;
                image_filter = "triangle";
            };
            # opener = {
            #     play = [];
            #     edit = [];
            #     open = [];
            # };
            # open = {
            #     prepend_rules = [];
            #     rules = [];
            #     append_rules = [];
            # };
        };
    };
}
