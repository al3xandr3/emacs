
;;;;;;;;;;;;;;;;;;;;
;; Quick open
(defun dot ()
  (interactive)
  (find-file "/my/config/emacs/dot-emacs.el"))

(defun dot-reload ()
  (interactive)
  (load-file "/my/config/emacs/dot-emacs.el"))

(defun key ()
  (interactive)
  (find-file "/my/config/emacs/key-bindings.org"))

(defun config ()
  (interactive)
  (find-file "/my/config/emacs/d/al3xandr3/"))

(defun skype ()
  (interactive)
  (find-file "/my/config/org/skype.org"))

(defun me ()
  (interactive)
  (find-file "/my/config/org/me.org"))

(defun data ()
  (interactive)
  (find-file "/my/proj/data/data.org"))

(defun blog ()
  (interactive)
  (find-file "/my/proj/al3xandr3.github.com/_org/posts"))

(defun rdir ()
  (interactive)
  (find-file "/my/proj/r"))

;; load customizations
(load "/my/config/emacs/d/al3xandr3/config.el")     ; my config
(load "/my/config/emacs/d/al3xandr3/orgmode.el")    ; org-mode
(load "/my/config/emacs/d/al3xandr3/javascript.el") ; javascript
(load "/my/config/emacs/d/al3xandr3/clojure.el")    ; clojure
(load "/my/config/emacs/d/al3xandr3/ruby.el")       ; ruby
(load "/my/config/emacs/d/al3xandr3/r.el")          ; r
(eval-after-load "sql"
  '(load-library "/my/config/emacs/d/sql-indent.el")) ; sql-indent
(load "/my/config/emacs/d/al3xandr3/python.el")          ; python
