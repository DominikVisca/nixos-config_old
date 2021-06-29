{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dv";
  home.homeDirectory = "/home/dv";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  imports =
    [ 
      #./wm/gnome40.nix
    ];

  # Allow unfree packages and import Nix User Repository (NUR)
  nixpkgs.config.allowUnfree = true; 
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  }; 

  # Install user space software
  home.packages = with pkgs; [
    zoom-us
    signal-desktop
    vscodium
    kitty
    networkmanagerapplet
    unzip
    rofi
    acpi
  ];

  # Configure git
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "d.visca@posteo.de";
    userName = "Dominik Visca";
  };

  # Configure Firefox
  programs.firefox.enable =  true;
  programs.firefox.extensions = 
    with pkgs.nur.repos.rycee.firefox-addons; [
      darkreader
      localcdn
      ublock-origin
    ];
  programs.firefox.profiles = {
    default = {
      isDefault = true;
      settings = {
        # Customizing
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Privacy settings
        ## Search engine
        ## Has to be changed manualle on first start
        "browser.urlbar.placeholderName" = "DuckDuckGo";

        ## Cookie
        "privacy.firstparty.isolate" = false;
        "privacy.partition.network_state" = true;
        "network.cookie.cookieBehavior" = 5;

        ## Tracking Protection
        "network.cookie.lifetimePolicy" = 2;
        "privacy.history.custom" = true;
        "privacy.sanitize.sanitizeOhnShutdown" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.siteSettings" = true;
        "privacy.purge_trackers.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "network.http.referrer.XOriginPolicy" = 1;

        ## Enable User Contexts
        "privacy.userContext.enabled" = true;
        "privacy.userContent.ui.enabled" = true;
        "permissions.isolateBy.userContext" = true;

        ## Disable Activity Steam
        "browser.newtabpage.enabled" = false;
        "browser.startup.page" = 1;
        "browser.startup.homepage" = "about:blank";
        "browser.library.activity-stream.enabled" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.system.topsites" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.telemtry" = false;
        "browser.newtabpage.activity-stream.feeds.telemtry" = false;
        "browser.ping-centre.telemtry" = false;

        ## Disable unused extensions
        "beacon.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.disabled" = true;
        "browser.pagethumbnails.capturing_disabled" = true;
        "extensions.blocklist.enabled" = false;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.webextensions.restrictedDomains" = "";
        "security.family_safety.mode" = 0;

        ## Disable (auto-)formfill
        "browser.formfill.enable" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;

        ## Disable speculative background loading of websites
        "network.http.speculative-parallel-limit" = 0;

        ## Disable Safebrowsing
        "browser.safebrowsing.pishing.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrwosing.downloads.remote.block_dangerous" = false;
        "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
        "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
        "browser.safebrowsing.downloads.remote.block_uncommon" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.provider.*.gethashURL" = "";
        "browser.safebrwosing.provider.*.updateURL" = "";

        ## Disable Telemtry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemtry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled"	= false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.coverage.opt-out" = true;

        ## Disable Location Tracking
        "browser.region.update.enabled" = false;
        "browser.region.network.url" = "";

        ## Disable Mozilla ads and surveys and notifications
        "browser.startup.homepage_override.mstone" = "ignore";
        "app.normandy.enabled" = false;
        "browser.slowStartup.notificationDisabled" = true;
        "browser.slowStartup.maxSamples" = 0;
      };
    };
  };
}
