(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

(use-package general
  :after evil
  :config
  (general-evil-setup)

  (general-create-definer my-leader-def
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my-leader-def
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
    "f s" '(save-buffer :which-key "Save file")

    "s"   '(:ignore t :which-key "search")
    "s s" '(consult-line :which-key "Search buffer")
    "s g" '(consult-ripgrep :which-key "Search project")
    "s b" '(consult-buffer :which-key "Switch buffer")
    "s f" '(consult-find :which-key "Find file")
    "s k" '(consult-yank-from-kill-ring :which-key "Kill ring")

    "q"   '(:ignore t :which-key "quit")
    "q q" '(save-buffers-kill-terminal :which-key "Quit Emacs")
    "q r" '(restart-emacs :which-key "Restart Emacs")

    "t"   '(:ignore t :which-key "toggle")
    "t t" '(treemacs :which-key "Treemacs")
    "t n" '(display-line-numbers-mode :which-key "Line numbers")
    "t w" '(whitespace-mode :which-key "Whitespace")

    "'"   '(eshell :which-key "Eshell")))
