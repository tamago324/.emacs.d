(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; 追加
(add-to-load-path "elisp" "conf" "public_repos" "site-elisp")


;; package.el を使ってパッケージ管理
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("org"   . "http://orgmode.org/elpa/")))

;; 初期化
(package-initialize)
(package-refresh-contents)

(when (not (package-installed-p 'use-package))
  package-install 'use-package)
(require 'use-package)
;; (require 'use-package-ensure)
;; (setq use-package-always-ensure t)

(use-package quelpa
  :ensure t)

(use-package quelpa-use-package
  :ensure t)

;; (setq use-package-ensure-function 'quelpa)
;; (setq use-package-always-ensure t)

;; theme
(use-package doom-themes
  :ensure t
  :config
  ;; イタリックは使わない
  (load-theme 'doom-dracula t)
  (setq doom-themes-enable-italic -1)
  (set-face-attribute 'isearch nil :foreground "#ffb86c" :background "#ffbb66"))


;; 日本語の設定
;;  ロケールの設定
(set-language-environment "Japanese")
;;  優先順位を高くする
(prefer-coding-system 'utf-8)

;; ファイル名の扱いを正しくできるようにする
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))


(setq default-frame-alist
      (append (list
               '(font . "Cica:10.5"))
              default-frame-alist))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-company-use-tng nil)
 '(package-selected-packages
   (quote
    (evil-goggles treemacs-evil treemacs helm request gitignore-mode gitignore-templates evil-magit magit auto-yasnippet yasnippet-snippets ivy-ghq origami helpful lispyville lispy evil-traces evil-embrace evil-commentary evil-lion evil-matchit evil-matchhit evil-anzu evil-visualstar evil-collection evil spaceline spaceline-config powerline company-yasnippet format-all emacs-format-all-the-code quickrun volatile-highlights beacon company-quickhelp all-the-icons-ivy-rich expand-region which-key paredit popup google-translate-default-ui google-translate hydra all-the-icons-ivy smartparens doom-themes counsel evil-nerd-commenter undohist ivy-prescient prescient ivy use-package)))
 '(quickrun-focus-p nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ivy-minibuffer-match-face-1 ((((class color) (background dark)) :foreground "#bd93f9"))))


;; ==================
;; mappings

;; C-h -> backspace
(keyboard-translate ?\C-h ?\C-?)

;; C-x ? -> help command
(global-set-key (kbd "C-x ?") 'help-command)

;; ;; 改行と同時にインデントする
;; (global-set-key (kbd "C-m") 'newline-and-indent)

;; ;; C-t -> C-x o ウィンドウをぐるぐる
;; (global-set-key (kbd "C-t") 'other-window)

;; (global-set-key (kbd "C-c C-s") 'save-buffer)

;;(global-set-key (kbd "C-c h i") 'info)
;; (global-set-key (kbd "C-c h k") 'describe-key)

;; (global-set-key (kbd "M-p") 'backward-paragraph)
;; (global-set-key (kbd "M-n") 'forward-paragraph)

;; (global-set-key (kbd "C-c C-w C-k") 'windowmove-up)
;; (global-set-key (kbd "C-c C-w C-j") 'windowmove-down)
;; (global-set-key (kbd "C-c C-w C-h") 'windowmove-left)
;; (global-set-key (kbd "C-c C-w C-l") 'windowmove-right)
;; (global-set-key (kbd "C-c C-w x") 'split-window-below)
;; (global-set-key (kbd "C-c C-w v") 'split-window-right)
;; (global-set-key (kbd "C-c C-w d") 'ace-delete-window)


;; ;; 選択範囲をインデント
;; (global-set-key (kbd "M-=") 'indent-region)

;; ;; モードラインにカラムも表示する
;; (column-number-mode t)

;; 行番号を表示しない
(line-number-mode 0)

;; メニューバー消す
(menu-bar-mode -1)

(tool-bar-mode -1)

(scroll-bar-mode -1)

;; カッコを強調
;; -> mic-paren を使うようにした
;;   -> evil 使うようにした TODO: face をいい感じにする
(show-paren-mode t)

;; カーソル点滅をなくす
(blink-cursor-mode -1)

;; 透過
(defun set-alpha (alpha-num)
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))
(set-alpha 95)

;; 単語での折返しにする
;;(global-visual-line-mode 1)

;; (global-hl-line-mode nil)

;; 末尾とか表示する
;;(global-whitespace-mode t)

;; trailing 行末の空白文字
;; tabs-mark タブ文字
;; newline-mark 改行
;; space-mark
;;(setq whitespace-style '(trailing tabs-mark newline-mark space-mark))

;; ;; カーソルを棒二する
;; ;; -> なんか微妙...
;; (add-to-list 'default-frame-alist '(cursor-type . bar))

;; タブ文字の設定
(setq-default tab-width 4)

;; インデントにタブを使わない
(setq-default indent-tabs-mode nil)

;; バックアップファイルの作成場所を変更
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

;; オートセーブファイルの作成場所を変更
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; アラートを消す
(setq ring-bell-function 'ignore)


;; スクロールするとき、１行ずつ
(setq scroll-conservatively 1000)

;; スクロールしたとき、カーソルはスクリーン上、移動しない
(setq scroll-preserve-screen-position 1)

;; scroll-off
(setq scroll-margin 5)

;; ;; 矩形選択 C-RET で開始
;; (cua-mode t)
;; ;; C-x とかのマッピングを書き換えない
;; (setq cua-enable-cua-keys nil)

(setq lazy-highlight-initial-delay 0)

;; ====
;; elisp のマニュアルを日本語化
;; ===

;; Info-directory-list はドキュメントファイルを格納するディレクトリのリスト
(add-to-list 'Info-directory-list "~/.emacs.d/info/")
(defun Info-find-node--info-ja (orig-fn filename &rest args)
  (apply orig-fn
         (pcase filename
           ;; elisp を elisp-ja.info に置き換える
           ("elisp" "elisp-ja")
           ("emacs" "emacs-ja")
           (t filename))
         args))
(advice-add 'Info-find-node :around 'Info-find-node--info-ja)


;; =========
;; package
;; =========


;; ----
;; ivy
;; ----
(use-package ivy
  :ensure t
  ;; 常に ivy を使えるようにする
  :config

  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d)"
        ivy-height 25)

  ;; 一番下で C-n をしたら、上に戻る
  (setq ivy-wrap t)

  ;; 初期モードはfuzzy (M-r で切替可能)
  ;; ぞれぞれで設定可能
  ;; t がその他って意味
  (setq ivy-re-builders-alist
        '((councel-find-file . ivy--regex-fuzzy)
          (ivy-switch-buffer . ivy--regex-fuzzy)
          (t                 . ivy-prescient-re-builde)))

  ;; "^" とか入力しておきたかったら、設定する
  (setq ivy-initial-inputs-alist
        '(()
          (counsel-M-x . "^")
          ))

  ;; TODO: これ、なんとかならないかな
  ;; 見た目の設定
  (custom-set-faces
   '(ivy-minibuffer-match-face-1
     ((((class color) (background dark)) :foreground "#ff79c6"))))

  :bind
  (("M-x" . counsel-M-x)
   ;; ("C-x C-f" . counsel-find-file)
   ("M-y" . counsel-yank-pop)
   ;; ("C-c C-b" . ivy-switch-buffer)
   ;; ("C-c r". ivy-resume)
   )
  )


(use-package ivy-hydra
  :ensure t)

(use-package prescient
  :ensure t)

;;  いい感じにソートしてくれる
(use-package ivy-prescient
  :ensure t
  :config
  (ivy-prescient-mode t)
  ;; こっちを使う
  (setq ivy-prescient--old-initial-inputs-alist
        '(())))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :ensure t
  :init (ivy-rich-mode 1))

;; ---
;; mruf
;; https://masutaka.net/chalow/2011-10-30-2.html
;; ---
(use-package recentf
  :config
  (setq recentf-save-file "~/.emacs.d/.recentf")  ;; 保存先
  (setq recentf-max-saved-items 100)             ;; 保存数
  (setq recentf-exclude '(".recentf"))            ;; .recentf 自体は含めない
  (setq recentf-auto-cleanup 'never)              ;; 自動で履歴を消さないようにする
  ;; (run-with-idle-timer 10 t 'recentf-save-list)    ;; 30 秒ごとにファイルを保存
  )

;; smartparen
;; (require 'smartparens)
;; デフォルトの設定を読み込む
(use-package smartparens
  :ensure t
  :hook
  (python-mode . smartparens-mode)
  :config)


;; ;; スムーズなスクロール
;; (use-package sublimity-scroll
;;   :config
;;   (sublimity-mode 1)
;;   ;; 設定
;;   (setq shublimity-scroll-weight 5
;;         sublimity-scroll-drift-length 10)
;;   (setq sublimity-scroll-vertical-frame-delay 0.01))


;; ;; indent-guide
;; (use-package indent-guide
;;   :ensure t
;;   :config
;;   (indent-guide-global-mode)
;;   ;; コメントの色と同じにする
;;   (set-face-foreground 'indent-guide-face "#8995ba"))

;; ;; 自動で保存
;; ;; ウィンドウを移動した時
;; (use-package super-save
;;   :config
;;   (super-save-mode t)
;;   (setq super-save-auto-save-when-idle t))

;; かっこいいモードライン！
(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1))



;; (use-package nyan-mode
;;   :config
;;   (nyan-mode t))

(use-package company
  :ensure t
  :config
  (global-company-mode)

  (setq company-idle-delay 0.2              ;; すぐに補完
        company-minimum-prefix-length 2     ;; 2文字で補完開始
        company-selection-wrap-around t     ;; 一番下にいいったら、上に戻る
        completion-ignore-case t            ;; 大文字小文字無視
        ;;company-dabbrev-downcase t          ;; TODO: なんだろこれ
        )

  ;; TODO: なんだろこれ
  (push '(company-capf :with company-dabbrev) company-backends)
  (setq company-dabbrev-char-regexp "\\sw\\|_\\|-\\|!\\|\\?\\|*\\|+")

  (defvar company-mode/enable-yas t)

  ;; XXX: すべてのbackend で yasnippet を使えるようにする
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  ;; すべてのbackends で回す
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

  :bind
  ;; (;;("M-/" . company-complete)
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ;; タブで選hfe択
        ("C-i" . company-complete-selection)
        ;; 改行で選択はしない
        ("RET" . nil)
        ([return] . nil)))

;; https://github.com/MatthewZMD/.emacs.d#org073dc04
(use-package company-box
  :ensure t
  :hook
  ;; company-mode になったときに、 company-box-mode を実行する
  (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons)

  ;; https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-company.el
  (with-no-warnings
    ;; Prettify icons
    (defun my-company-box-icons--elisp (candidate)
      (when (derived-mode-p 'emacs-lisp-mode)
        (let ((sym (intern candidate)))
          (cond ((fboundp sym) 'Function)
                ((featurep sym) 'Module)
                ((facep sym) 'Color)
                ((boundp sym) 'Variable)
                ((symbolp sym) 'Text)
                (t . nil)))))
    (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp))

  (declare-function all-the-icons-faicon 'all-the-icons)
  (declare-function all-the-icons-material 'all-the-icons)
  (declare-function all-the-icons-octicon 'all-the-icons)
  (setq company-box-icons-all-the-icons
        `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.8 :v-adjust -0.15))
          (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.02))
          (Method . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
          (Function . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
          (Constructor . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
          (Field . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
          (Variable . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
          (Class . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
          (Interface . ,(all-the-icons-material "share" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
          (Module . ,(all-the-icons-material "view_module" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
          (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.02))
          (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.8 :v-adjust -0.15))
          (Value . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
          (Enum . ,(all-the-icons-material "storage" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
          (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.8 :v-adjust -0.15))
          (Snippet . ,(all-the-icons-material "format_align_center" :height 0.8 :v-adjust -0.15))
          (Color . ,(all-the-icons-material "palette" :height 0.8 :v-adjust -0.15))
          (File . ,(all-the-icons-faicon "file-o" :height 0.8 :v-adjust -0.02))
          (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.8 :v-adjust -0.15))
          (Folder . ,(all-the-icons-faicon "folder-open" :height 0.8 :v-adjust -0.02))
          (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15))
          (Constant . ,(all-the-icons-faicon "square-o" :height 0.8 :v-adjust -0.1))
          (Struct . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
          (Event . ,(all-the-icons-octicon "zap" :height 0.8 :v-adjust 0 :face 'all-the-icons-orange))
          (Operator . ,(all-the-icons-material "control_point" :height 0.8 :v-adjust -0.15))
          (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.02))
          (Template . ,(all-the-icons-material "format_align_left" :height 0.8 :v-adjust -0.15)))
        company-box-icons-alist 'company-box-icons-all-the-icons))

(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode))


;; いい感じにソートしてくれる
(use-package company-prescient
  :ensure t
  :config
  (company-prescient-mode t))

(use-package company-jedi
  :ensure t
  :hook
  (python-mode jedi:setup)
  :config
  ;;(add-hook 'python-mode-hook 'jedi:setup)
  ;; . で補完開始
  (setq jedi:complete-on-dot t)
  ;; M-. で定義元に移動
  ;; M-, で最後に飛んだところに飛ぶ？ XXX: わからん
  (setq jedi:use-shortcuts t)
  (defun my/enable-company-jedi ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/enable-company-jedi))

;; Removed: なんかやだ
(use-package anzu
  :ensure t
  :config
  (global-anzu-mode t)
  (setq anzu--overflow-p t))

;; Removed: evil で足りるから
;; (use-package move-text
;;   :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :config
  ;; プログラミングモードで有効化
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; ファイルを閉じても undo できるようにする
(use-package undohist
  :ensure t
  :config
  (undohist-initialize))


;; Removed: evil で足りるから
;; (use-package ace-window
;;   :ensure t
;;   :config
;;   (global-set-key (kbd "M-o") 'ace-window))

;; TODO: 使う
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

;; (use-package auto-yasnippet
;;   :ensure t)


;;
(use-package hydra
  :ensure t
  :config

  ;; (defhydra hydra-zoom (global-map "<f2>")
  ;;   "zoom"
  ;;   ("g" text-scale-increase)
  ;;   ("l" text-scale-decrease))

  (defhydra hydra-move-text (global-map "C-c m")
    "move text"
    ("k" move-text-up "up")
    ("j" move-text-down "down"))


  ;; helpful が必要
  (bind-key
   "C-c h"
   (defhydra hydra-ivy-help (:hint nil :exit t)
     "
   _f_: callable   _l_: libray   _s_: symbol   _C_: command
   _v_: variable   _i_: info     _k_: key      _F_: function"
     ("f" counsel-describe-function)
     ("l" counsel-find-library)
     ("s" counsel-describe-symbol)
     ("v" counsel-describe-variable)
     ("i" info)
     ("k" helpful-key)
     ("C" helpful-command)
     ("F" helpful-function)))

  ;; ;; https://github.com/ganesh-krishnan/emacs_config/blob/fdc8417b6597445d62a3cf7d86509e5bda102e78/hydras.el#L5
  ;; (bind-key
  ;;  "C-w"
  ;;  (defhydra hydra-window (:hint nil :exit t)
  ;;    "
  ;; _k_: ↑   _x_: horizontal
  ;; _j_: ↓   _s_: vertical
  ;; _h_: ←
  ;; _l_: →"
  ;;    ("k" windmove-up :exit -1)
  ;;    ("j" windmove-down :exit -1)
  ;;    ("h" windmove-left :exit -1)
  ;;    ("l" windmove-right :exit -1)
  ;;    ("x" split-window-below)
  ;;    ("s" split-window-right)
  ;;    ("d" delete-window))
  ;;  )

  (bind-key
   "C-c C-e"
   (defhydra hydra-expand-region ()
     "expand-region"
     ("C-k" er/expand-region "expand")
     ("k" er/expand-region "expand")
     ("C-j" er/contract-region "contract")
     ("j"   er/contract-region "contract"))))

;; todo
(use-package quickrun
  :ensure t
  :custom
  ;; フォーカスを移さない
  (quickrun-focus-p nil))

;; TODO:
;; (use-package hl-todo
;;   :ensure t
;;   :config
;;   (hl-todo-mode)
;;   )


;; Removed: evil-commentary を使うため
;; ;; M-; でコメント、コメントアウト
;; (use-package evil-nerd-commenter
;;   :ensure t
;;   :after evil
;;   :config
;;   (evil-define-key 'visual (kbd "C-j") 'evilnc-comment-or-uncomment-lines)
;;   )


;; インデントを常に整える
(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode t))

;; Removed: show-paren-mode でいいため
;; 対応するカッコをハイライト
;; (use-package mic-paren
;;   :ensure t
;;   :config
;;   (paren-activate)
;;   (set-face-background 'paren-face-match "#44475a")
;;   (set-face-foreground 'paren-face-match "#bd93f9"))


(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-mode))


(use-package google-translate
  :ensure t
  :config
  (setq google-translate-default-source-language "en"
        google-translate-default-target-language "ja"
        google-translate-output-destination "echo-area")
  )

(use-package google-translate-smooth-ui)

(use-package popup
  :ensure t)


;; Removed: lispy を使うため
(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook (after-init . which-key-mode))


;; TODO
(use-package expand-region
  :ensure t)


(use-package all-the-icons
  :ensure t)

;; Removed: うっとおしいから
;; ;; カーソル移動をハイライト
;; (use-package beacon
;;   :ensure t
;;   :custom
;;   (beacon-color "#ffff88")
;;   :config
;;   (beacon-mode 1))

;; Removed: なんかうまく使えていない？
;; ;; ヤンク下と事をハイライト
;; (use-package volatile-highlights
;;   :ensure t
;;   :config
;;   (volatile-highlights-mode t))

;; TODO
(use-package dumb-jump
  :ensure t
  :disabled)


(use-package format-all
  :ensure t
  :bind
  (("C-c C-l" . format-all-buffer)))

;; Removed: いらん
;; ;; https://github.com/manateelazycat/delete-block
;; (use-package delete-block
;;   :load-path (lambda () (expand-file-name "site-elisp/delete-block"))
;;   :bind
;;   (("M-d"           . delete-block-forward)
;;    ("C-<backspace>" . delete-block-backward)
;;    ("M-<backspace>" . delete-block-backward)
;;    ("M-DEL"         . delete-block-backward)))
;; (put 'narrow-to-region 'disabled nil)
;; (put 'dired-find-alternate-file 'disabled nil)


;; Removed: なんか重い -> doom-modeline
;; ;; modeline
;; ;; https://github.com/domtronn/all-the-icons.el/wiki/Spaceline
;; (use-package spaceline
;;   :ensure t)
;; (use-package spaceline-config
;;   :config
;;   (spaceline-emacs-theme))
;; (use-package powerline
;;   :ensure t
;;   :after spaceline-config)


(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        ;; C-d でスクロール
        evil-want-C-d-scroll t
        ;; C-u でスクロール
        evil-want-C-u-scroll t
        ;; C-d で削除
        evil-want-C-u-delete t
        ;; visual モードで貼り付けても、kill-ring に追加しない
        evil-kill-on-visual-paste t
        ;; カレントバッファのみハイライトする
        evil-ex-interactive-search-highlight 'selected-window)
  :config
  (evil-mode t)
  ;; カーソルの形を変える
  (setq evil-default-cursor 'box
        evil-insert-state-cursor 'bar
        ;; ;; ちょっとかわいい
        ;; evil-visual-state-cursor 'hollow
        ;; TODO: 検索結果をハイライト
        evil-ex-search-persistent-highlight t)

  (evil-select-search-module 'evil-search-module 'evil-search)

  ;; leader をスペースにする
  (evil-set-leader '(normal visual) (kbd "<SPC>"))
  ;; local-leader
  ;; (evil-set-leader '(normal visual) (kbd ",") t)

  ;; key-binding
  (evil-define-key 'visual 'global (kbd "<leader>h") 'evil-first-non-blank)
  (evil-define-key 'normal 'global (kbd "<leader>h") 'evil-first-non-blank)
  (evil-define-key 'normal 'global (kbd "<leader>l") 'evil-end-of-line)
  ;; 改行を含めない
  (evil-define-key 'visual 'global (kbd "<leader>l") (lambda ()
                                                       (interactive)
                                                       (evil-end-of-line)))

  (evil-define-key 'normal 'global (kbd "<leader>w") 'evil-write)
  (evil-define-key 'normal 'global (kbd "<leader>q") 'evil-quit)

  (evil-define-key 'normal 'global "s" 'evil-window-map)

  (evil-define-key 'normal 'global (kbd "C-k") 'evil-backward-paragraph)
  (evil-define-key 'normal 'global (kbd "C-j") 'evil-forward-paragraph)
  (evil-define-key 'visual 'global (kbd "C-k") 'evil-backward-paragraph)
  (evil-define-key 'visual 'global (kbd "C-j") 'evil-forward-paragraph)

  ;; emacs のキーバインディングを使う
  (evil-define-key 'insert 'global (kbd "C-a") nil)
  (evil-define-key 'insert 'global (kbd "C-b") nil)
  (evil-define-key 'insert 'global (kbd "C-e") nil)
  (evil-define-key 'insert 'global (kbd "C-b") nil)

  ;; なんか不安定
  ;; (evil-define-key 'insert company-active-map (kbd "C-n") 'company-select-next)
  ;; (evil-define-key 'insert company-active-map (kbd "C-p") 'company-select-previous)
  ;; (evil-define-key 'insert company-active-map (kbd "C-i") 'company-complete-selection)
  (evil-define-key 'insert company-active-map (kbd "C-n") nil)
  (evil-define-key 'insert company-active-map (kbd "C-p") nil)
  (evil-define-key 'insert company-active-map (kbd "C-i") nil)
  ;; (evil-define-key 'insert company-active-map (kbd "C-m") 'newline-and-indent)

  (evil-define-key 'normal 'global (kbd "<leader>fj") 'ivy-switch-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>f;") 'ivy-resume)

  ;; buffer とか recentf とか
  ;; (evil-define-key 'normal 'global (kbd "<leader>fj") 'helm-for-files)


  (evil-define-key 'normal 'global (kbd "<leader>fd") 'dired-jump-other-window)
  (evil-define-key 'normal 'global
    (kbd "<leader>ff") 'counsel-git
    (kbd "<leader>fg") 'counsel-rg
    (kbd "<leader>ft") 'counsel-major
    ;; 検索
    (kbd "<leader>bs") 'counsel-search
    )

  (evil-define-key 'normal 'global (kbd "C-c C-l") 'evil-ex-nohighlight)

  (evil-define-key 'normal 'global (kbd "<leader>rr") 'quickrun)
  (evil-define-key 'visual 'global (kbd "<leader>rr") 'quickrun-region)

  (evil-define-key 'insert 'global (kbd "C-j") 'company-yasnippet)

  ;; K で呼び出す関数
  (setq evil-lookup-func 'helpful-at-point))

;; counsel-searcha で使うため
(use-package request
  :ensure t)

(use-package evil-collection
  :ensure t
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  (evil-collection-company-use-tng nil)
  :config
  (evil-collection-init)

  ;;;;;;;;;;;;;;;;;;
  ;; ivy
  ;;;;;;;;;;;;;;;;;;
  ;; https://oremacs.com/swiper/#key-bindings
  (evil-define-key 'insert ivy-minibuffer-map
    (kbd "C-j") 'ivy-next-line
    (kbd "C-k") 'ivy-previous-line
    (kbd "C-l") 'ivy-alt-done
    (kbd "C-n") 'ivy-next-history-element
    (kbd "C-p") 'ivy-previous-history-element
    (kbd "C-i") 'evil-normal-state)
  (evil-define-key 'normal ivy-minibuffer-map
    (kbd "gg") 'ivy-beginning-of-buffer
    (kbd "G") 'ivy-end-of-buffer
    (kbd "C-b") 'ivy-scroll-down-command
    (kbd "C-u") 'ivy-scroll-down-command
    (kbd "C-f") 'ivy-scroll-up-command
    (kbd "C-d") 'ivy-scroll-up-command
    (kbd "q") 'exit-minibuffer)

  (evil-define-key 'normal 'global (kbd "C-/") 'swiper))


(use-package evil-visualstar
  :ensure t
  :after evil
  :config
  (evil-visualstar-mode)
  (evil-define-key 'visual 'global (kbd "*") 'evil-visualstar/begin-search-forward))

(use-package evil-matchit
  :ensure t
  :after evil
  :config
  (global-evil-matchit-mode t))


(use-package evil-goggles
  :ensure t
  :after evil
  :config
  (evil-goggles-mode)
  (custom-set-faces
   '(evil-goggles-yank-face ((t (:inherit 'shadow))))))


;; TODO:
;; (use-package evil-lion
;;   :ensure t
;;   :after evil
;;   :config
;;   (evil-lion-mode))


(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode))

;; とりあえず、surround を使うべきなのかも？
;; (use-package evil-embrace
;;   :ensure t
;;   :after evil
;;   :config
;;   (define-key evil-normal-state (kbd ";") #'embrace-commander)
;;   (evil-embrace-enable-evil-surround-integration))

;; TODO:
;; (use-package evil-surround
;;   :ensure t)

;; 視覚化
(use-package evil-traces
  :ensure t
  :config
  (evil-traces-mode))

(use-package evil-anzu
  :ensure t
  :after evil)


(use-package lispy
  :ensure t
  :hook
  ((lisp-mode . lispy-mode)
   (emacs-lisp-mode . lispy-mode))
  :config
  ;; "hello|" で " をおすと "hello"| になる
  (setq lispy-close-quotes-at-end-p t)
  ;; lispy-mode が ON なら、smartparens を OFF にする
  (add-hook 'lispy-mode-hook #'turn-off-smartparens-mode))

(use-package lispyville
  :ensure t
  :hook
  ;; lispy-mode が ON になったら lispyville-mode も ON にする
  (lispy-mode . lispyville-mode)
  :init
  ;; テーマという概念で設定を行う
  ;;  -> https://github.com/noctuid/lispyville

  ;; from doom-emacs
  ;; (setq lispyville-key-theme
  ;;       '((operators normal)
  ;;         c-w
  ;;         (prettify insert)
  ;;         (atom-movement normal visual)
  ;;         slurp/barf-lispy
  ;;         additional
  ;;         additional-insert))

  ;; 自分で必要そうなのを選んだ
  (setq lispyville-key-theme
        '(c-w
          c-u
          text-objects
          slurp/barf-lispy
          wrap
          additional-insert
          (operators normal)))

  (lispyville-set-key-theme))


(use-package helpful
  :ensure t
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  )


;; TODO: うまく有効化できなかった
;; (use-package origami
;;   :ensure t
;;   :hook
;;   ((emacs-lisp-mode . origami-mode)))


;; https://github.com/analyticd/ivy-ghq
(use-package ivy-ghq
  :quelpa
  (ivy-ghq :fetcher github :repo "analyticd/ivy-ghq")
  :config
  (setq ivy-ghq-short-list t))

(use-package magit
  :ensure t
  :config
  (use-package evil
    :config
    (evil-define-key 'normal 'global (kbd "<leader>gs") 'magit-status)))

;; TODO: key binding をおぼえる
(use-package evil-magit
  :ensure t)

(use-package gitignore-mode
  :ensure t)

(use-package gitignore-templates
  :ensure t)


;; XXX: dired を使ってみたいから
;; (use-package treemacs
;;   :ensure t)

;; XXX: dired を使ってみたいから
;; (use-package treemacs-evil
;;   :ensure t
;;   :after treemacs evil)
