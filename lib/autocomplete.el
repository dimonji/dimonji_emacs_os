;;See more info about usage and  config - http://cx4a.org/software/auto-complete/manual.html
(add-to-list 'load-path "~/.emacs.d/plugins/autocomplete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/autocomplete/ac-dict")
(ac-config-default)
;;provide finish completilon on TAB
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map "\r" nil)
(provide 'autocomplete)