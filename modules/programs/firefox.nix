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
              { name = ""; url = "https://tradingview.com/markets"; }
              { name = ""; url = "https://search.nixos.org/packages?channel=unstable"; }
              { name = ""; url = "https://nur.nix-community.org"; }
              { name = ""; url = "https://stackoverflow.com"; }
              { name = ""; url = "https://chatgpt.com"; }
              { name = ""; url = "https://gemini.google.com"; }
              { name = ""; url = "https://github.com"; }
              { name = ""; url = "https://reddit.com"; }
              { name = ""; url = "https://x.com"; }
              { name = ""; url = "https://steampowered.com"; }
              { name = ""; url = "https://web.telegram.org"; }
              { name = ""; url = "https://discord.com/app"; }
              { name = ""; url = "https://twitch.tv"; }
              { name = ""; url = "https://rutube.ru"; }
              { name = ""; url = "https://youtube.com"; }
              { name = ""; url = "https://music.youtube.com"; }
              { name = ""; url = "https://open.spotify.com"; }
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
                icon = "https://search.nixos.org/favicon.png";
                definedAliases = [ "@nix" ];
              };
              "nur" = {
                urls = [{ template = "https://nur.nix-community.org/?query={searchTerms}"; }];
                icon = "https://nur.nix-community.org/images/favicon.ico";
                definedAliases = [ "@nur" ];
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
            "widget.wayland.enabled" = true;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "ui.systemUsesDarkTheme" = 1;
            "gfx.color_management.mode" = 0;
            "browser.theme.toolbar-theme" = 2;
            "browser.toolbars.bookmarks.visibility" = "always";
            "browser.startup.page" = 1;
            "browser.startup.homepage" = "about:home|https://github.com";
            "browser.newtabpage.activity-stream.feeds.topsites" = false;

            "browser.tabs.closeWindowWithLastTab" = false;
            "browser.tabs.loadInBackground" = true;
            "browser.tabs.warnOnClose" = false;
            "browser.ctrlTab.sortByRecentlyUsed" = false;
            "browser.urlbar.suggest.searches" = false;
            "browser.urlbar.trimURLs" = false;

            "privacy.sanitize.sanitizeOnShutdown" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "privacy.clearOnShutdown.history" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.resistFingerprinting" = false;
            "privacy.window.maxInnerWidth" = 1600;
            "privacy.window.maxInnerHeight" = 900;

            "browser.ping-centre.telemetry" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "browser.formfill.enable" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "toolkit.telemetry.enabled" = false;
            "dom.security.https_only_mode" = true;
            "signon.rememberSignons" = false;

            "media.peerconnection.enabled" = false;
            "media.peerconnection.ice.no_host" = true;
            "network.http.sendRefererHeader" = 2;
            "network.http.referer.XOriginPolicy" = 1;
            "network.http.referer.XOriginTrimmingPolicy" = 2;
            "network.proxy.type" = 1;
            "network.proxy.socks" = "127.0.0.1";
            "network.proxy.socks_port" = 1080;
            "network.proxy.socks_remote_dns" = true;
          };

          extensions.packages = with pkgs.nur.repos; [
            rycee.firefox-addons.privacy-badger
            rycee.firefox-addons.clearurls
            rycee.firefox-addons.bitwarden
          ];
        };

        policies = {
          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };
    };
    environment.variables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_DISABLE_RDD_SANDBOX = "1";
    };
  };
}
