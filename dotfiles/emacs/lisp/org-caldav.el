;;; org-caldav-config.el -*- lexical-binding: t; -*-

(use-package org-caldav
  :ensure (:host github :repo "dangste/org-caldav"))

(setq org-caldav-url 'google
      org-caldav-calendar-id "831578916816-biv5fr5diuipfob10vkntgc3f6tpq9l9.apps.googleusercontent.com"
      org-caldav-inbox "~/org/caldav-inbox.org"
      org-caldav-file '("~/org/schedule.org")
      org-caldav-sync-direction 'twoway
      org-caldav-delete-org-enteries 'ask
      org-caldav-delete-calendar-enteries 'ask
      org-icalendar-timezone "America/New_York"
      org-icalendar-include-todo nil
      org-export-with-broken-links t)

(with-eval-after-load 'org
  (setq org-export-with-broken-links t))

(advice-add 'org-export-data :around
            (lambda (orig-fun &rest args)
              (let ((org-export-with-broken-links t))
                (apply orig-fun args))))

;; ============================================================================
;; CALDAV SYNC HOOKS
;; ============================================================================

(defun my/org-caldav-sync-calendar ()
  "Sync CalDav when saving calendar.org."
  (when (and buffer-file-name
             (string-equal (file-name-nondirectory buffer-file-name)
                           "calendar.org"))
    (org-caldav-sync)))

(add-hook 'after-save-hook #'my/org-caldav-sync-calendar)

(defun my/org-caldav-sync-after-capture ()
  "Sync CalDav after capturing an event."
  (when (and (boundp 'org-capture-mode)
             org-capture-mode
             (member (buffer-file-name)
                     (mapcar #'expand-file-name org-caldav-files)))
    (run-with-timer 1 nil #'org-caldav-sync)))

(add-hook 'org-capture-after-finalize-hook #'my/org-caldav-sync-after-capture)
