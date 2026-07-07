(add-to-list 'load-path "/opt/homebrew/Library/Taps/larrasket/homebrew-emacs-liquid-glass/lisp")
(require 'lr-macos-glass)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))

(setq package-selected-packages
      '(all-the-icons consult dashboard doom-modeline dracula-theme evil
        evil-collection evil-escape evil-exchange evil-nerd-commenter evil-snipe
        evil-surround evil-visualstar general marginalia orderless projectile
        restart-emacs treemacs treemacs-evil vertico which-key))
(package-install-selected-packages)

(mapc #'load
      (directory-files (concat user-emacs-directory "modules/") t "^[0-9].*\\.el$"))

(let ((config-file (concat user-emacs-directory "config.el")))
  (when (file-exists-p config-file)
    (load config-file)))

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
'(package-selected-packages
    '(all-the-icons consult dashboard doom-modeline dracula-theme
		   evil evil-collection evil-escape evil-exchange
		   evil-nerd-commenter evil-snipe evil-surround
		   evil-visualstar general marginalia orderless
		   projectile restart-emacs treemacs
		   treemacs-all-the-icons treemacs-evil vertico
		   which-key)))
