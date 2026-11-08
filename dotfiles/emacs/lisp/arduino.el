;;; arduino.el --- completion stack -*- lexical-binding: t; -*-
;;; Code:

(use-package arduino-cli-mode
  :ensure t
  :hook arduino-mode
  :mode "\\.ino\\'"
  :custom
  (arduino-cli-warnings 'all)
  (arduino-cli-verify t))

(provide 'arduino)
