;;; init.el -*- lexical-binding: t; -*-

;; Username setup
(setq user-full-name "Cody Bense"
      user-mail-address "codybense@gmail.com")
(setq auth-source '("~/.authinfo.gpg" "~/.authinfo")
      auth-source-cache-expiry nil)

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                       :ref nil :depth 1 :inherit ignore
                       :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                       :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
        (elpaca-use-package-mode))

(elpaca-wait)

(setq use-package-always-defer t
      use-package-always-ensure t
      ;; Testing for package timing
      ;; use-package-compute-statistics t
      use-package-expand-minimally t)

;; Sane defaults
(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 ;; Set global kill-ring
 save-interprogram-paste-before-kill t
 x-stretch-cursor t)

(setq
 undo-limit 80000000
 scroll-margin 2
 scroll-conservatively 101
 mouse-wheel-scroll-amount '(2 ((shift) . 5))
 mouse-wheel-progressive-speed nil
 confirm-kill-emacs 'yes-or-no-p
 make-backup-files nil
 create-lockfiles nil
 initial-scratch-message nil
 use-short-answers t
 truncate-string-ellipsis " ")

(electric-pair-mode 1)
(save-place-mode 1)
(setq save-place-limit 400)
(savehist-mode 1)
(recentf-mode 1)
(global-hl-line-mode 1)
(show-paren-mode 1)
(column-number-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode 1)
(setq show-paren-delay 0
      auto-revert-verbose nil)

(setq auto-save-default t
      auto-save-interval 300
      auto-save-timeout 30)
(setq use-package-always-defer t
      use-package-always-ensure t
      ;; Testing for package timing
      ;; use-package-compute-statistics t
      use-package-expand-minimally t)

;; no-littering must run before anything writes files
(setq custom-file (expand-file-name "etc/custom.el" user-emacs-directory))

(with-eval-after-load 'bookmark
  (setq bookmark-default-file (expand-file-name "bookmarks" user-emacs-directory)))

;; Force save frequently so you can see if it's working
(setq bookmark-save-flag 1)

(use-package no-littering
  :demand t
  :init
  (setq no-littering-etc-directory (expand-file-name "etc/" user-emacs-directory)
        no-littering-var-directory  "~/.local/share/emacs/")
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(elpaca-wait)

(when (file-exists-p custom-file)
  (load custom-file))

;; UI
;; temp till I can resolve nerd-icons error message
(setq warning-minimum-level :error)
(set-fringe-mode 10)
(add-to-list 'custom-theme-load-path
             (expand-file-name "themes/" user-emacs-directory))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(use-package doom-themes
  :demand t
  :config
  (load-theme 'compline t))

(defun my/set-theme (variant)
  (mapc #'disable-theme custom-enabled-themes)
  (if (string= variant "dark")
      (load-theme 'compline t)
    (load-theme 'lauds t)))

(use-package which-key
  :demand t
  :config
  (setq which-key-idle-delay 0.1)
  (which-key-mode 1))

(use-package recentf
  :ensure nil
  :config
  (setq recentf-max-menu-items 25
        recentf-max-saved-items 100)
  (dolist (path '("\\.git/" "/tmp/" "/nix/store/"))
    (add-to-list 'recentf-exclude path))
  (add-to-list 'recentf-exclude (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude (recentf-expand-file-name no-littering-etc-directory))
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; Modules
(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/custom/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/private/" user-emacs-directory))


(require 'completion)
(require 'dashboard)
(require 'development)
(require 'dired-config)
(require 'editing)
(require 'flash-config)
(require 'javelin)
;; (require 'keys)
(require 'lsp)
(require 'mail)
(require 'magit-config)
(require 'meow-setup)
(require 'modeline)
(require 'org-config)
(require 'org-roam-config)
(require 'spelling)
(require 'tabs)
(require 'universal-launcher)
(require 'vterm-config)
(require 'workspaces)
;; private
(require 'org-gcal)
;; (global-company-mode)
