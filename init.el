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
                   "exten/autocomplete"
                   "init/"
                   )
                 )
  (add-to-list 'load-path (concat emacs-d relpath)))

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
