;; ibuffer by default

(global-set-key (kbd "C-x C-b") 'ibuffer)
;; Ido mode with fuzzy matching
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

(require 'smart-operator)

;; Open Next Line
(require 'open-next-line)

;; Auto Completion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     (concat emacs-d "auto-complete/ac-dict"))
(ac-config-default)

;; Yasnippet - force the loading of the custom version of yasnippet
(require 'yasnippet (concat emacs-d "exten/yasnippet/yasnippet"))
(load-file (concat emacs-d "exten/snippet-helpers.el"))

;; this one is to activate django snippets
(defun epy-django-snippets ()
  "Load django snippets"
  (interactive)
  (yas/load-directory (concat emacs-d "snippets/django"))
  )


(yas/initialize)
(yas/load-directory (concat emacs-d "exten/yasnippet/snippets"))
(setq yas/prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
(setq yas/wrap-around-region 'cua)

;; Eproject project management with emacs
;; (require 'eproject)

;; code borrowed from http://emacs-fu.blogspot.com/2010/01/duplicating-lines-and-commenting-them.html
(defun djcb-duplicate-line (&optional commentfirst)
  "comment line at point; if COMMENTFIRST is non-nil, comment the
original" (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
    (comment-region (region-beginning) (region-end)))
    (insert-string
      (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))

;; duplicate a line
(global-set-key (kbd "C-c y") 'djcb-duplicate-line)

;; duplicate a line and comment the first
(global-set-key (kbd "C-c c")(lambda()(interactive)(djcb-duplicate-line t)))

;; Mark whole line
(defun mark-line (&optional arg)
  "Marks a line"
  (interactive "p")
  (beginning-of-line)
  (push-mark (point) nil t)
  (end-of-line))

(global-set-key (kbd "C-c l") 'mark-line)


; code copied from http://stackoverflow.com/questions/2423834/move-line-region-up-and-down-in-emacs
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

; patches by balle
; http://www.datenterrorist.de
(defun balle-python-shift-left ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
	   mark-active)
	(setq start (region-beginning) end (region-end))
      (progn
	(setq bds (bounds-of-thing-at-point 'line))
	(setq start (car bds) end (cdr bds))))
  (python-indent-shift-left start end))
  (setq deactivate-mark nil)
)

(defun balle-python-shift-right ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
	   mark-active)
	(setq start (region-beginning) end (region-end))
      (progn
	(setq bds (bounds-of-thing-at-point 'line))
	(setq start (car bds) end (cdr bds))))
  (python-indent-shift-right start end))
  (setq deactivate-mark nil)
)

(global-set-key (kbd "s-<up>") 'move-text-up)
(global-set-key (kbd "s-<down>") 'move-text-down)

(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map (kbd "s-<right>")
	      'balle-python-shift-right)
	    (define-key python-mode-map (kbd "s-<left>")
	      'balle-python-shift-left))
	  )

;; Other useful stuff

; delete seleted text when typing
(delete-selection-mode 1)


;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "grey10") ;; Nice color

; highlight brackets
(show-paren-mode t)


;; Line numbering
(setq linum-format "%4d")
(global-linum-mode 1)

;;Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;Autopair mode with triple fix
(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
(add-hook 'lisp-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))
(add-hook 'python-mode-hook
          #'(lambda ()
              (push '(?' . ?')
                    (getf autopair-extra-pairs :code))
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))

;(require 'lambda-mode)
;(add-hook 'python-mode-hook 'lambda-mode 1)
;(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 114 118 12 126 130))
(setq indent-tabs-mode t)
(setq whitespace-display-mappings
 '(
   (space-mark 32 [183] [46]) ; normal space,
   (newline-mark 10 [182 10]) ; newlne, ¶
   (tab-mark 9 [9655 9] [92 9]) ; tab, ▷
))

(custom-set-variables
 '(global-whitespace-mode nil)
 '(whitespace-line-column 79))
(custom-set-faces
 '(whitespace-empty ((t (:foreground "gray0"))))
 '(whitespace-hspace ((((class color) (background dark)) (:foreground "gray0"))))
 '(whitespace-indentation ((t (:foreground "red"))))
 '(whitespace-line ((t (:foreground "violet"))))
 '(whitespace-space ((t (:foreground "gray0"))))
 '(whitespace-space-after-tab ((t (:foreground "firebrick"))))
 '(whitespace-space-before-tab ((t (:foreground "firebrick"))))
 '(whitespace-tab ((((class color) (background dark)) (:foreground "gray0"))))
 '(whitespace-trailing ((t (:foreground "red4" :weight bold)))))

(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
(setq-default py-indent-offset 4)
(column-number-mode t)
(display-time-mode t)

(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
(setq fci-rule-column 78)
(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; Highlight indentation
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)

(provide 'editors)
