(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/global-mode 1)
;;Dist snippets dir provide as symlink in ~/.emacs.d/snippets
;;Provide user_snippets dir also symlink into ~/.emacs.d as user_snippets
(setq yas/root-directory "~/.emacs.d/plugins/yasnippet/user_snippets")
(yas/load-directory yas/root-directory)
(provide 'yasnippet)