(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216)))
