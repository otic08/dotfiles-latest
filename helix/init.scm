(require "oil/oil.scm")
(require "steel-pty/term.scm")
(require "smooth-scroll/smooth-scroll.scm")
(require "showkeys/showkeys.scm")
(require "helix/keymaps.scm")
(require "fresco/fresco.scm")
(require "scopeline/scopeline.scm")
(require "who/who.scm")
;(require "trail/trail.scm")
(require "splash-hx/splash.scm")
(require "hxwiki/hxwiki.scm")


; (require "moka/moka.scm")

(fresco-start!)

;; Optional: set defaults (both #false by default)
;; (oil-configure! show-dotfiles show-git-ignored)
(oil-configure! #false #false)

; (moka-enable!)
; moka-configure!
 ; #:sections
 ; (list
  ; (moka-section (list (moka-segment 'mode) (moka-segment 'file)) #:align 'left)
  ; (moka-section (list (moka-segment 'lsp) (moka-segment 'git-branch) (moka-segment 'position)) #:align 'right)))

;; Add this to your init.scm
(when (equal? (command-line) '("hx"))
  (show-splash))


(set-hxwiki-root! "~/obsidian_docs")          ; "~" expands to the user's home directory
