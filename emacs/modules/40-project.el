(use-package projectile
  :init
  (projectile-mode +1)
  :after general
  :config
  (my-leader-def
    "p"   '(:ignore t :which-key "projects")
    "p p" '(projectile-switch-project :which-key "Switch project")
    "p f" '(projectile-find-file :which-key "Find file in project")))
