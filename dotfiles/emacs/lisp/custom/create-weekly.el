(defun create-weekly-file ()
  "Create a daily journal file organized by year and week number."
  (interactive)

  (let* ((current-time (current-time))
         (decoded-time (decode-time current-time))

         ;; Get the year (like 2025)
         (year (format-time-string "%Y" current-time))

         ;; Get week number (1-53) - using %V instead of %U
         ;; %V gives ISO week number where weeks start on Monday
         ;; This should correctly identify March 24, 2025 as week 13
         (week-number (string-to-number (format-time-string "%U" current-time)))

         ;; Get friendly date format like "March 24, 2025"
         (date-string (format-time-string "%U" current-time))

         ;; Create folder paths
         (year-dir (expand-file-name year "~/org/journal/"))

         ;; Create file path/name
         (file-path (expand-file-name (concat "week-" date-string ".org") year-dir)))

    ;; Step 2: Make sure folders exist
    (unless (file-exists-p year-dir)
      (make-directory year-dir t))

    ;; Step 3: Create the file (or open it if it exists)
    (find-file file-path)

    ;; Step 4: Insert template if file is empty
    (when (= (buffer-size) 0)
      (yas-expand-snippet
       (with-temp-buffer
         (insert-file-contents "~/nix-config/dotfiles/emacs/snippets/org-mode/weekly")
         (buffer-string))))))


(global-set-key (kbd "C-x o w") 'create-weekly-file)
(provide 'create-weekly)
