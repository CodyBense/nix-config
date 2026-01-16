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
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-font (font-spec :family "TerminessNerdFontPropo" :size 18))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Propo" :size 18))

;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'mocha)
(add-to-list 'custom-theme-load-path "~/.config/doom/themes/")
(load-theme 'compline t)

;; Maintain terminal transparency in Doom Emacs
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "undefined")))

;; remove top frame bar in Emacs
(add-to-list 'default-frame-alist '(undecorated . t))

;; Blink cursor
(blink-cursor-mode 1)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

(use-package! javelin
  :config
  (global-javelin-minor-mode 1))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! org-roam
  :defer t
  :commands (org-roam-node-find
             org-roam-node-insert
             org-roam-dailies-goto-today
             org-roam-buffer-toggle
             org-roam-db-sync
             org-roam-capture)  ; Add this
  :init
  (setq org-roam-directory "~/org/roam"
        org-roam-database-connector 'sqlite-builtin
        org-roam-db-location (expand-file-name "org-roam.db" org-roam-directory)
        org-roam-v2-ack t)

  :config
  ;; Don't sync on startup, only when explicitly needed
  (setq org-roam-db-update-on-save nil)

  ;; Create directory if needed
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory t))

  ;; Only enable autosync AFTER first use
  (add-hook 'org-roam-find-file-hook
            (lambda ()
              (unless org-roam-db-autosync-mode
                (org-roam-db-autosync-mode 1))))

  ;; CAPTURE TEMPLATES - Human readable filenames
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: \n\n")
           :unnarrowed t)

          ("n" "note" plain "%?"
           :target (file+head "notes/${slug}.org"
                              ":PROPERTIES:\n:ID:      %(org-id-new)\n:TOPIC: %^{Topic}\n:END:\n#+title: ${title}\n#+filetags: \n\n")
           :unnarrowed t)

          ("b" "book" plain "%?"
           :target (file+head "books/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+author: \n#+filetags: :book:\n\n* Summary\n\n* Key Ideas\n\n* Quotes\n\n* Related\n\n")
           :unnarrowed t)

          ("P" "project" plain "%?"
           :target (file+head "projects/${slug}.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: ${title}\n#+filetags: :project:private:\n\n* Overview\n\n* Goals\n\n* Status\n\n* Notes\n\n")
           :unnarrowed t)))

  ;; DAILIES - Clean date format
  (setq org-roam-dailies-directory "daily/"
        org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%H:%M>: %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              ":PROPERTIES:\n:ID:       %(org-id-new)\n:END:\n#+title: %<%Y-%m-%d %A>\n#+filetags: :daily:\n\n"))))

  ;; Enable completion everywhere (for linking)
  (setq org-roam-completion-everywhere t))

;; org-roam-ui
(use-package! org-roam-ui
  :commands (org-roam-ui-mode org-roam-ui-open)
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; Disables autopairs
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Sends files to trash instead of deleting
(setq delete-by-moving-to-trash t)
;; Save automatically
(setq auto-save-default t)

(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/org/inbox.org" "Inbox")
           "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")

          ("e" "Event" entry
           (file+headline "~/org/calendar.org" "Events")
           "* %^{Event}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:CONTACT: %(org-capture-ref-link \"~/org/contacts.org\")\n:END:\n%?")

          ("d" "Deadline" entry
           (file+headline "~/org/calendar.org" "Deadlines")
           "* TODO %^{Task}\nDEADLINE: %^{Deadline}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")

          ("p" "Project" entry
           (file+headline "~/org/projects.org" "Projects")
           "* PROJ %^{Project name}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n** TODO %?")

          ("i" "Idea" entry
           (file+headline "~/org/ideas.org" "Ideas")
           "** IDEA %^{Idea}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")

          ("b" "Bookmark" entry
           (file+headline "~/org/bookmarks.org" "Inbox")
           "** [[%^{URL}][%^{Title}]]\n:PROPERTIES:\n:CREATED: %U\n:TAGS: %(org-capture-bookmark-tags)\n:END:\n\n"
           :empty-lines 0)

          ("c" "Contact" entry
           (file+headline "~/org/contacts.org" "Inbox")
           "* %^{Name}

                               :PROPERTIES:
                               :CREATED: %U
                               :CAPTURED: %a
                               :EMAIL: %^{Email}
                               :PHONE: %^{Phone}
                               :BIRTHDAY: %^{Birthday +1y}u
                               :LOCATION: %^{Address}
                               :LAST_CONTACTED: %U
                               :END:
                               \\ *** Communications
                               \\ *** Notes
                               %?")

          ("n" "Note" entry
           (file+headline "~/org/notes.org" "Inbox")
           "* [%<%Y-%m-%d %a>] %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?"
           :prepend t)))
  (setq org-hide-emphasis-markers t))

;; (defadvice! fixed-doom--load-theme-a (fn theme &optional no-confirm no-enable)
;;   "Record `doom-theme', disable old themes, and trigger `doom-load-theme-hook'."
;;   :override #'doom--load-theme-a
;;   (with-temp-buffer
;;     (let ((last-themes (copy-sequence custom-enabled-themes)))
;;       (mapc #'disable-theme custom-enabled-themes)
;;       (prog1 (funcall fn theme no-confirm no-enable)
;;         (when (and (not no-enable) (custom-theme-enabled-p theme))
;;           (setq doom-theme theme)
;;           (put 'doom-theme 'previous-themes (or last-themes 'none))
;;           (doom-run-hooks 'doom-load-theme-hook))))))
(setq +latex-viewers '(zathura))
(setq org-latex-compiler "xelatex")
(setq org-latex-pdf-process '("xelatex %f"))
(after! lsp-mode
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("nixd"))
    :major-modes '(nix-mode nix-ts-mode)
    :server-id 'nixd
    :priority 1)))

(after! nix-mode
  (setq nix-nixfmt-bin "nixfmt"))
