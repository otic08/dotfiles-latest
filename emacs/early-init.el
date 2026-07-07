(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024))

(setq-default inhibit-splash-screen t
              inhibit-startup-message t
              initial-scratch-message nil)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq mac-command-modifier 'meta
      mac-option-modifier 'none
      ns-pop-up-frames nil
      ns-use-srgb-colorspace nil)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
