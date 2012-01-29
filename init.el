(defconst emacs-d
  (file-name-directory (or load-file-name
                           (when (boundp 'bytecomp-filename) bytecomp-filename)
                           buffer-file-name))
  "Installation directory of emacs e.g as .emacs.d"
)

;; Adding paths to the variable load-path
(dolist (relpath '(""
                   "exten/"
                   "exten/yasnippet"
                   "exten/auto-complete"
                   "init/"
                   )
                 )
  (add-to-list 'load-path (concat emacs-d relpath)))

(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(toggle-fullscreen)

;;Provide python-dev-mode
(require 'python-dev-mode (concat emacs-d "init/python-dev-mode.el"))

;;Provide completions
(require 'completions (concat emacs-d "init/completions.el"))

;;Provide editing customization
(require 'editors (concat emacs-d "init/editors.el"))

;;Provide editing customization
(require 'keybind (concat emacs-d "init/keybind.el"))

;;Provide decoration custom
(require 'decorations (concat emacs-d "init/decorations.el"))

(setq inhibit-startup-message t) ;;не показывать сообщение при старте
(fset 'yes-or-no-p 'y-or-n-p) ;;не заставляйте меня печать yes целиком
(setq file-name-coding-system 'utf-8)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(require 'ecb)
(epy-setup-checker "pyflakes %f")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-auto-activate t)
 '(ecb-create-layout-file "~/.emacs.d/custom_layout.el")
 '(ecb-directory-face (quote ecb-directory-face))
 '(ecb-layout-name "python-mode")
 '(ecb-layout-window-sizes (quote (("python-mode" (0.17857142857142858 . 0.5869565217391305) (0.17857142857142858 . 0.391304347826087)))))
 '(ecb-options-version "2.40")
 '(ecb-prescan-directories-for-emptyness t)
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path (quote ("~/ezscratch" "~/42cc" "~/")))
 '(ecb-tip-of-the-day nil)
 '(ecb-vc-enable-support t)
 '(ecb-windows-width 0.25))
