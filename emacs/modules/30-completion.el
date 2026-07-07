(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :after general
  :config
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep consult-buffer
   :preview-key (kbd "M-.")))
