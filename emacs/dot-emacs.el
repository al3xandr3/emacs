
;;;;;;;;;;;;;;;;;;;;
;; Quick open
(defun dot ()
  (interactive)
  (find-file "/my/config/emacs/dot-emacs.el"))

(defun dot-reload ()
  (interactive)
  (load-file "/my/config/emacs/dot-emacs.el"))

(defun config ()
  (interactive)
  (find-file "/my/config/emacs/d/al3xandr3/"))

(defun skype ()
  (interactive)
  (find-file "/my/config/org/skype.org"))

(defun me ()
  (interactive)
  (find-file "/my/config/org/me.org"))

(defun optimizer ()
  (interactive)
  (find-file "/my/config/org/optimizer.org"))

(defun stats ()
  (interactive)
  (find-file "/my/stats/stats.org"))

(defun blog ()
  (interactive)
  (find-file "/my/al3xandr3.github.com/_org/posts"))


;; load customizations
(load "/my/config/emacs/d/al3xandr3/config.el")     ; my config
(load "/my/config/emacs/d/al3xandr3/orgmode.el")    ; org-mode
(load "/my/config/emacs/d/al3xandr3/javascript.el") ; javascript
(load "/my/config/emacs/d/al3xandr3/clojure.el")    ; clojure
(load "/my/config/emacs/d/al3xandr3/ruby.el")       ; ruby








