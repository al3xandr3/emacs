;;;;;;;;;;;;;;;;;;;; 
;;;;; Ruby mode
;; tips on: https://github.com/senny/emacs-configs/blob/master/private/languages/ruby.el

;;;; Flymake
(eval-after-load 'ruby-mode
  '(progn
     ;; Libraries
     (require 'flymake)

     ;; Invoke ruby with '-c' to get syntax checking
     (defun flymake-ruby-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "ruby" (list "-c" local-file))))

     (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
     (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

     (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
           flymake-err-line-patterns)

     (add-hook 'ruby-mode-hook
               (lambda ()
                 (when (and buffer-file-name
                            (file-writable-p
                             (file-name-directory buffer-file-name))
                            (file-writable-p buffer-file-name)
                            (if (fboundp 'tramp-list-remote-buffers)
                                (not (subsetp
                                      (list (current-buffer))
                                      (tramp-list-remote-buffers)))
                              t))
                   (local-set-key (kbd "C-c d")
                                  'flymake-display-err-menu-for-current-line)
                   (flymake-mode t))))))


;; Inferior Ruby
(load-file "/my/config/emacs/d/inf-ruby.el")
(load-file "/my/config/emacs/d/pcmpl-rake.el")
(load-file "/my/config/emacs/d/ruby-compilation.el")

(eval-after-load 'ruby-mode
  '(progn
     ;; load inferior ruby
     (add-hook 'ruby-mode-hook 'inf-ruby-keys)
     (require 'ruby-compilation)
 
     ;;;; key bindings
     (define-key ruby-mode-map (kbd "C-c e") 'ruby-send-region-and-go)
     (define-key ruby-mode-map (kbd "C-c c") 'ruby-run-w/compilation)
     ))
