;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Org-mode

;; Install
(setq load-path (cons "/my/config/emacs/d/org-mode/lisp" load-path))
(setq load-path (cons "/my/config/emacs/d/org-mode/contrib/lisp" load-path))
(require 'org-install)

;; Font, myfont & myfontsize defined in config.el
(if (facep 'org-mode-default)
  (set-face-attribute 'org-mode-default nil :family myfont :height myfontsize))
;;;;;;;;;;;;;;;;;;;;

;; turn on spellinn for all text modes
(add-hook 'text-mode-hook 'turn-on-flyspell)

;; Setup
(add-hook 'org-mode-hook (lambda () (auto-fill-mode 0)))
(add-hook 'org-mode-hook (lambda () (visual-line-mode 1)))
(add-hook 'org-mode-hook (lambda () (global-set-key "\C-ci" 'org-toggle-inline-images)))
(add-hook 'org-mode-hook 'turn-on-font-lock)

;; YAS fix
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
          (lambda ()
            ;; yasnippet (using the new org-cycle hooks)
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

;; Shift Select Keybindings
;; use C-c C-t instead for Toggling between TODO, DONE, etc..
(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key org-mode-map [(shift left)]   'ignore)
	     (define-key org-mode-map [(shift left)]   'backward-char)
	     (define-key org-mode-map [(shift right)]  'ignore)
	     (define-key org-mode-map [(shift right)]  'forward-char)
	     (define-key org-mode-map [(shift up)]     'ignore)
	     (define-key org-mode-map [(shift up)]     'previous-line)
	     (define-key org-mode-map [(shift down)]   'ignore)
	     (define-key org-mode-map [(shift down)]   'next-line)	       
	     ))

;;;; Behaviour Setup
(setq org-directory "/my/config/org/")
(setq org-startup-indented t) ;; automatic indentation
(setq org-src-fontify-natively t) ;; native syntax hightlight
(setq org-confirm-babel-evaluate nil) ;; don't ask to evaluate
(setq org-log-done t) ;; +STARTUP: logdone
(setq org-todo-keywords
      '((sequence "WAIT" "TODO" "QUEUE" "|"  "DONE"))
      org-todo-keyword-faces
      '(("QUEUE" . (:foreground "DarkOrange2" :weight bold))
	("DONE" . (:foreground "light sea green"))
	("WAIT" . (:foreground "forest green"))))

;; Agenda
(setq org-upcoming-deadline '(:foreground "blue" :weight bold)
      org-deadline-warning-days 10
      org-agenda-start-on-weekday nil
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-files (list "/my/config/org/me.org"
                             "/my/config/org/skype.org"
                             "/my/config/org/optimizer.org"
                             "/my/proj/data/data.org"))
(global-set-key "\C-ca" 'org-agenda) 

;; Export
(setq org-export-headline-levels 3 
      org-export-with-toc nil 
      org-export-author-info nil 
      org-export-creator-info nil
      org-export-with-section-numbers nil
      org-export-skip-text-before-1st-heading nil 
      org-empty-line-terminates-plain-lists t 
      org-export-with-sub-superscripts nil
      org-export-html-with-timestamp nil
      org-export-with-timestamp nil
      org-export-html-postamble nil
      org-export-html-validation-link nil
      org-export-default-language "en")

;; Clock
(setq org-clock-idle-time 15
      org-clock-out-remove-zero-time-clocks t
      org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Babel
(org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . nil)
        (R . t)
        (ruby . t)
        (sh . t)
        ))

;; (org)LaTex 
(require 'org-latex)
(setq org-export-latex-listings t)
(add-to-list 'org-export-latex-packages-alist '("" "listings"))
(add-to-list 'org-export-latex-packages-alist '("" "color"))

(add-to-list 
 'org-export-latex-classes 
 '("letter"
   "\\documentclass[11pt]{letter}"               
   ("\\section{%s}" . "\\section*{%s}")
   ("\\subsection{%s}" . "\\subsection*{%s}")
   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
   ("\\paragraph{%s}" . "\\paragraph*{%s}")
   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;;; (org)Blog
(defun blog-rb ()
  (interactive)
  (sheller ".*" "export LC_ALL=en_US.UTF-8; export LANG=en_US.UTF-8;ruby /my/proj/al3xandr3.github.com/pre-process.rb" "" "")
  (sheller ".*" "export LC_ALL=en_US.UTF-8; export LANG=en_US.UTF-8;ruby /my/proj/al3xandr3.github.com/tags.rb" "" "")
  (sheller ".*" "export LC_ALL=en_US.UTF-8; export LANG=en_US.UTF-8;ruby /my/proj/al3xandr3.github.com/cloud.rb" "" ""))

(defun blog-server ()
  (interactive)
  (sheller ".*" "export LC_ALL=en_US.UTF-8; export LANG=en_US.UTF-8; cd /my/proj/al3xandr3.github.com/; rm -rf _site/; jekyll --auto --server &" "" "")
  (blog-open))
(global-set-key (kbd "C-z") 'blog-server)

(defun blog-open ()
  (interactive)
  (sheller ".*" "open http://localhost:4000" "" ""))

(defun post ()
  (interactive)
  (org-export-as-html 3 nil nil nil nil "/my/proj/al3xandr3.github.com/_posts")
  (blog-rb))

(defun page ()
  (interactive)
  (org-export-as-html 3 nil nil nil nil "/my/proj/al3xandr3.github.com/pages")
  (blog-rb)
  (blog-open))
