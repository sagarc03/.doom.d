;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Sagar Chavan"
      user-mail-address "sagar.c.03@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)
(setq doom-font (font-spec :family "Iosevka SS04":size 16 :weight 'semibold)
      doom-variable-pitch-font (font-spec :family "Source Sans 3" :size 14 :weight 'semibold)
      doom-big-font (font-spec :family "Iosevka SS04" :size 26))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-keyword-face :slant italic)
  '(font-lock-comment-face :slant italic))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq projectile-project-search-path '("~/repos/"))
(require 'auto-virtualenv)

(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")

;; (add-hook 'python-mode-hook 'flycheck-mode)

(setenv "GO111MODULE" "on")

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(add-hook! 'lsp-after-initialize-hook
  (run-hooks (intern (format "%s-lsp-hook" major-mode))))

 ;; (setq flycheck-checker 'go-gofmt))
;; (defun go-flycheck-setup ()
;;   (flycheck-add-next-checker 'lsp 'go-gofmt))

(add-hook 'go-mode-lsp-hook #'go-flycheck-setup)

(setq doom-modeline-buffer-file-name-style 'truncate-from-project)

(setq highlight-indent-guides-method 'character)

(defun my-doom-modeline--font-height ()
  "Calculate the actual char height of the mode-line."
  (+ (frame-char-height) 2))

(advice-add #'doom-modeline--font-height :override #'my-doom-modeline--font-height)
(setq org-log-done t)
(setq deft-directory "~/Dropbox/org/notes/"
      def-extensions '("org" "test")
      deft-recursive t)

(setq org-journal-date-prefix "$+TITILE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

(setq org-roam-directory "~/Dropbox/org/roam")
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(setq ispell-dictionary "en_US")

(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))
