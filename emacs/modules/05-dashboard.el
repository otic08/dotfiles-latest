(use-package dashboard
  :init
  (setq dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-show-shortcuts t
        dashboard-items '((recents  . 10)
                          (projects . 5)
                          (bookmarks . 5))
        dashboard-set-file-icons t
        dashboard-set-heading-icons t
        dashboard-week-agenda t
        dashboard-navigation-cycle t)
  :config
  (dashboard-setup-startup-hook))
