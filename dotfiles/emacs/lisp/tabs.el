;;; tabs.el --- Description -*- lexical-binding: t; -*-

(use-package centaur-tabs
  :demand
  :init
  (setq centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-modified-marker t
        centaur-tabs-close-button "✕"
        centaur-tabs-modified-marker "•"
        centaur-tabs-icon-type 'nerd-icons
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-style "bar"
        centaur-tabs-height 32)
  :config
  (centaur-tabs-mode t)
  :bind
  ("<C-tab>" . centaur-tabs-forward)
  ("<C-iso-lefttab>" . centaur-tabs-backward))

(provide 'tabs)
;;; tabs.el ends here
