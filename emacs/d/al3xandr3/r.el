
;; Use Shift+Enter to do Everything
(setq ess-ask-for-ess-directory nil)
  (setq ess-local-process-name "R")
  (setq ansi-color-for-comint-mode 'filter)
  (setq comint-prompt-read-only t)
  (setq comint-scroll-to-bottom-on-input t)
  (setq comint-scroll-to-bottom-on-output t)
  (setq comint-move-point-for-output t)
  (defun my-ess-start-R ()
    (interactive)
    (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
	(delete-other-windows)
	(setq w1 (selected-window))
	(setq w1name (buffer-name))
	(setq w2 (split-window w1))
	(R)
	(set-window-buffer w2 "*R*")
	(set-window-buffer w1 w1name))))
  (defun my-ess-eval ()
    (interactive)
    (my-ess-start-R)
    (if (and transient-mark-mode mark-active)
	(call-interactively 'ess-eval-region)
      (call-interactively 'ess-eval-line-and-step)))
  (add-hook 'ess-mode-hook
	    '(lambda()
	       (local-set-key [(shift return)] 'my-ess-eval)))
  (add-hook 'inferior-ess-mode-hook
	    '(lambda()
	       (local-set-key [C-up] 'comint-previous-input)
	       (local-set-key [C-down] 'comint-next-input)))
  (require 'ess-site)


;; Tooltip display Pointed Object

(setq ess-R-object-tooltip-alist
      '((numeric    . "summary")
        (factor     . "table")
        (integer    . "summary")
        (lm         . "summary")
        (other      . "str")
        ;;(other      . "eval")
        ))

(defun ess-R-object-tooltip ()
  "Get info for object at point, and display it in a tooltip."
  (interactive)
  (let ((objname (current-word))
        (curbuf (current-buffer))
        (tmpbuf (get-buffer-create "**ess-R-object-tooltip**")))
    (if objname
        (progn
          (ess-command (concat "class(" objname ")\n")  tmpbuf )   
          (set-buffer tmpbuf)
          (let ((bs (buffer-string)))
            (if (not(string-match "\(object .* not found\)\|unexpected" bs))
                (let* ((objcls (buffer-substring 
                                (+ 2 (string-match "\".*\"" bs)) 
                                (- (point-max) 2)))
                       (myfun (cdr(assoc-string objcls 
                                                ess-R-object-tooltip-alist))))
                  (progn
                    (if (eq myfun nil)
                        (setq myfun 
                              (cdr(assoc-string "other" 
                                                ess-R-object-tooltip-alist))))
                    (ess-command (concat myfun "(" objname ")\n") tmpbuf)
                    (let ((bs (buffer-string)))
                      (progn
                        (set-buffer curbuf)
                        (tooltip-show-at-point bs -415 -85)))))))))
    (kill-buffer tmpbuf)))

(global-set-key "\C-c\C-g" 'ess-R-object-tooltip)

;; Tooltip Inspect Pointed Object
(defun ess-R-inspect-tooltip ()
  "Inspect object at point, and display it in a tooltip."
  (interactive)
  (let ((objname (buffer-substring (region-beginning) (region-end)))
        (curbuf (current-buffer))
        (tmpbuf (get-buffer-create "**ess-R-inspect-tooltip**")))
    (if objname
        (progn
          (ess-command (concat "eval(" objname ")\n")  tmpbuf)   
          (set-buffer tmpbuf)
          (let ((bs (buffer-string)))
            (progn
             (set-buffer curbuf)
             (tooltip-show-at-point bs 0 0)))))
    (kill-buffer tmpbuf)))
(global-set-key "\C-cg" 'ess-R-inspect-tooltip)


