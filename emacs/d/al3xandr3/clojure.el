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
