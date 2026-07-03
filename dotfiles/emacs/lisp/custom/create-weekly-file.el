(defun create-weekly-file ()
  "Create a weekly journal file organized by year and week number."
  (interactive)
  (let* ((current-time (current-time))
         (decoded-time (decoded-time current-time))

         ;; Get the year
         (year (format-time-string "%Y" current-time))

         ;; Get week number (1-53)
         (week-number (string-to-number (format-time-string "%U" current-time)))

         ;; Create folder paths
         (year-dir (expand-file-name year "~/org/journal/"))

         ;; Create file path/name
         (file-path (expand-file-name (concat "week-" week-number ".org") year-dir)))

    ;; Step : Make sure folder exist
    (unless (file-exists-p year-dir)
      make-directory year-dir t))


  ;; Step 3: Create the file (or open if it exists)
  (find-file file-path)

  ;; Step 4: Insert template if file is empty
  (when (= (buffer-size) 0)
    (yas-expand-snippet
     (with-temp-buffer
       (insert-into-buffer
        (insert-file-contents "~/nix-config/dotfiles/emacs/snippets/org-mode/weekly")
        (buffer-string))))))

(provide 'create-weekly)
