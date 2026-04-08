{ config, pkgs, lib, ... }:
let
  cfg = config.module.editor.vscode;

in {
  options.module.editor.vscode.enable = lib.mkEnableOption "vscode";
  config = lib.mkIf cfg.enable {
    home-manager.users.${config.data.username} = {
      programs.vscode = {
        enable = true;

        package = pkgs.vscode.fhs;
        profiles.default = {
          userSettings = {
            "update.mode" = "none";
            "extensions.autoUpdate" = false;
            "extensions.autoCheckUpdates" = false;
            "workbench.enableExperiments" = false;
            "workbench.settings.enableNaturalLanguageSearch" = false;
            "workbench.settings.editor" = "json";
            "telemetry.telemetryLevel" = "off";
            "files.autoSave" = "onFocusChange";
            "workbench.iconTheme" = "material-icon-theme";

            "editor.formatOnSave" = true;
            "editor.minimap.enabled" = false;
            "editor.inlineSuggest.enabled" = true;

            #Git
            "git.enableSmartCommit" = true;
            "git.autofetch" = true;
            "git.confirmSync" = false;

            #Docker
            "docker.compose.linux.version" = "v2";
            "json.format.enable" = true;

            #Nix
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nil";
            "nix.serverSettings.nil.formatting.command" = [ "nixfmt" ];

            #C/C++
            "C_Cpp.intelliSenseEngine" = "disabled";
            "clangd.arguments" = [
              "--header-insertion=never"
              "--completion-style=detailed"
              "--function-arg-placeholders"
              "--fallback-style=llvm"
            ];

            #Rust
            "rust-analyzer.check.command" = "clippy";
            "rust-analyzer.cargo.buildScripts.enable" = true;

            #Front
            "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
            "[css]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
            "[javascript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
            "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
          };

          extensions = with pkgs.vscode-extensions; [
            ms-ceintl.vscode-language-pack-ru
            pkief.material-icon-theme
            eamodio.gitlens

            #Nix
            jnoortheen.nix-ide
            mkhl.direnv

            #Docker
            ms-azuretools.vscode-docker

            #C/C++
            llvm-vs-code-extensions.vscode-clangd
            ms-vscode.cmake-tools
            ms-vscode.cpptools

            #Rust
            rust-lang.rust-analyzer
            tamasfe.even-better-toml

            #Front
            esbenp.prettier-vscode
            dbaeumer.vscode-eslint
            ecmel.vscode-html-css

            #RPC
            zxh404.vscode-proto3
          ] ++ (with pkgs.vscode-marketplace; [

          ]);

          keybindings = [];
        };
      };

      home.packages = with pkgs; [
        #Nix
        nil
        nixfmt

        #C/C++
        gdb
        ninja
        clang-tools
        cmake-language-server

        #Rust
        rustc
        cargo

        #Front
        nodejs_20
        eslint
        prettier
        typescript-language-server
      ];
    };
  };
}
