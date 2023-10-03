;;;init.el


;(setq confirm-kill-emacs #'yes-or-no-p)      ; 在关闭 Emacs 前询问是否确认关闭，防止误触
(electric-pair-mode t)                       ; 自动补全括号
(add-hook 'prog-mode-hook #'show-paren-mode) ; 编程模式下，光标在括号上时高亮另一个括号
(column-number-mode t)                       ; 在 Mode line 上显示列号
(global-auto-revert-mode t)                  ; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(delete-selection-mode t)                    ; 选中文本后输入文本会替换文本（更符合我们习惯了的其它编辑器的逻辑）
(setq inhibit-startup-message t)             ; 关闭启动 Emacs 时的欢迎界面
(setq make-backup-files nil)                 ; 关闭文件自动备份
(add-hook 'prog-mode-hook #'hs-minor-mode)   ; 编程模式下，可以折叠代码块

(global-linum-mode t)
;(global-display-line-numbers-mode)         ; 在 Window 显示行号
(tool-bar-mode 0)                           ; （熟练后可选）关闭 Tool bar
(menu-bar-mode 0)
;(when (display-graphic-p) (toggle-scroll-bar -1)) ; 图形界面时关闭滚动条

(savehist-mode 1)                            ; （可选）打开 Buffer 历史记录保存
(setq display-line-numbers-type 'relative)   ; （可选）显示相对行号
(add-to-list 'default-frame-alist '(width . 90))  ; （可选）设定启动图形界面时的初始 Frame 宽度（字符数）
;(add-to-list 'default-frame-alist '(height . 55)) ; （可选）设定启动图形界面时的初始 Frame 高度（字符数）

;(custom-set-variables '(default-input-method "chinese-array30"))

(setq make-backup-files t)                           ;  配置备份文件位置
(setq kept-old-versions 2)
(setq kept-new-versions 2)
(setq delete-old-versions t)
(setq backup-directory-alist '(("" . "~/.emacsbackup")))

(setq tab-width 4)
(set-variable 'python-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)

;(setq python-indent-guess-indent-offset t)
;(setq python-indent-guess-indent-offset-verbose nil)

;;setup jedi
;(jedi:setup)
;(setup jedi:complete-on-dot t)

;(require 'package)                                  ;   配置库文件
;(add-to-list 'package-archives
;	 '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3") ; 不加这一句可能有问题，建议读者尝试一下
(setq url-proxy-services '(("no_proxy" . "^\\(192\\.168\\..*\\)")
                           ("http" . "127.0.0.1:7890")
			   ("https" . "127.0.0.1:7890")))

;;(setq package-check-signature nil)
;;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;;(require 'package)
;;(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;(package-initialize) 

;; (defvar myPackages
;;   '(better-defaults
;;     elpy
;;     material-theme))

;; (require 'elpy)
;; (elpy-enable)
;; (setq elpy-shell-use-project-root nil)

(eval-when-compile
  (require 'use-package))

;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/setchez")
(require 'chezinit)
(add-to-list 'load-path "~/.emacs.d/setexwm")
(require 'setexwm)
;;;;;;;;;;;;;;;;;

;(require 'pyim)
;(require 'pyim-basedict)
;(pyim-basedict-enable)
;(setq default-input-method "pyim")

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c '") 'comment-or-uncomment-region) ; 为选中的代码加注释/去注释

(defun next-ten-lines()
  "Move cursor to next 10 lines."
  (interactive)
  (next-line 10))

(defun previous-ten-lines()
  "Move cursor to previous 10 lines."
  (interactive)
  (previous-line 10))
;; 绑定到快捷键
(global-set-key (kbd "M-n") 'next-ten-lines)            ; 光标向下移动 10 行
(global-set-key (kbd "M-p") 'previous-ten-lines)        ; 光标向上移动 10 行

(global-set-key (kbd "C-j") nil)
;; 删去光标所在行（在图形界面时可以用 "C-S-<DEL>"，终端常会拦截这个按法)
(global-set-key (kbd "C-j C-k") 'kill-whole-line)

;(setq package-check-signature nil)

(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  :bind
  (("C-s" . 'swiper)            ;意味不名
   ("C-x b" . 'ivy-switch-buffer)
   ("C-c v" . 'ivy-push-view)
   ("C-c s" . 'ivy-switch-view)
   ("C-c V" . 'ivy-pop-view)
   ("C-x C-@" . 'counsel-mark-ring); 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
   ("C-x C-SPC" . 'counsel-mark-ring)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

(use-package ivy
  :ensure t)

;; ---- 执行了一个函数启动 ivy mode ----
(ivy-mode)
;; ---- 设置两个变量为 True，还有一个可选的 ---
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(use-package ivy
 :ensure t                          ; 确认安装，如果没有安装过 ivy 就自动安装    
 :config                            ; 在加载插件后执行一些命令
 (ivy-mode 1)                       ; 加载后启动 ivy-mode
 (setq ivy-use-virtual-buffers t)   ; 一些官网提供的固定配置
 (setq ivy-count-format "(%d/%d) ") 
 :bind                              ; 以下为绑定快捷键
 ("C-s" . 'swiper-isearch)          ; 绑定快捷键 C-s 为 swiper-search，替换原本的搜索功能
 ("M-x" . 'counsel-M-x)             ; 使用 counsel 替换命令输入，给予更多提示
 ("C-x C-f" . 'counsel-find-file)   ; 使用 counsel 做文件打开操作，给予更多提示
 ("M-y" . 'counsel-yank-pop)        ; 使用 counsel 做历史剪贴板粘贴，可以展示历史
 ("C-x b" . 'ivy-switch-buffer)     ; 使用 ivy 做 buffer 切换，给予更多提示
 ("C-c v" . 'ivy-push-view)         ; 记录当前 buffer 的信息
 ("C-c s" . 'ivy-switch-view)       ; 切换到记录过的 buffer 位置
 ("C-c V" . 'ivy-pop-view)          ; 移除 buffer 记录
 ("C-x C-SPC" . 'counsel-mark-ring) ; 使用 counsel 记录 mark 的位置
;  ("<f1> f" . 'counsel-describe-function)
;  ("<f1> v" . 'counsel-describe-variable)
;  ("<f1> i" . 'counsel-info-lookup-symbol)
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(geiser-chez paredit exwm-edit exwm-float exwm-mff exwm-modeline exwm-surf exwm-x helm-exwm perspective-exwm chatgpt-shell auctex buffer-move moom epc helm-w3m w3m all-the-icons elpy lsp-pyright lsp-mode dap-mode pyvenv company which-key good-scroll undo-tree ace-window amx flycheck ivy use-package))
 '(warning-suppress-log-types
   '((comp)
	 (comp)
	 (emacs)
	 (emacs)
	 (use-package)
	 (use-package)))
 '(warning-suppress-types '((comp) (emacs) (emacs) (use-package) (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package flycheck
  :ensure t
  :hook                        ; 为模式设置 hook
  (prog-mode . flycheck-mode))

(use-package amx
  :ensure t
  :init (amx-mode))           ;记录搜索历史

(use-package ace-window
  :ensure t
  :bind (("C-x o" . 'ace-window)))    ;;标记窗口编号

(use-package undo-tree    ;;;历史记录树
  :ensure t
  :init (global-undo-tree-mode))

;; (use-package good-scroll
;;   :ensure t
;;   :if window-system          ; 在图形化界面时才使用这个插件
;;   :init (good-scroll-mode))

(use-package which-key                    ;命令提示
  :ensure t
  :init (which-key-mode))

(use-package company                    ;;自动补全
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

(use-package flycheck                    ;;语法检查
  :ensure t
  :config
  (setq truncate-lines nil) ; 如果单行信息很长会自动换行
  :hook
  (prog-mode . flycheck-mode))

(use-package all-the-icons    ;;字符和图标？
  :ensure t)

;; (use-package lsp-mode          ;;代码分析lsp
;;   :ensure t
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l"
;; 	lsp-file-watch-threshold 500)
;;   :hook 
;;   (lsp-mode . lsp-enable-which-key-integration) ; which-key integration
;;   :commands (lsp lsp-deferred)
;;   :config
;;   (setq lsp-completion-provider :none) ;; 阻止 lsp 重新设置 company-backend 而覆盖我们 yasnippet 的设置
;;   (setq lsp-headerline-breadcrumb-enable t)
;;   :bind
;;   ("C-c l s" . lsp-ivy-workspace-symbol)) ;; 可快速搜索工作区内的符号（类名、函数名、变量名等）

(use-package python                    ;;python管理
  :defer t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python3" . python-mode)
  :config
  ;; for debug
  ;;(require 'dap-python)
 )

(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" (expand-file-name "~/.virtualenvs"))
  ;;(setenv "WORKON_HOME" (expand-file-name "~/miniconda3/envs"))
  ;; (setq python-shell-interpreter "python3")  ; （可选）更改解释器名字
  (pyvenv-mode t)
  ;; （可选）如果希望启动后激活 miniconda 的 base 环境，就使用如下的 hook
  ;; :hook
  ;; (python-mode . (lambda () (pyvenv-workon "..")))
  )

;;(use-package moom
;;  :ensure t
;;  :init (moom-mode 1)
  ;;:config
  ;;(setenv "WORKON_HOME" (expand-file-name "~/.virtualenvs"))
;;  )

(use-package buffer-move    ;;;窗口移动
  :ensure t
  :bind
  ("<C-S-up>" . buf-move-up)
  ("<C-S-down>" . buf-move-down)
  ("<C-S-left>" . buf-move-left)
  ("<C-S-right>" . buf-move-right))

(use-package elpy
  :ensure t
  :defer t
  :init
  (elpy-enable)
  (advice-add 'python-mode :before 'elpy-enable)
  :hook
  (elpy-mode . flycheck-mode)
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))

;; (use-package treemacs                          ;工作区
;;   :ensure t
;;   :defer t
;;   :config
;;   (treemacs-tag-follow-mode)
;;   :bind
;;   (:map global-map
;;         ("M-0"       . treemacs-select-window)
;;         ("C-x t 1"   . treemacs-delete-other-windows)
;;         ("C-x t t"   . treemacs)
;;         ("C-x t B"   . treemacs-bookmark)
;;         ;; ("C-x t C-t" . treemacs-find-file)
;;         ("C-x t M-t" . treemacs-find-tag))
;;   (:map treemacs-mode-map
;; 	("/" . treemacs-advanced-helpful-hydra)))

;; (use-package treemacs-projectile
;;   :ensure t
;;   :after (treemacs projectile))

;; (use-package lsp-treemacs
;;   :ensure t
;;   :after (treemacs lsp))

(use-package chatgpt-shell
  :ensure t
  :custom
  ((chatgpt-shell-openai-key
    "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")))

(use-package tex
  :ensure auctex
  :config
  (setq TeX-global-PDF-mode t TeX-engine 'xetex)
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX"))

	
;; (use-package w3m
;;  :ensure t
;;  :config
;;  (require 'w3m-load)
;;  (require 'mime-w3m)) 

(require 'w3m)

(setq w3m-command "/usr/bin/w3m")
(setq w3m-use-cookies t)
(setq w3m-home-page "https://emacs-w3m.github.io/index.html")
```
; (setq w3m-home-page "http://www.bing.com"))

;;(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")

;;(require 'eaf)

;; (require 'eaf-markdown-previewer)
;; (require 'eaf-rss-reader)
;; (require 'eaf-pdf-viewer)
;; (require 'eaf-image-viewer)
;; (require 'eaf-browser)
;; (setq eaf-proxy-type "http")
;; ;(setq eaf-proxy-type "https")
;; (setq eaf-proxy-host "127.0.0.1")
;; (setq eaf-proxy-port "7890")
;; (require 'eaf-org-previewer)
;; (require 'eaf-mindmap)
;; (require 'eaf-org)
;; (require 'eaf-demo)
;; (require 'eaf-file-manager)
;; (require 'eaf-terminal)
;;; (require 'eaf-system-monitor)
;; (defun eaf-org-open-file (file &optional link)
;;  "An wrapper function on `eaf-open'."
;;  (eaf-open file))
;;;;请使用 M-x eaf-org-export-to-pdf-and-open
;;;; use `emacs-application-framework' to open PDF file: link
;; (add-to-list 'org-file-apps '("\\.pdf\\'" . eaf-org-open-file))


 (require 'eaf-evil)


(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
  ;; :init
  ;; (use-package epc :defer t :ensure t)
  ;; (use-package ctable :defer t :ensure t)
  ;; (use-package deferred :defer t :ensure t)
  ;; (use-package s :defer t :ensure t)
  :custom
  ; See https://github.com/emacs-eaf/emacs-application-framework/wiki/Customization
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  :config
 ;  (require 'eaf-markdown-previewer)
 ;  (require 'eaf-rss-reader)
   (require 'eaf-demo)
   (require 'eaf-vue-demo)
   (require 'eaf-browser)
   (require 'eaf-pdf-viewer)
   (require 'eaf-image-viewer)
;   (require 'eaf-vedieo-viewer)
   (require 'eaf-js-video-player)
   (require 'eaf-music-player)
   (setq eaf-proxy-type "http")
   (setq eaf-proxy-host "127.0.0.1")
   (setq eaf-proxy-port "7890")
 ;  (require 'eaf-org-previewer)
 ;  (require 'eaf-mindmap)
 ;  (require 'eaf-org)
   (require 'eaf-file-manager)
   (require 'eaf-terminal)
   (require 'eaf-pyqterminal)
   (require 'eaf-2048)
 (require 'eaf-system-monitor)
 (require 'eaf-file-browser)
 (require 'eaf-file-sender)
 (defun eaf-org-open-file (file &optional link)
  "An wrapper function on `eaf-open'."
  (eaf-open file))
  (add-to-list 'org-file-apps '("\\.pdf\\'" . eaf-org-open-file))
  (defalias 'browse-web #'eaf-open-browser)
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding))
;  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
;  (eaf-bind-key nil "M-q" eaf-browser-keybinding)) ;; unbind, see more in the Wiki


;  (require 'eaf-browser)
;  (require 'eaf-pdf-viewer)
;  (require 'eaf-pdf-demo)
;  (require 'eaf-demo)
;  (require 'eaf-file-manager)
;  (require 'eaf-terminal)
;  (require 'eaf-2048)


(provide 'init)

;;; init.el ends here
		
