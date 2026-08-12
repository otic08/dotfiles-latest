;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Terminess Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Terminess Nerd Font" :size 15))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;;(setq doom-theme 'catppuccin)
;;(setq catppuccin-flavor 'mocha)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq ob-mermaid-cli-path "/home/igp-otidgx/.nvm/versions/node/v22.22.2/bin/mmdc")
(setq org-babel-default-header-args:mermaid
      `((:puppeteer-config-file . ,(expand-file-name "puppeteer-mermaid.json" doom-user-dir))
        (:results . "file")
        (:exports . "results")))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(after! org
  (setq org-startup-with-inline-images t))

;;(add-to-list 'load-path "/opt/homebrew/Library/Taps/larrasket/homebrew-emacs-liquid-glass/lisp")
;;(require 'lr-macos-glass)

;; Make projectile treat each Cargo crate as its own project root.
;; Doom's rust module only adds "Cargo.toml" to `projectile-project-root-files`
;; (used by the *top-down* search, which runs LAST). The *bottom-up* search
;; (which runs FIRST) only looks for VCS dirs like .git, so in a repo where
;; crates live in subdirectories (e.g. ~/learning/rust/guessing_game), eglot
;; handed rust-analyzer the git root -- which has no Cargo.toml -- and
;; rust-analyzer failed with "Failed to discover workspace".
(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "Cargo.toml"))
;;(after! lsp-rust
;;  (setq lsp-rust-analyzer-cargo-watch-command "clippy"))
;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(clojure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))
(after! org
  ;; Only python3 is installed (no `python` binary); without this org-babel
  ;; tries to run `python' and fails with "command not found".
  (setq org-babel-python-command "python3")
  (org-babel-do-load-languages
    'org-babel-load-languages
    '((mermaid . t)
      (scheme . t)))
  (custom-set-faces!
    '(org-level-1 :height 1.4 :weight extra-bold)
    '(org-level-2 :height 1.2 :weight bold)
    '(org-level-3 :height 1.1 :weight bold)
    '(org-level-4 :height 1.05 :weight semi-bold)
    '(org-level-5 :height 1.0 :weight semi-bold))
  (setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿")))
