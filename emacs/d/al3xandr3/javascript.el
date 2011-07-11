;;;;;;;;;;;;;;;;;;;;
;;;; Javascript

;; 2 space identation
(setq js-indent-level 2)

;; lint
(defun al3xandr3/js-lint ()
  (interactive)
  (message "linting...")
  (sheller-buffer 
   "\\.js$" 
   "java -jar /my/config/bin/javascript/rhino1_7R2/js.jar /my/config/bin/javascript/lint/rhino_jslint.js "))

;; minimize
(defun al3xandr3/js-compile ()
  (interactive)
  (message (buffer-file-name))
  (if (or 
       (string-match "\/wa\\.js$" (buffer-file-name))
       (string-match "\/wa-deprecated\\.js$" (buffer-file-name))
       (string-match "\/s_code\\.js$" (buffer-file-name))
       (string-match "\/s_code_secure\\.js$" (buffer-file-name))
       (string-match "\/trackable\\.js$" (buffer-file-name))
       (string-match "\/wa-static\\.js$" (buffer-file-name))
       (string-match "\/wa-secure\\.js$" (buffer-file-name))
       (string-match "\/wa-shop2\\.js$" (buffer-file-name))
       )
      (progn
        (message "compiling...")
        (sheller-buffer 
         "\\.js$"
         "js-compile "))
    (message "no compile")))
  
;; define hooks
(defun al3xandr3/js-save-hooks ()
  (if (equal major-mode 'js-mode)
      (progn
        (al3xandr3/js-lint)
        (al3xandr3/js-compile)
        )))

;; attach js-save-hooks to save mode
(add-hook 'after-save-hook 'al3xandr3/js-save-hooks)

;; CoffeeScript
(add-to-list 'load-path "/my/config/emacs/d/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-custom () ;; tabs
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; Compile '.coffee' files on every save
(add-hook 'after-save-hook
          '(lambda ()
             (when (string-match "\.coffee$" (buffer-name))
               (coffee-compile-file))))

;;;; Flymake
(eval-after-load 'js
  '(progn
     ;; libraries
     (require 'flymake)

     (defun flymake-jslint-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "java" 
               (list "-jar" 
                     "/my/config/bin/javascript/rhino1_7R2/js.jar" 
                     "/my/config/bin/javascript/lint/rhino_jslint.js" 
                     local-file))))

     (push '(".+\\.js$" flymake-jslint-init flymake-simple-cleanup flymake-get-real-file-name)
           flymake-allowed-file-name-masks)

     (push '("^Lint at line \\([[:digit:]]+\\) character \\([[:digit:]]+\\): \\(.+\\)$"  
             nil 1 2 3)
      flymake-err-line-patterns)

     (add-hook 'js-mode-hook
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