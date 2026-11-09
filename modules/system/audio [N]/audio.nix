# Audio (NixOS): PipeWire as the single audio server, with ALSA (incl. 32-bit
# for Steam/Wine), PulseAudio and JACK compatibility, and a fixed low-latency
# quantum (256 samples @ 48 kHz, about 5.3 ms).
{
  flake.modules.nixos.audio = {
    security.rtkit.enable = true;
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
        extraConfig.pipewire."92-low-latency"."context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
        extraConfig.pipewire-pulse."92-low-latency"."context.modules" = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              "pulse.min.req" = "256/48000";
              "pulse.default.req" = "256/48000";
              "pulse.max.req" = "256/48000";
              "pulse.min.quantum" = "256/48000";
              "pulse.max.quantum" = "256/48000";
            };
          }
        ];
      };
    };
  };
}
