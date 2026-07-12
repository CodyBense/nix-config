;;; modeline.el -*- lexical-binding: t; -*-

(require 'nerd-icons)

(use-package doom-modeline
  :demand t
  :config
  (setq doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-lsp-icon t
        doom-modeline-major-mode-color-icon t)
  (doom-modeline-mode 1))

(provide 'modeline)
