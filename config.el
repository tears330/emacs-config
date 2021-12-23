;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Zz"
      user-mail-address "tears330@gmail.com"
      css-indent-offset 2
      js2-basic-offset 2
      js-switch-indent-offset 2
      js-indent-level 2
      js2-mode-show-parse-errors nil
      js2-mode-show-strict-warnings nil
      web-mode-attr-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-markup-indent-offset 2
      web-mode-enable-current-element-highlight t
      web-mode-enable-current-column-highlight t
      )

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

(setq doom-font (font-spec :family "Fira Code" :size 16)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 16)
      )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Transform markdown
(use-package! org-pandoc-import :after org)

;; Jest
(use-package! jest)

;; Use prettier to format js|ts|css|html file
(use-package! prettier-js)

(defun maybe-use-prettier ()
  "Enable prettier-js-mode if an rc file is located."
  (if (locate-dominating-file default-directory ".prettierrc")
      (prettier-js-mode +1)))

(add-hook 'typescript-mode-hook 'maybe-use-prettier)
(add-hook 'js2-mode-hook 'maybe-use-prettier)
(add-hook 'web-mode-hook 'maybe-use-prettier)
(add-hook 'rjsx-mode-hook 'maybe-use-prettier)


(use-package! visual-fill-column)

;; org-mode
(use-package! valign
  :custom
  (valign-fancy-bar t)
  :hook
  (org-mode . valign-mode))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(defun set-org-image-width () (setq org-image-actual-width 300))

(add-hook 'org-mode-hook 'set-org-image-width)

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks t
        org-appear-autoentities t
        org-appear-autokeywords t)
  )


(use-package! org-fancy-priorities
  :diminish
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list
        '("🅰" "🅱" "🅲" "🅳" "🅴")))

;; Auto Start LSP
(use-package! lsp-mode
  :hook ((web-mode . lsp)
         (rjsx-mode . lsp)
         (typescript-mode . lsp)
         (vue-mode . lsp)
         (python-mode . lsp)
         (go-mode . lsp)
         (css-mode . lsp)
         (js2-mode . lsp)
         (bibtex-mode . lsp)
         (tex-mode . lsp)
         (latex-mode . lsp))
  :commands lsp
  :config
  (add-to-list 'lsp-language-id-configuration '(json-mode . "jsonc"))
  (setq lsp-idle-delay 0.2
        lsp-enable-file-watchers nil
        +format-with-lsp nil)
  )

;; Config LSP UI
(use-package! lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-headerline-breadcrumb-enable t ; 左上角显示文件路径
        lsp-lens-enable t                  ; 显示被引用次数
        )
  )

;; Pyim Dict
(use-package! pyim-greatdict)

;; Org Outline
(use-package! org-ol-tree
  :commands org-ol-tree)

(map! :map org-mode-map
      :after org
      :localleader
      :desc "outline" "O" #'org-ol-tree)

;; Add Private GitLab Address For browse-at-remote
(use-package! browse-at-remote
  :config
  (setq
   browse-at-remote-remote-type-regexps '(("^github\\.com$" . "github")
                                          ("^bitbucket\\.org$" ."bitbucket")
                                          ("^gitlab\\.qima-inc\\.com$" . "gitlab")
                                          ("^git\\.savannah\\.gnu\\.org$" . "gnu")
                                          ("^gist\\.github\\.com$" . "gist")
                                          ("^git\\.sr\\.ht$" . "sourcehut")
                                          ("^.*\\.visualstudio\\.com$" . "ado")
                                          ("^pagure\\.io$" . "pagure")
                                          ("^.*\\.fedoraproject\\.org$" . "pagure")
                                          ("^.*\\.googlesource\\.com$" . "gitiles"))
   ))

;; Treemacs Custom Settings
(after! treemacs
  (setq
   evil-treemacs-state-cursor 'box
   treemacs-project-follow-cleanup t
   treemacs-width 30
   )
  (treemacs-follow-mode +1)
  )

;; DAP
(after! dap-mode
  (dap-register-debug-template "Node::Attach" (
                                               list :type "node"
                                               :request "attach"
                                               :port 9229
                                               :program "__ignored"
                                               :name "Debug Attach NodeJs Server"
                                               ))
  )

;; ;; Popweb
;; (use-package! popweb)
;; 
;; (use-package popweb-dict-bing
;;   :defer t
;;   :commands (popweb-dict-bing-input popweb-dict-bing-pointer)
;;   ) ; Translation using Bing
;; 
;; (use-package popweb-dict-youdao
;;   :defer t
;;   :commands (popweb-dict-youdao-input popweb-dict-youdao-pointer)
;;   ) ; Translation using Youdao

;; EAF
(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  ; See https://Github.com/emacs-eaf/emacs-application-framework/wiki/Customization
  (eaf--mac-enable-rosetta t)
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  :config
  (defalias 'browse-web #'eaf-open-browser)
  ;; (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  ;; (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  ;; (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  ;; (eaf-bind-key nil "M-q" eaf-browser-keybinding)
  )

(require 'eaf-browser)
;; (require 'eaf-demo)
;; (require 'eaf-pdf-viewer)
;; (require 'eaf-org-previewer)
(require 'eaf-evil)

(define-key key-translation-map (kbd "SPC")
    (lambda (prompt)
      (if (derived-mode-p 'eaf-mode)
          (pcase eaf--buffer-app-name
            ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
                           (kbd "SPC")
                         (kbd eaf-evil-leader-key)))
            ;; ("pdf-viewer" (kbd eaf-evil-leader-key))
            ;; ("image-viewer" (kbd eaf-evil-leader-key))
            (_  (kbd "SPC")))
        (kbd "SPC"))))


