(use-package treemacs
  :defer t
  :config
  (setq treemacs-no-png-images t))

(use-package treemacs-evil
  :after (treemacs evil general)
  :config
  (general-evil-setup 'treemacs)

  (general-define-key
    :states 'treemacs
    :keymaps 'override
    :prefix "SPC"
    "."   '(find-file :which-key "Find file")
    ","   '(switch-to-buffer :which-key "Switch buffer")
    "SPC" '(execute-extended-command :which-key "M-x")
    "b"   '(:ignore t :which-key "buffers")
    "b b" '(switch-to-buffer :which-key "Switch buffer")
    "b k" '(kill-current-buffer :which-key "Kill buffer")
    "b n" '(next-buffer :which-key "Next buffer")
    "b p" '(previous-buffer :which-key "Previous buffer")
    "w"   '(:ignore t :which-key "windows")
    "w v" '(split-window-right :which-key "Split right")
    "w s" '(split-window-below :which-key "Split below")
    "w h" '(evil-window-left :which-key "Focus left")
    "w j" '(evil-window-down :which-key "Focus down")
    "w k" '(evil-window-up :which-key "Focus up")
    "w l" '(evil-window-right :which-key "Focus right")
    "w c" '(delete-window :which-key "Close window")
    "f"   '(:ignore t :which-key "files")
    "f f" '(find-file :which-key "Find file")
    "f s" '(save-buffer :which-key "Save file")))

(use-package treemacs-all-the-icons
  :ensure t
  :after treemacs
  :config
  (treemacs-load-theme "all-the-icons"))
