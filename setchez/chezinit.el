(message "set chez")


;; (use-package geiser-chez
;;   :ensure t)

(require 'cmuscheme)

(defun paredit-splice-frame()
  (interactive)
  ;(run-scheme "chezscheme")
  (run-chez)
  (delete-window)
  (split-window-below (floor (* 0.68 (window-height))))
  (other-window 1)
  (run-scheme "chezscheme")
  (other-window -1)
  ;(switch-to-buffer-other-frame "*scheme*")
  ;(scheme-send-last-sexp)
  )

(use-package paredit
  :ensure t
;  :delight " Par"
;  :after (scheme-mode)
  :bind
  (:map paredit-mode-map
	("M-<up>" . paredit-splice-sexp)
	("M-<down>" . paredit-wrap-round)
	("C-<right>" . paredit-forward-slurp-sexp)
	("C-<left>" . paredit-backward-slurp-sexp)
	("M-<left>" . paredit-backward-barf-sexp)
	("M-<right>" . paredit-forward-barf-sexp)
	("s-x s-e" . scheme-send-last-sexp)
	("C-c C-c" . scheme-send-definition)
;	("C-x C-e" . geiser-eval-last-sexp)
	("C-x C-M-w" . paredit-splice-frame))
  :hook ((scheme-mode . paredit-mode)
		 ))
;;   :config 
;;   (setenv "MITSCHEME_LIBRARY_PATH"
;; 	  "/usr/bin/chezscheme")
;;      (add-to-list 'exec-path "/usr/bin/chezscheme")
;;      (setq scheme-program-name "chezscheme")
;;   ;; (split-window-below (floor (* 0.68 (window-height))))
;;   ;; (other-window 1)
;; ;  (set-frame-height 30)
;;   ;; (other-window -1)
;;   )


 (use-package scheme-mode
;;   :defer t
   :mode "\\.lsp\\'"
   :hook
   ((lisp-mode . scheme-mode))
   ((scheme-mode . geiser-mode))
;;   :config
   :commands (geiser-mode run-geiser))

;; (use-package geiser-chez
;;   :ensure t)
;; ;; MODULE config about geiser
(use-package geiser-chez
  :ensure t
;;  :defer t
;  :after (scheme-mode)
  :config 
  (setenv "MITSCHEME_LIBRARY_PATH"
	  "/usr/bin/chezscheme")
  (add-to-list 'exec-path "/usr/bin/chezscheme")
  (setq scheme-program-name "chezscheme")
  (setq geiser-chez-binary "chezscheme")
  (setq geiser-active-implementations '(chez))
  (setq run-scheme "chezscheme"))

(provide 'chezinit)
