;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; (aqua)Emacs Settings

;; hide toolbar
(tool-bar-mode -1)

;; turn on fringes
(fringe-mode '(15 . 10))

;; line spacing
(setq-default line-spacing 3)

;; font
;; "Menlo", "Helvetica Neue", "Bitstream Vera Sans Mono", 
(defvar myfont "Inconsolata")
;;(defvar myfont "Consolas")
(defvar myfontsize 150)
(set-face-attribute 'default nil :family myfont :height myfontsize)
(set-face-attribute 'minibuffer-prompt nil :family myfont :height myfontsize)
(if (facep 'minibuffer)
    (set-face-attribute 'minibuffer nil :family myfont :height myfontsize))
(if (facep 'echo-area)
    (set-face-attribute 'echo-area nil :family myfont :height myfontsize))

;; disable auto fill mode
(auto-fill-mode 0)

;; paren highlight - color theme
(setq show-paren-delay 0)      ; how long to wait?
(show-paren-mode t)            ; turn paren-mode on
(setq show-paren-style 'mixed) ; alternatives are 'parenthesis' and 'mixed'
(set-face-foreground 'show-paren-mismatch-face "red")
(set-face-attribute 'show-paren-mismatch-face nil 
                    :weight 'bold :underline t :overline nil :slant 'normal)

;; Jumping beteen windows will use the meta key
;;(windmove-default-keybindings 'meta)
(global-set-key [(ctrl meta left)]  'windmove-left)
(global-set-key [(control meta up)]    'windmove-up)
(global-set-key [(control meta right)] 'windmove-right)
(global-set-key [(control meta down)]  'windmove-down)

;; allow to downcase-region a full region
(put 'downcase-region 'disabled nil)

;; turn of tabs identation, only use spaces
(setq-default indent-tabs-mode nil)

;; key: search-replace
(global-set-key (kbd "C-r") 'query-replace-regexp)

;; shell does not echoes
(setq comint-process-echoes 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; ADD-ON's

;;;; open recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;;; yasnippets
(load-file "/my/config/emacs/d/yasnippet-bundle.el")
(require 'yasnippet-bundle)
;; define personal snippets
(setq yas/root-directory "/my/config/emacs/d/al3xandr3/yasnippets")
;; Load the snippets
(yas/load-directory yas/root-directory)

;; speedbar
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

;; pabbrev, autocompletion
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

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;;;;;;;;;;;;; 
;; Automatic Parentheses Close
;; enable skeleton-pair insert globally
(setq skeleton-pair t)
;;(setq skeleton-pair-on-word t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\`") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)

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

;;;;;;;;;;;; Full Screen
(defun fullscreen ()
  "Switches to a WriteRoom-like fullscreen style"
  (interactive)	
  (when (featurep 'aquamacs)
    ;; switch to white on black
    ;;(color-theme-initialize)
    ;;(color-theme-clarity)
    ;; switch to Garamond 36pt
    ;;(aquamacs-autoface-mode 0)
    ;;(set-frame-font "-apple-garamond-medium-r-normal--36-360-72-72-m-360-iso10646-1")
    ;; switch to fullscreen mode
    (aquamacs-toggle-full-frame)))
(global-set-key (kbd "C-M-F") 'fullscreen)