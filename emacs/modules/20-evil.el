(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-vsplit-window-right t
        evil-split-window-below t)
  :config
  (setq evil-mode-buffers nil)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-key-blacklist '("SPC"))
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-snipe
  :after evil
  :config
  (evil-snipe-mode 1)
  (evil-snipe-override-mode 1))

(use-package evil-nerd-commenter
  :after evil
  :config
  (evilnc-default-hotkeys))

(use-package evil-escape
  :after evil
  :config
  (setq evil-escape-key-sequence "fd")
  (evil-escape-mode 1))

(use-package evil-visualstar
  :after evil
  :config
  (global-evil-visualstar-mode))

(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-install))


