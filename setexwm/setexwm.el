(message "set exwm")


(require 'exwm)
(require 'exwm-config)
(exwm-config-default)


(scroll-bar-mode -1) ;; 关闭滚动栏
(toggle-scroll-bar -1)


(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))
;; (global-set-key (kbd "C-c t") 'toggle-transparency)

;; (defun toggle-transparency ()
;;   (interactive)
;;   (let ((alpha (frame-parameter nil 'alpha)))
;;     (set-frame-parameter
;;      nil 'alpha
;;      (if (eql (cond ((numberp alpha) alpha)
;;                     ((numberp (cdr alpha)) (cdr alpha))
;;                     ;; Also handle undocumented (<active> <inactive>) form.
;;                     ((numberp (cadr alpha)) (cadr alpha) ))
;;               100)
;;          '(95 . 95) '(100 . 100)))))
(global-set-key [(f8)] 'toggle-transparency)  ;;注意这行中的F8 , 可以改成你想要的按键  
  
(setq alpha-list '((95 95) (100 100)))  
  
(defun toggle-transparency ()  
  (interactive)  
  (let ((h (car alpha-list)))                  
    ((lambda (a ab)  
       (set-frame-parameter (selected-frame) 'alpha (list a ab))  
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))  
    (setq alpha-list (cdr (append alpha-list (list h))))  
    )  
)  

  ;; (require 'exwm)

  ;; ;; simple system tray
   (require 'exwm-systemtray)
   (exwm-systemtray-enable)
(setq exwm-systemtray-height 30)

(setq display-time-24hr-format t)
(display-time-mode 1)
(display-battery-mode 1)

;;   ;; (require 'exwm-config)
;;   ;; (exwm-config-example)

;;   ;; using xim input
;;   ;(require 'exwm-xim)
;;   ;(exwm-xim-enable)

;; ;; (require 'exwm-systemtray)
;; ;;  (exwm-systemtray-enable)
;; ;; (setq exwm-enable-systray t)
;; ;; (use-package exwm-systemtray
;; ;;     :straight nil
;; ;;     :commands
;; ;;     exwm-systemtray--init
;; ;;     exwm-systemtray--exit
;; ;;     :hook
;; ;;     (exwm-init-hook . exwm-systemtray--init)
;; ;;     (exwm-exit-hook . exwm-systemtray--exit))


;;   ;;(exwm-init)

(require 'exwm-xim)
(exwm-xim-enable)
(push ?\C-\\ exwm-input-prefix-keys)   ;; 使用Ctrl + \ 切换输入法

(setenv "http_proxy" "http://127.0.0.1:7890")
(setenv "https_proxy" "http://127.0.0.1:7890")
(setenv "LC_ALL" "zh_CN.utf8")
(setenv "QT_DEBUG_PLUGINS" "1")
;; (setenv "PATH" "$PATH:$(go env GOPATH)/bin")
;; (setenv "QT_QPA_PLATFORM" "offscreen")

(use-package powerline                          ;;;
  :ensure t
  :config
  (powerline-default-theme))

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-spacemacs t))

(use-package pyim
  :ensure t
  :config
  (setq default-input-method "pyim")
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-default-scheme 'quanpin) ;; 比如我使用全拼
  :bind
  (("C-\\" . 'toggle-input-method))) ;; 使用 Ctrl + \ 作为切换输入法状态的按键)

(provide 'setexwm)
