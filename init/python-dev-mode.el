;;Provide python-mode version - 6.0.2
(require 'python-mode (concat emacs-d "exten/python-mode.el"))

;;Provide pymacs version - 0.24-beta2
(require 'pymacs (concat emacs-d "exten/pymacs.el"))

(defun init-ropemacs ()
  "Setup the ropemacs harness"
  (setenv "PYTHONPATH"
          (concat
           (getenv "PYTHONPATH") path-separator
           (concat emacs-d "python-dist/")))
  (pymacs-load "ropemacs" "rope-")

  ;; Stops from erroring if there's a syntax err
  (setq ropemacs-codeassist-maxfixes 3)

  ;; Configurations
  (setq ropemacs-guess-project t)
  (setq ropemacs-enable-autoimport t)


  (setq ropemacs-autoimport-modules '("os" "shutil" "sys" "logging" ))



  ;; Adding hook to automatically open a rope project if there is one
  ;; in the current or in the upper level directory
  (add-hook 'python-mode-hook
            (lambda ()
              (cond ((file-exists-p ".ropeproject")
                     (rope-open-project default-directory))
                    ((file-exists-p "../.ropeproject")
                     (rope-open-project (concat default-directory "..")))
                    ((file-exists-p "../../.ropeproject")
                     (rope-open-project (concat default-directory "..")))
                    ((file-exists-p "../../../.ropeproject")
                     (rope-open-project (concat default-directory "..")))
                    ((file-exists-p "../../../../.ropeproject")
                     (rope-open-project (concat default-directory "..")))
                    )))
  )

(eval-after-load 'python-mode
  '(progn
     (init-ropemacs)
     )
  )


(provide 'python-dev-mode)
