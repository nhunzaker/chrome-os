;;; init.el --- My emacs config
;;; Code:
;;; Commentary:

;; -------------------------------------------------------------------
;; [1] Setup
;; [2] UI Prelude
;; [3] Package Management
;; [4] Utility Functions
;; [5] Editor Customization
;; [6] Key Bindings
;; [7] Modes
;; -------------------------------------------------------------------

;; [1] Setup
;; -------------------------------------------------------------------

(defvar nh-dir (file-name-directory load-file-name)
  "The root dir for Nate's Emacs config.")

(defvar nh-savefile-dir (expand-file-name "savefiles" nh-dir))

(defvar nh-shell "fish")

;; Have packages installed by Homebrew added to your load-path:
(when (equal window-system "darwin")
  (let ((default-directory "/usr/local/share/emacs/site-lisp/"))
    (normal-top-level-add-subdirs-to-load-path)))

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; [2] UI Prelude ----------------------------------------------------

;; Hide all extra UI
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (scroll-bar-mode -1))

;; Silence is golden
(defun startup-echo-area-message() "")

(setq
 inhibit-startup-screen t
 inhibit-startup-message t
 inhibit-startup-echo-area-message t
 initial-scratch-message ""
 startup-screen-inhibit-startup-screen t
 show-help-function nil
 visible-bell -1
 ring-bell-function 'ignore
 linum-format "  %2d  ")

(setq-default line-spacing 4)
(set-frame-font "Dank Mono 12" t t)

(if (string= window-system "darwin")
    (defvar ns-use-proxy-icon nil))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'gloomy-night t)

(setq-default
 mode-line-format (list
                   " " mode-line-buffer-identification " %l:%c %6 "
                   mode-line-misc-info
                   mode-line-end-spaces))

;; Set the spacing around frames
;; http://emacsredux.com/blog/2015/01/18/customizing-the-fringes/
(when (window-system) (fringe-mode '(16 . 16)))

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; [3] Package Management
;; -------------------------------------------------------------------

(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(setq-default
 package-user-dir (expand-file-name "elpa" nh-dir)
 use-package-always-ensure t
 ;; Set this to true to debug use-package
 use-package-verbose nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defun package--save-selected-packages (&rest opt)
  "Prevent package management from appending selected packages.  No OPT."
  nil)

(require 'use-package)
(require 'bind-key)

;; [4] Utility Functions
;; -------------------------------------------------------------------

(defun emacs-config ()
  "Open Emacs config file."
  (interactive)
  (find-file (expand-file-name "init.el" nh-dir)))

(defun nh-decrease-by-one ()
  "Given the point is at a number, decrease it by one."
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1- (string-to-number (match-string 0))))))

(defun nh-increase-by-one ()
  "Given the point is at a number, increase it by one."
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun nh-recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  (byte-recompile-directory nh-dir 0))

(defun nh-rename-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun nh-split-horizontal ()
  "Split the window horizontally below and move to it."
  (interactive)
  (split-window-below)
  (windmove-down))

(defun nh-split-vertical ()
  "Split the current window vertically to the right  and move to it."
  (interactive)
  (split-window-right)
  (windmove-right))

(defun nh/today-as-string ()
  "Today, as a string."
  (format-time-string "%y.%m.%d"))

(defun current-workbook ()
  "Location of the current workbook log file."
  (concat "~/.org/worklog/" (nh/today-as-string) ".org"))

(defun workbook ()
  "Opens up Nate's work log."
  (interactive)
  (find-file (current-workbook))
  (when (not (file-exists-p (current-workbook)))
    (insert-before-markers
     (concat "#+TITLE: " (format-time-string "%B %d, %Y")) "\n" "#+STARTUP: content\n")))

(defun shift-left (&optional arg)
  "Shift the line or region to the ARG places to the left."
  (interactive)
  (shift-right (* -1 (or arg 1))))

(defun shift-right (&optional arg)
  "Shift the line or region to the ARG places to the right.
A place is considered `tab-width' character columns."
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning))
                 (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position))))
    (indent-rigidly beg end (* (or arg 1) tab-width))))

(defun what-face (position)
  "Get the face value for the current `POSITION'."
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" position))))


(defun buffer-ext ()
  (file-name-extension (buffer-name)))

;; ChromeOS exposes a BROWSER environment variable to the Linux
;; Container
(when (getenv "BROWSER")
  (setq browse-url-generic-program
        (executable-find (getenv "BROWSER"))
        browse-url-browser-function 'browse-url-generic))

;; [4] Editor Customization
;; -------------------------------------------------------------------

;; No blinking
(blink-cursor-mode -1)

(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

(add-to-list 'default-frame-alist
             '(ns-appearance . light))

(setq-default
 indent-tabs-mode nil
 tab-width 2
 js-indent-level 2
 require-final-newline t
 next-line-add-newlines t)

;; Do not wrap lines
;; https://www.emacswiki.org/emacs/TruncateLines
(set-default 'truncate-lines t)

;; Delete Selection mode makes Emacs treat text selection like other apps
;; https://www.emacswiki.org/emacs/DeleteSelectionMode
(delete-selection-mode t)

;; Meaningful names for buffers with the same name
(setq
 uniquify-buffer-name-style 'forward
 uniquify-separator "/"
 uniquify-after-kill-buffer-p t ;; rename after killing uniquified
 uniquify-ignore-buffers-re "^\\*") ;; don't muck with special buffers

;; Use shift + arrow keys to switch between visible buffers
(use-package windmove
  :defer t)

;; Enable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

(use-package undo-tree
  :config (global-undo-tree-mode)
  :bind (("C-S-u" . undo-tree-visualize)
         ("C-z" . undo-tree-undo)
         ("C-S-z" . undo-tree-redo)))

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defun nh-auto-save-command ()
  "Save the current buffer if `nh-auto-save' is not nil."
  (when (and buffer-file-name
             (buffer-modified-p (current-buffer))
             (file-writable-p buffer-file-name))
    (save-buffer)))

(defmacro advise-commands (advice-name commands &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.  The body of the advice is in BODY."
  `(progn
     ,@(mapcar (lambda (command)
                 `(defadvice ,command (before ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                    ,@body))
               commands)))

;; advise all window switching functions
(advise-commands "auto-save"
                 (switch-to-buffer other-window)
                 (nh-auto-save-command))

;; Only need exec-path-from-shell on OSX this hopefully sets up path
;; and other vars better
;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :if window-system
  :config
  (setq-default exec-path-from-shell-check-startup-files nil
                exec-path-from-shell-shell-name nh-shell)
  (exec-path-from-shell-initialize))

(use-package multiple-cursors
  :bind (("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)))

(use-package all-the-icons :defer t)

(use-package neotree
  :defer t
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :bind (("C-\\" . neotree-toggle)))

(use-package move-text
  :config
  :bind (("C-<up>" . move-text-up)
         ("C-<down>" . move-text-down)))

;; [5] Key Bindings
;; -------------------------------------------------------------------

(global-set-key (kbd "C-x O") 'nh-next-window)
(global-set-key [remap kill-whole-line] 'kill-whole-line)
(global-set-key (kbd "M-k") 'kill-this-buffer)
(global-set-key (kbd "C-v") 'yank)
(global-set-key [(meta l)] 'goto-line)
(global-set-key [(meta \,)] 'emacs-config)
(global-set-key [(meta <)] 'workbook)
(global-set-key [(control =)] 'text-scale-increase)
(global-set-key [(control -)] 'text-scale-decrease)
(global-set-key (kbd "C-c r") 'nh-rename-file-and-buffer)
(global-set-key (kbd "C-x 2") 'nh-split-horizontal)
(global-set-key (kbd "C-x 3") 'nh-split-vertical)
(global-set-key (kbd "M-a") 'mark-whole-buffer)

;; [6] Modes
;; -------------------------------------------------------------------

;; - General Programming ---------------------------------------------

(defun nh/prog-mode ()
  (whitespace-mode -1)
  (electric-pair-mode -1)
  (global-auto-revert-mode))

(add-hook 'prog-mode 'nh/prog-mode)

(use-package rainbow-mode
  :defer t)

(add-hook 'before-save-hook 'whitespace-cleanup)

(use-package whitespace-cleanup-mode
  :defer t
  :hook 'prog-mode)

(use-package smartparens
  :defer t
  :hook (prog-mode . smartparens-global-mode))

(use-package paren
  :init
  (setq show-paren-style 'parenthesis)
  :hook (prog-mode . show-paren-mode))

;; Code formatting

(use-package prettier-js
  :defer t
  :bind (("C-M-l" . nh/format-code)))

(defun nh/format-code ()
  "Format the current buffer according to file extension."
  (interactive)
  (let ((ext (buffer-ext)))
    (cond ((string= ext "js") (prettier-js))
          ((string= ext "jsx") (prettier-js))
          ((string= ext "ts") (prettier-js))
          ((string= ext "tsx") (prettier-js))
          ((string= ext "css") (prettier-js))
          ((string= ext "scss") (prettier-js))
          ((string= ext "md") (prettier-js))
          ((string= ext "gql") (prettier-js))
          ((string= ext "json") (json-mode-beautify))
          ((string= (buffer-name) ".babelrc") (json-mode-beautify))
          (t (message "No formatter for %s" ext))
          )))

;; - Org Mode --------------------------------------------------------

(use-package org
  :defer t
  :mode ("\\.org$" . org-mode)
  :init
  (setq-default org-directory "~/.org"
                org-agenda-files '("~/.org/worklog" "~/.org/projects")
                org-agenda-timegrid-use-ampm 1
                org-log-done t
                org-archive-location "~/.org/archive"
                org-timer-default-timer 25)
  :config
  (setq org-todo-keywords
        '((sequence "TODO" "DOING" "|" "DONE" "CANCELLED" "REASSIGNED"))))



;; - Shell Mode ------------------------------------------------------

(setq-default sh-basic-offset tab-width
              sh-indentation tab-width
              smie-indent-basic tab-width)

;; Make a shell script executable automatically on save
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; - Elixir Mode -----------------------------------------------------

;;; https://github.com/elixir-lang/emacs-elixir
(use-package elixir-mode
  :mode "\\.ex$")

;; - Emacs Lisp ------------------------------------------------------

(use-package lisp-mode
  :ensure nil
  :bind (("M-<RET>" . eval-buffer)))

(defun nh/emacs-lisp-mode-hook ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))
            nil
            t))

(add-hook 'emacs-lisp-mode-hook 'nh/emacs-lisp-mode-hook)

;; - Flycheck --------------------------------------------------------

(use-package flycheck
  :defer t
  :config
  ;; Customize the output
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side            . bottom)
                 (reusable-frames . visible)
                 (window-height   . 0.20))))

;; - Git -------------------------------------------------------------

(with-eval-after-load 'magit-autorevert
  (defalias 'magit-auto-revert-buffers 'auto-revert-buffers)
  (magit-auto-revert-mode -1))

(use-package magit
  :defer t)

;; Additional Git Modes - https://github.com/magit/git-modes
(use-package gitignore-mode
  :mode "\\.gitignore$")

(use-package gitconfig-mode
  :mode "\\.gitconfig$")

;; - JSON ------------------------------------------------------------

(use-package json-mode
  :interpreter "node"
  :mode (("\\.json$" . json-mode)
         ("\\.babelrc$" . json-mode)
         ("\\.watchmanconfig$" . json-mode)
         ("\\.eslintrc$" . json-mode)))

;; - Markdown --------------------------------------------------------

(use-package markdown-mode
  :mode "\\.md$"
  :init
  ;; This has to come before markdown-mode loads
  (setq-default markdown-command "pretty-markdown"
                markdown-content-type "utf-8"
                markdown-fontify-code-blocks-natively t
                markdown-hide-urls t
                markdown-make-gfm-checkboxes-buttons t)
  (add-hook 'markdown-mode-hook 'nh/markdown-mode-hook))

(defun nh/markdown-mode-hook ()
  "My markdown mode hook."
  (local-unset-key [(meta left)])
  (local-unset-key [(meta right)])
  (toggle-truncate-lines -1)
  ;; Visual line mode line breaks on words without injecting new lines
  (visual-line-mode)
  ;; Don't automatically break at 80 chars
  (auto-fill-mode -1))

;; - Project management -------------------------------------------------

(use-package smex
  :config
  (setq smex-save-file (expand-file-name ".smex-items" nh-savefile-dir))
  (smex-initialize)
  :bind (("M-x" . smex)
         ("M-S-x" . smex-major-mode-commands)))

(use-package flx-ido :defer t)
(use-package ido-completing-read+ :defer t)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-save-directory-list-file (expand-file-name "ido.hist" nh-savefile-dir)
      ido-default-file-method 'selected-window
      ido-auto-merge-work-directories-length -1)
(ido-mode +1)
(ido-ubiquitous-mode +1)
(flx-ido-mode +1)
(setq ido-use-faces nil)

(use-package company
  :defer t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package projectile
  :config
  (setq projectile-indexing-method 'git)
  (projectile-register-project-type 'yarn '("package.json")
                                    :compile "yarn build"
                                    :test "yarn test"
                                    :run "yarn start"
                                    :test-suffix ".test")
  (projectile-mode)
  :bind (("M-t" . projectile-find-file)
         ("C-c p p" . projectile-switch-project)))

;; I pretty much only use this for helm-projectile-ack
(use-package helm-projectile
  :bind (("M-p" . helm-projectile-ack)))

;; - Ruby Mode -------------------------------------------------------

(use-package ruby-mode
  :interpreter "ruby"
  :mode (("Gemfile\\'" . ruby-mode)
         ("Rakefile\\'" . ruby-mode)
         ("Capfile\\'" . ruby-mode)
         ("Fastfile\\'" . ruby-mode)
         ("\\.rb\\'" . ruby-mode)
         ("\\.gemspec\\'" . ruby-mode)
         ("\\.ru\\'" . ruby-mode)
         ("\\.rake\\'" . ruby-mode)
         ("\\.jbuilder\\'" . ruby-mode)
         ("\\.arb\\'" . ruby-mode )))

; - CSS/Sass Mode --------------------------------------------------

(setq-default css-indent-offset tab-width)

(use-package sass-mode
  :mode (("\\.sass\\'" . sass-mode)))

;; - Terminals -------------------------------------------------------

(setq-default term-buffer-maximum-size 1000
              explicit-shell-file-name nh-shell)

(defun nh/term-fix-copy-paste()
  "Fixes copy and paste in terminals.  https://stackoverflow.com/a/40034387."
  (define-key term-raw-map (kbd "H-v") 'term-paste)
  (define-key term-raw-map (kbd "C-k")
    (lambda ()
      (interactive)
      (term-send-raw-string "\C-k")
      (kill-line))))

(add-hook 'term-mode-hook 'nh/term-fix-copy-paste)

;; - HTML, CSS, JS ---------------------------------------------------

(use-package web-mode
  :interpreter "node"
  :mode (;; HTML
         ("\\.html?\\'" . web-mode)
         ("\\.phtml\\'" . web-mode)
         ("\\.php\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.ejs\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.handlebars\\'" . web-mode)
         ("\\.hbs\\'" . web-mode)
         ("\\.swig\\'" . web-mode)
         ("\\.eex\\'" . web-mode)
         ;; CSS
         ("\\.css\\'" . web-mode)
         ("\\.scss\\'" . web-mode)
         ;; JS/TypeScript
         ("\\.js[x]?$" . web-mode)
         ("\\.ts[x]?$" . web-mode)
         ("\\.flow$" . web-mode))
  :config
  (setq web-mode-enable-auto-pairing t
        web-mode-enable-css-colorization nil
        web-mode-enable-comment-interpolation t
        web-mode-enable-current-element-highlight t
        web-mode-enable-block-face t
        web-mode-style-padding tab-width
        web-mode-script-padding tab-width
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-attr-indent-offset tab-width
        web-mode-code-indent-offset tab-width
        web-mode-enable-auto-indentation nil
        web-mode-content-types-alist '(("jsx" . "\\.ts[x]?") ("jsx" . "\\.js[x]?\\'") ("jsx" . "\\.flow?\\'")))
  (add-hook 'web-mode-hook 'nh/web-mode))


(defun nh/web-mode ()
  "Setup web mode."
  (electric-indent-mode t)
  (electric-layout-mode t)
  (turn-off-auto-fill)
  (subword-mode)
  (hs-minor-mode 1)
  (local-set-key [(control c) (control f)] 'hs-toggle-hiding)
  (local-set-key [(control c) (control s)] 'hs-toggle-hiding))

;; - Typescript ------------------------------------------------------

(defvar typescript-extensions '("ts" "tsx"))

(defun is-typescript-buffer ()
  (member (buffer-ext) typescript-extensions))

;; https://github.com/ananthakumaran/tide
(defun setup-tide-mode ()
  "Boot tide-mode according to docs."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(use-package tide
  :defer t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . setup-tide-mode)
         (web-mode . consider-typescript)))

(defun consider-typescript ()
  (when (is-typescript-buffer) (setup-tide-mode)))

;; - YAML ------------------------------------------------------------

(use-package yaml-mode
  :mode "\\.ya*ml$")

;; - GraphQL ---------------------------------------------------------

(use-package graphql-mode
  :mode "\\.gql$")

;; - Environment Variables -------------------------------------------

(use-package dotenv-mode
  :mode "\\.env")

;; -------------------------------------------------------------------
;; [END]
;; -------------------------------------------------------------------

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c209fd03633dcfcc657c3841aa398570e67c5384e8fc1e28c1d4cf84373a132d" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "a566448baba25f48e1833d86807b77876a899fc0c3d33394094cf267c970749f" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "b0e25bc2f52c0d9d92ee31ec8ec41485394595f81630f51a80cad65b695df4fe" "97b4e20a3ff65c7ccc066a68e0f49d312f230261a7679c64520ab861537f507d" "9900dbcf7e541381fff21660d8445acdb7c59a7770b45f4daedf292c8f81bf9c" "97b32bdff24946b0844f7aa4f860ae0751846ab3bbcc1f5ee8d7d74299e60187" "c2d05fd7f3b401562d6b955330ef84d04476440a00dbe5a279edff1a8f835215" "3c88a4ba1e283fd639964b805b3c5126146cb12a7f9c8a5d862a265c446ee485" "b2b081f1012f49407d7b38c50468507eb591f20eb5fcba259b614f996f293239" "2267b7ebf9e5264aa5cbfde1a13dab63041d42262f3e933bf3c44cc7b6305f90" "94c8b20b3930edbd325b0d70521fc486be9b2e7b449eb4564b6906dbe78c2680" "7717bacd2f45a64f104a1a9c2fd7009a780101910c108e43a57ec7381f2738a9" "465198f3eb98f62dda48cc3d045a65b0710c1a0cebaf393dc86c4d70ec43f496" default))))

;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
