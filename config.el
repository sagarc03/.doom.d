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
(setq doom-theme 'doom-one-light)
(setq doom-font (font-spec :family "SpaceMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Helvetica" :size 15)
      doom-big-font (font-spec :family "SpaceMono Nerd Font" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-keyword-face :slant italic)
  '(font-lock-comment-face :slant italic))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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
(require 'py-yapf)

(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'py-isort-before-save nil 'make-it-local)
            (add-hook 'before-save-hook 'py-yapf-enable-on-save nil 'make-it-local)
            (add-hook 'before-save-hook 'py-autopep8-enable-on-save nil 'make-it-local)
            (setq flycheck-checker 'python-flake8)))

(setq +python-jupyter-repl-args '("--simple-prompt"))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")

(require 'flycheck-mypy)
;; (add-hook 'python-mode-hook 'flycheck-mode)

(setenv "GO111MODULE" "on")
(setq flycheck-golangci-lint-deadline "5s")
(setq flycheck-golangci-lint-enable-linters '("dupl" "gci" "godot" "gofmt" "golint" "gosec" "lll" "misspell" "tparallel" "unparam" "whitespace" "wsl" "bodyclose" "sqlclosecheck" "gofumpt" "maligned"))

(add-hook! 'lsp-after-initialize-hook
  (run-hooks (intern (format "%s-lsp-hook" major-mode))))

(defun go-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'golangci-lint))
(add-hook 'go-mode-lsp-hook #'go-flycheck-setup)

(setq doom-modeline-buffer-file-name-style 'truncate-from-project)

(setq highlight-indent-guides-method 'character)
