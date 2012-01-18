;; Copy-Cut-Paste from clipboard with Super-C Super-X Super-V
(global-set-key (kbd "s-x") 'clipboard-kill-region) ;;cut
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save) ;;copy
(global-set-key (kbd "s-v") 'clipboard-yank) ;;paste

; Ctrl+tab mapped to Alt+tab
(define-key function-key-map [(control tab)] [?\M-\t])

;; Rope bindings
(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key py-mode-map "\C-ci" 'rope-auto-import)
	    (define-key py-mode-map "\C-c\C-d" 'rope-show-calltip))
	  )
(windmove-default-keybindings 'meta)
(global-set-key [?\C-,] 'previous-buffer)
(global-set-key [?\C-.] 'next-buffer)
(global-set-key [?\C-z] 'shell) ;; ну… shell

(provide 'keybind)
