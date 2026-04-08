{ config, pkgs, lib, inputs, ... }:
let
  cfg = config.module.program.firefox;

in {
  options.module.program.firefox.enable = lib.mkEnableOption "firefox";
  config = lib.mkIf cfg.enable {
    home-manager.users.${config.data.username} = {
      programs.firefox = {
        enable = true;

        profiles.default = {
          isDefault = true;
          id = 0;
          name = "default";
          bookmarks = {
            force = true;
            settings = [
            {
              name = "toolbar";
              toolbar = true;
              bookmarks = [
              { name = ""; url = "https://search.nixos.org/packages?channel=unstable"; }
              { name = ""; url = "https://stackoverflow.com"; }
              { name = ""; url = "https://gemini.google.com"; }
              { name = ""; url = "https://chatgpt.com"; }
              { name = ""; url = "https://github.com"; }
              { name = ""; url = "https://web.telegram.org"; }
              { name = ""; url = "https://reddit.com"; }
              { name = ""; url = "https://youtube.com"; }
              { name = ""; url = "https://rutube.ru"; }
              { name = ""; url = "https://twitch.tv"; }
              { name = ""; url = "https://translate.google.com"; }
              ];
            }
            ];
          };

          search = {
            default = "google";
            force = true;
            engines = {
              "nix" = {
                urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nix" ];
              };
              "git" = {
                urls = [{ template = "https://github.com/search?q={searchTerms}"; }];
                icon = "https://github.com/favicon.ico";
                definedAliases = [ "@git" ];
              };
              "brave" = {
                urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
                icon = "https://brave.com/favicon.ico";
                definedAliases = [ "@b" ];
              };
              "duckduckgo" = {
                urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
                icon = "https://duckduckgo.com/favicon.ico";
                definedAliases = [ "@d" ];
              };
              bing = { metaData.hidden = true; };
              perplexity = { metaData.hidden = true; };
              wikipedia = { metaData.hidden = true; };
            };
          };

          settings = {
            "browser.startup.homepage" = "about:home|https://github.com";
            "browser.startup.page" = 1;
            "ui.systemUsesDarkTheme" = 1;
            "browser.theme.toolbar-theme" = 2;
            "browser.toolbars.bookmarks.visibility" = "always";
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

            "browser.tabs.closeWindowWithLastTab" = false;
            "browser.tabs.loadInBackground" = true;
            "browser.tabs.warnOnClose" = false;
            "browser.ctrlTab.sortByRecentlyUsed" = false;

            "browser.urlbar.suggest.searches" = false;
            "browser.urlbar.trimURLs" = false;

            "privacy.sanitize.sanitizeOnShutdown" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "privacy.clearOnShutdown.history" = true;

            "dom.security.https_only_mode" = true;
            "signon.rememberSignons" = false;
            "browser.formfill.enable" = false;

            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;

            "privacy.resistFingerprinting" = false;
            "privacy.window.maxInnerWidth" = 1600;
            "privacy.window.maxInnerHeight" = 900;

            "browser.ping-centre.telemetry" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "toolkit.telemetry.enabled" = false;

            "widget.wayland.enabled" = true;
            "media.hardware-video-decoding.enabled" = false;
            "gfx.color_management.mode" = 0;

            "network.proxy.type" = 1;
            "network.proxy.socks" = "127.0.0.1";
            "network.proxy.socks_port" = 1080;
            "network.proxy.socks_remote_dns" = true;
          };

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            privacy-badger
            clearurls
            bitwarden
          ];
        };
      };
    };
    environment.variables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_DISABLE_RDD_SANDBOX = "1";
    };
  };
}
