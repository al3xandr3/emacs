
;; Quick open
(defun dot ()
  (interactive)
  (find-file "/my/config/emacs/dot-emacs.el"))

(defun dot-reload ()
  (interactive)
  (load-file "/my/config/emacs/dot-emacs.el"))

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
  (find-file "/my/statistician/statistician.org"))

(defun blog ()
  (interactive)
  (find-file "/my/al3xandr3.github.com/_org/posts"))






;;;;;;;;;;;;;;;;;;;;
;;;;; (aqua)Emacs Settings

;; Turn on Fringes
(fringe-mode '(15 . 10))

;; Proper line spacing
(setq-default line-spacing 3)

;; Font setting
;;(defvar myfont "Menlo")
;;(defvar myfont "Helvetica Neue")
;;(defvar myfont "Bitstream Vera Sans Mono")
(defvar myfont "Inconsolata")
(defvar myfontsize 150)

(set-face-attribute 'default nil :family myfont :height myfontsize)

;;(set-face-attribute 'org-mode-default nil :family myfont :height myfontsize)
(if (facep 'org-mode-default)
  (set-face-attribute 'org-mode-default nil :family myfont :height myfontsize))
(set-face-attribute 'minibuffer-prompt nil :family myfont :height myfontsize)
(if (facep 'minibuffer)
    (set-face-attribute 'minibuffer nil :family myfont :height myfontsize))
(if (facep 'echo-area)
    (set-face-attribute 'echo-area nil :family myfont :height myfontsize))

;; Hide Toolbar
(tool-bar-mode -1)

;; Open recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; turn off auto fill mode
(auto-fill-mode 0)

;; Paren Highlight - for Color Theme
(setq show-paren-delay 0)      ; how long to wait?
(show-paren-mode t)            ; turn paren-mode on
(setq show-paren-style 'mixed) ; alternatives are 'parenthesis' and 'mixed'
(set-face-foreground 'show-paren-mismatch-face "red")
(set-face-attribute 'show-paren-mismatch-face nil 
                    :weight 'bold :underline t :overline nil :slant 'normal)

;; Jumping beteen windows will use the meta key
(windmove-default-keybindings 'meta)

;; allow to downcase-region a full region
(put 'downcase-region 'disabled nil)

;; turn of tabs identation, only use spaces
(setq-default indent-tabs-mode nil)

;;;; YAS
(load-file "/my/config/emacs/d/yasnippet-bundle.el")
(require 'yasnippet-bundle)
;; define personal snippets
(setq yas/root-directory "/my/config/emacs/d/yasnippets")
;; Load the snippets
(yas/load-directory yas/root-directory)

;; Speedbar
(load-file "/my/config/emacs/d/sr-speedbar.el")
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq sr-speedbar-refresh-turn-on nil)
(add-hook 'speedbar-reconfigure-keymaps-hook
	  '(lambda ()
	     (define-key speedbar-key-map (kbd "<up>") 'speedbar-prev)	    
	     (define-key speedbar-key-map (kbd "<down>") 'speedbar-next)
	     (define-key speedbar-key-map (kbd "<right>") 'speedbar-expand-line)
	     (define-key speedbar-key-map (kbd "<left>") 'speedbar-contract-line )
	     (define-key speedbar-key-map (kbd "M-<up>") 'speedbar-up-directory)
	     (define-key speedbar-key-map (kbd "<f5>") 'speedbar-refresh)
	     ))	  
(global-set-key (kbd "C-p") 'sr-speedbar-toggle)

(global-set-key (kbd "C-r") 'query-replace-regexp)

;; Pabbrev autocompletion
(load-file "/my/config/emacs/d/pabbrev.el")
(require 'pabbrev)
(global-pabbrev-mode)
(setq pabbrev-read-only-error nil)
(defun pabbrev-expand-maybe-no-buffer()
  "Expand abbreviation, or run previous command . 
   If there is no expansion the command returned by 
   projected will be run instead		 . "
  (interactive)
  (if pabbrev-expansion
      (pabbrev-expand)
    (let ((prev-binding
           (pabbrev-get-previous-binding)))
      (if (and (fboundp prev-binding)
               (not (eq prev-binding 'pabbrev-expand-maybe)))
          (funcall prev-binding)))))






;;;;;;;;;;;;;;;;;;;;
;; My Utils
(defun sheller (ffilter cmd myfile post-cmd)
  (if (string-match ffilter (buffer-file-name))
      (shell-command
       (concat
	cmd
	myfile
	post-cmd))))

(defun sheller-buffer (ffilter cmd)
  (sheller
   ffilter
   cmd
   (buffer-file-name (current-buffer))
   ""))






;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Org-mode

;; Install
(setq load-path (cons "/my/config/emacs/d/org-mode/lisp" load-path))
(setq load-path (cons "/my/config/emacs/d/org-mode/contrib/lisp" load-path))
(require 'org-install)

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

;;;; Behaviour Setup
(setq org-directory "/my/config/org/")
(setq org-startup-indented t) ;; automatic indentation
(setq org-src-fontify-natively t) ;; native syntax hightlight
(setq org-confirm-babel-evaluate nil) ;; don't ask to evaluate
(setq org-log-done t) ;; +STARTUP: logdone
(setq org-todo-keywords
      '((sequence "QUEUE" "WAIT" "TODO" "|" "DONE"))
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
                             "/my/statistician/statistician.org"))
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
  (sheller ".*" "ruby /my/al3xandr3.github.com/pre-process.rb" "" "")
  (sheller ".*" "ruby /my/al3xandr3.github.com/tags.rb" "" "")
  (sheller ".*" "ruby /my/al3xandr3.github.com/cloud.rb" "" ""))

(defun blog-server ()
  (interactive)
  (sheller ".*" "cd /my/al3xandr3.github.com/; rm -rf _site/; jekyll --server &" "" ""))
(global-set-key (kbd "C-z") 'blog-server)

(defun blog-open ()
  (interactive)
  (sheller ".*" "open http://localhost:4000" "" ""))

(defun post ()
  (interactive)
  (org-export-as-html 3 nil nil nil nil "/my/al3xandr3.github.com/_posts")
  (blog-rb)
  (blog-server)
  (blog-open))

(defun page ()
  (interactive)
  (org-export-as-html 3 nil nil nil nil "/my/al3xandr3.github.com/pages")
  (blog-rb)
  (blog-server)
  (blog-open))






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
       (string-match "\/wa-core\\.js$" (buffer-file-name))
       (string-match "\/s_code\\.js$" (buffer-file-name))
       (string-match "\/trackable\\.js$" (buffer-file-name))
       (string-match "\/wa-static\\.js$" (buffer-file-name)))
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
;;(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
;;(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

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






;;;;;;;;;;;;;;;;;;;;
;;;;;;; Clojure

;; clojure-mode
(add-to-list 'load-path "/my/config/emacs/d/slime")
(add-to-list 'load-path "/my/config/emacs/d/slime/contrib/")
(add-to-list 'load-path "/my/config/emacs/d/clojure-mode")
(require 'slime)
(require 'clojure-mode)

(setq slime-protocol-version 'ignore) ;;ignore the mismatch version message
(eval-after-load "slime"
  '(progn
    ;; "Extra" features (contrib)
    (slime-setup 
     '(slime-repl slime-banner slime-highlight-edits slime-fuzzy))
    (setq 
     ;; Use UTF-8 coding
     slime-net-coding-system 'utf-8-unix
     ;; Use fuzzy completion (M-Tab)
     slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
    ;; Use parentheses editting mode paredit
    ;;(defun paredit-mode-enable () (paredit-mode 1))
    ;;(add-hook 'slime-mode-hook 'paredit-mode-enable)
    ;;(add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
    ))

;; By default inputs and results have the same color
;; Customize result color to differentiate them
;; Look for `defface' in `slime-repl.el' if you want to further customize
;;(custom-set-faces
;; '(slime-repl-result-face ((t (:foreground "LightGreen")))))

(eval-after-load "swank-clojure"
  '(progn
    ;; Make REPL more friendly to Clojure (ELPA does not include this?)
    (add-hook 'slime-repl-mode-hook
      'swank-clojure-slime-repl-modify-syntax t)
    ;; Add classpath for Incanter (just an example)
    ;; The preferred way to set classpath is to use swank-clojure-project
    ;;(add-to-list 'swank-clojure-classpath 
    ;;             "path/to/incanter/modules/incanter-app/target/*")
    ))

(defun lein-swank ()
  (interactive)
  (let ((root (locate-dominating-file default-directory "project.clj")))
    (when (not root)
      (error "Not in a Leiningen project."))
    ;; you can customize slime-port using .dir-locals.el
    (shell-command (format "cd %s && lein swank %s &" root slime-port)
                   "*lein-swank*")
    (set-process-filter (get-buffer-process "*lein-swank*")
                        (lambda (process output)
                          (when (string-match "Connection opened on" output)
                            (slime-connect "localhost" slime-port)
                            (set-process-filter process nil))))
    (message "Starting swank server...")))

;; Org Babel Clojure
(require 'ob-clojure)
;; overwrites org-babel-execute:clojure from ob-clojure.clj
;; to call lein-swank instead, thus loading local proj jars
(defun org-babel-execute:clojure (body params) 
  "Execute a block of Clojure code with Babel."
  (require 'slime)
  (if (not (slime-current-connection))
       (lein-swank))
  (with-temp-buffer
    (insert (org-babel-expand-body:clojure body params))
    (read
     (slime-eval
      `(swank:interactive-eval-region
        ,(buffer-substring-no-properties (point-min) (point-max)))
      (cdr (assoc :package params))))))
