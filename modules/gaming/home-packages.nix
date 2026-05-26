{...}: {
	flake.homeModules.gaming.home.packages = with pkgs; [
		winetricks
		wineWowPackages.waylandFull
		prismlauncher
		scanmem
		med
		samrewritten
	];
}
