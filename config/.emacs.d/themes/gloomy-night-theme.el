;;; gloomy-night-theme.el --- Custom face theme for Emacs
;;; Commentary:
;;; Author: Nathan Hunzaker
;;; URL: https://github.com/nhunzaker/gloomy-night-emacs
;;; Version: 0.0.1

;;; Code:
(deftheme gloomy-night
  "A cross-over of the Xcode Night and Atom Gloom themes")

(let ((base00 "#161727")
      (base01 (if (window-system) "#1C1D30" 'unspecified))
      (base02 "#C8DAEF")
      (base03 "#dd4400")
      (base04 "#ED4781")
      (base05 "#94F2E7")
      (base06 "#7AA5FF")
      (base07 "#726EA8")
      (base08 "#9DCBFF")
      (base09 "#AE81FF")
      (base10 "#FF6BB7")
      (base11 "#555599" )
      (base12 "#2DF0A7")
      (base13 "#EEAA22")
      (base14 "#a9f")
      (base15 "#E72D2D")
      (base16 "#333559"))

  (let ((background-color base01)
        (gutter-color base00)
        (text-color base02)
        (region-color base16)
        (focus-color base02)
        (constant-face base12)
        (comment-color base07)
        (highlight-color base13)
        (builtin-face base06)
        (link-color base06)
        (string-face base13)
        (type-face base10)
        (variable-color base06)
        (params-color base13)
        (function-color base02)
        (keyword-face base06)
        (warning-color base13)
        (error-color base15))

    (custom-theme-set-faces
     'gloomy-night

     ;; Basics
     `(cursor ((t (:background ,region-color, :foreground "#ffffff"))))
     `(default ((t (:background ,background-color :foreground ,text-color :weight light))))
     `(isearch ((t (:background "#5e384b" :foreground "#ffffff"))))
     `(isearch-fail ((t (:background unspecified :foreground ,error-color))))
     `(match ((t (:background ,focus-color :foreground unspecified))))
     `(menu ((t (:background ,text-color :foreground ,background-color))))
     `(region ((t (:background ,region-color :foreground unspecified))))
     `(warning ((t (:foreground ,warning-color))))
     `(button ((t (:foreground ,link-color))))
     `(link ((t (:underline t))))
     `(link-visited ((t (:underline t))))
     `(bold ((t :weight medium)))
     `(italic ((t :slant italic)))
     `(bold-italic ((t :inherit bold :inherit italic)))

     ;; Border above frames and table headings for flycheck
     `(header-line ((t (:background ,background-color :height 100))))

     ;; Highlights
     `(hl-line ((t :background unspecified, :foreground unspecified)))
     `(highlight ((t (:background unspecified :foreground ,highlight-color))))
     `(lazy-highlight ((t (:background unspecified :foreground ,text-color))))

     ;; Mouse
     `(mouse-face ((t (:background ,base01 :foreground ,highlight-color))))

     ;; Search
     `(match ((t (:background ,base01))))

     ;; The Border around the edge of the frame
     `(fringe ((t (:background unspecified :foreground unspecified))))
     `(vertical-border ((t (:background unspecified :foreground "#232641"))))
     `(linum ((t (:background ,gutter-color :foreground "#42487C" :height 100 :slant normal :underline nil))))

     `(font-lock-builtin-face ((t (:foreground ,builtin-face :weight normal))))
     `(font-lock-comment-face ((t (:foreground ,comment-color :slant italic))))
     `(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :foreground ,comment-color))))
     `(font-lock-constant-face ((t (:foreground ,constant-face))))
     `(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
     `(font-lock-error-face ((t (:background ,error-color :foreground ,background-color :weight normal))))
     `(font-lock-function-name-face ((t (:foreground ,function-color))))
     `(font-lock-keyword-face ((t (:foreground ,keyword-face :weight light :slant italic))))
     `(font-lock-preprocessor-face ((t (:foreground ,focus-color ))))
     `(font-lock-string-face ((t (:foreground ,string-face :weight light))))
     `(font-lock-type-face ((t (:foreground ,type-face))))
     `(font-lock-variable-name-face ((t (:foreground ,variable-color))))
     `(font-lock-warning-face ((t (:inherit 'warning))))

     ;; Interactively do things
     `(ido-first-match ((t (:foreground ,focus-color))))
     `(ido-subdir ((t (:foreground ,focus-color))))
     `(ido-indicator ((t (:background ,base03 :foreground ,highlight-color))))
     `(ido-only-match ((t (:foreground ,string-face))))

     ;; Menus
     `(info-index-match ((t (:background ,text-color :foreground ,background-color))))
     `(info-menu-star ((t (:foreground ,base03))))

     ;; When finding files, this highlights matching
     `(flx-highlight-face ((t (:foreground ,base06 :background unspecified))))

     ;; Makefile
     `(makefile-targets ((t (:foreground ,type-face))))

     ;; Flycheck
     `(flycheck-error ((t (:background "#aa3300" :bold nil))))
     `(flycheck-fringe-warning ((t (:foreground ,warning-color :bold t))))
     `(flycheck-fringe-error ((t (:foreground ,error-color :bold t))))
     `(flycheck-error-list-highlight ((t ( ))))
     `(flycheck-error-list-checker-name ((t (:foreground "#777") )))

     ;; Flyspell
     `(flyspell-incorrect ((t (:background unspecified :underline (:color ,base03 :style wave) :foreground unspecified))))
     `(flyspell-duplicate ((t (:background: unspecified :foreground unspecified :underline (:color ,base05 :style wave)))))

     ;; white-space mode
     `(whitespace-tab ((t (:background nil :foreground ,base01, :underline t))))
     `(whitespace-indentation ((t (:background nil :foreground ,base01 ))))
     `(whitespace-empty ((t (:background unspecified :foreground unspecified :underline t))))
     `(trailing-whitespace ((t (:background ,base03 :foreground ,base01))))
     `(whitespace-trailing ((t (:background ,base03 :foreground ,base01))))
     `(whitespace-line ((t (:background unspecified :foreground unspecified :underline t))))

     ;; YAML ;;
     ;;;;;;;;;
     `(yaml-tab-face ((t (:background ,base03 :foreground ,base01))))

     ;; CSS Mode ;;
     ;;;;;;;;;;;;;
     `(css-selector ((t (:foreground ,base04 ))))
     `(css-property ((t (:foreground ,base06 ))))
     `(css-proprietary-property ((t (:foreground ,text-color :italic t))))
     `(scss-variable-color ((t (:foreground ,base08))))
     `(scss-keyword-face ((t (:foreground ,keyword-face ))))

     ;; Markdown Mode ;;
     ;;;;;;;;;;;;;;;;;;
     `(markdown-header-face   ((t (:foreground ,base06))))
     `(markdown-header-face-1 ((t (:foreground ,base04))))
     `(markdown-header-face-2 ((t (:foreground ,base04))))
     `(markdown-header-face-3 ((t (:foreground ,base04))))
     `(markdown-header-face-4 ((t (:foreground ,base04))))
     `(markdown-header-face-5 ((t (:foreground ,base04))))
     `(markdown-header-face-6 ((t (:foreground ,base04))))
     `(markdown-bold-face  ((t (:foreground ,base04 :bold t))))
     `(markdown-blockquote-face  ((t (:foreground,comment-color :italic t))))
     `(markdown-pre-face  ((t (:foreground ,base12))))
     `(markdown-code-face ((t (:height: 100))))

     ;; ERC Mode ;;
     ;;;;;;;;;;;;;
     `(bg:erc-color-face0 ((t :background ,base02 :foreground ,background-color)))
     `(bg:erc-color-face1 ((t :background ,base01 :foreground ,text-color)))
     `(bg:erc-color-face3 ((t :background ,base02 :foreground ,background-color)))
     `(bg:erc-color-face4 ((t :background ,base03 :foreground ,background-color)))
     `(bg:erc-color-face5 ((t :background ,base04 :foreground ,background-color)))
     `(bg:erc-color-face6 ((t :background ,keyword-face :foreground ,background-color)))
     `(bg:erc-color-face7 ((t :background ,base04 :foreground ,background-color)))
     `(bg:erc-color-face8 ((t :background ,highlight-color :foreground ,background-color)))
     `(bg:erc-color-face9 ((t :background ,string-face :foreground ,background-color)))
     `(bg:erc-color-face10 ((t :background ,base02 :foreground ,text-color)))
     `(bg:erc-color-face11 ((t :background ,link-color :foreground ,background-color)))
     `(bg:erc-color-face12 ((t :background ,constant-face :foreground ,background-color)))
     `(bg:erc-color-face13 ((t :background ,keyword-face :foreground ,background-color)))
     `(bg:erc-color-face14 ((t :background ,focus-color :foreground ,text-color)))
     `(bg:erc-color-face15 ((t :background ,base02 :foreground ,background-color)))

     `(fg:erc-color-face0 ((t :foreground ,text-color)))
     `(fg:erc-color-face1 ((t :foreground ,base01)))
     `(fg:erc-color-face2 ((t :foreground ,constant-face)))
     `(fg:erc-color-face3 ((t :foreground ,string-face)))
     `(fg:erc-color-face4 ((t :foreground ,base03)))
     `(fg:erc-color-face5 ((t :foreground ,base07)))
     `(fg:erc-color-face6 ((t :foreground ,keyword-face)))
     `(fg:erc-color-face7 ((t :foreground ,base04)))
     `(fg:erc-color-face8 ((t :foreground ,highlight-color)))
     `(fg:erc-color-face9 ((t :foreground ,string-face)))
     `(fg:erc-color-face10 ((t :foreground ,text-color)))
     `(fg:erc-color-face11 ((t :foreground ,link-color)))
     `(fg:erc-color-face12 ((t :foreground ,constant-face)))
     `(fg:erc-color-face13 ((t :foreground ,base04)))
     `(fg:erc-color-face14 ((t :foreground ,text-color)))
     `(fg:erc-color-face15 ((t :foreground ,text-color)))

     `(erc-nick-msg-face ((t (:foreground ,base02))))
     `(erc-current-nick-face ((t (:foreground ,base04))))
     `(erc-direct-msg-face ((t (:foreground ,focus-color))))
     `(erc-default-face ((t (:foreground ,text-color))))
     `(erc-fool-face ((t (:foreground ,constant-face))))
     `(erc-command-indicator-face ((t (:foreground ,base04))))
     `(erc-notice-face ((t (:foreground ,comment-color))))
     `(erc-button ((t (:foreground ,link-color))))
     `(erc-prompt-face ((t (:foreground ,focus-color))))
     `(erc-dangerous-host-face ((t (:background ,error-color :foreground ,background-color :weight bold))))
     `(erc-error-face ((t (:foreground ,error-color :weight bold))))
     `(erc-inverse-face ((t (:background unspecified :foreground unspecified :weight bold))))
     `(erc-input-face ((t (:background unspecified :foreground ,text-color :weight bold))))
     `(erc-keyword-face ((t (:background unspecified :foreground ,string-face :weight bold))))
     `(erc-pal-face ((t (:background unspecified :foreground ,base04 :weight bold))))
     `(erc-timestamp-face ((t (:background unspecified :foreground ,string-face :weight bold))))
     `(erc-nick-default-face ((t (:foreground ,string-face :weight bold))))
     `(show-paren-match ((t (:background unspecified :foreground ,highlight-color :underline nil :weight normal))))
     `(show-paren-mismatch ((t (:background unspecified :foreground ,base13 :underline nil :weight bold))))

     ;; Web Mode ;;
     ;;;;;;;;;;;;;;
     `(web-mode-block-face ((t (:foreground ,text-color, :background unspecified ))))
     `(web-mode-block-delimiter-face ((t (:foreground ,base04, :background unspecified ))))
     `(web-mode-block-control-face ((t (:foreground ,base04, :background unspecified ))))
     `(web-mode-builtin-face ((t (:inherit font-lock-builtin-face))))
     `(web-mode-constant-face ((t (:inherit font-lock-constant-face))))
     `(web-mode-current-element-highlight-face ((t (:foreground ,base09 :background nil))))
     `(web-mode-current-column-highlight-face ((t (:foreground unspecified :background "#212144"))))
     `(web-mode-folded-face ((t (:foreground unspecified :underline t))))
     `(web-mode-html-attr-equal-face ((t (:foreground ,comment-color ))))
     `(web-mode-html-attr-name-face ((t (:foreground ,comment-color))))
     `(web-mode-html-attr-value-face ((t :inherit font-lock-string-face)))
     `(web-mode-html-tag-bracket-face ((t (:foreground ,base07))))
     `(web-mode-html-tag-face ((t (:foreground ,base14))))
     `(web-mode-keyword-face ((t (:inherit font-lock-keyword-face))))
     `(web-mode-preprocessor-face ((t (:inherit font-lock-preprocessor-face ))))
     `(web-mode-symbol-face ((t (:foreground ,base08 ))))
     `(web-mode-type-face ((t (:inherit font-lock-type-face ))))
     `(web-mode-variable-name-face ((t (:inherit font-lock-variable-color ))))
     `(web-mode-whitespace-face ((t (:foreground ,base03 :background: ,base03))))
     `(web-mode-css-selector-face ((t :inherit css-selector )))
     `(web-mode-css-property-name-face ((t :inherit css-property )))
     `(web-mode-css-pseudo-class-face ((t :foreground ,base08 :slant italic )))
     `(web-mode-css-variable-color ((t :inherit font-lock-variable-name-face )))
     `(web-mode-css-at-rule-face ((t :inherit font-lock-keyword-face )))
     `(web-mode-css-function-face ((t :inherit font-lock-variable-name-face )))
     `(web-mode-comment-keyword-face ((t :foreground ,base10  )))

     `(js2-external-variable ((t :foreground ,base12)))
     `(js2-warning ((t (:foreground unspecified :background unspecified :underline (:color ,base13 :style wave)))))
     `(js2-error ((t (:foreground unspecified :background unspecified :underline (:color "#402", :style wave)))))
     `(js2-function-param ((t (:foreground ,params-color))))

     `(js2-error ((t (:underline (:color ,warning-color :style wave )))))
     `(js2-function-call ((t :foreground ,text-color)))
     `(js2-jsdoc-tag ((t (:foreground ,base14 :italic t))))
     `(js2-jsdoc-type ((t (:foreground ,base14 :italic t))))
     `(js2-jsdoc-value ((t (:foreground ,base14 :italic t))))

     `(rjsx-tag ((t :inherit web-mode-html-tag-face)))
     `(rjsx-attr ((t :inherit web-mode-html-attr-name-face)))
     `(rjsx-text ((t :foreground ,text-color)))

     ;; multi-mark mode
     `(mc/master-face ((t (:inherit 'lazy-highlight))))
     `(mc/region-face ((t (:background ,highlight-color :foreground ,background-color))))

     ;; magit
     `(git-commit-summary ((t (:foreground ,base10 :slant italic :height 130))))
     `(git-commit-comment-branch-local ((t (:foreground ,base08 :slant italic))))
     `(git-commit-comment-heading ((t (:foreground ,base14 :slant italic))))
     `(magit-blame-date ((t (:foreground ,text-color))))
     `(magit-blame-hash ((t (:foreground ,text-color))))
     `(magit-blame-heading ((t (:foreground ,text-color))))
     `(magit-blame-name ((t (:foreground ,text-color))))
     `(magit-blame-summary ((t (:foreground ,text-color))))

     ;;misc
     `(ffap ((t (background: unspecified))))

     ;; org
     `(org-document-title ((t (:foreground ,base04))))
     `(org-todo ((t (:foreground ,base10 :slant italic))))
     `(org-done ((t (:foreground ,base12 :slant italic))))
     `(org-link ((t :underline t)))
     `(org-level-1 ((t (:foreground ,base02 :background unspecified :height unspecified))))
     `(org-level-2 ((t (:foreground ,base02 :background unspecified))))
     `(org-level-3 ((t (:foreground ,base02 :background unspecified))))
     `(org-level-4 ((t (:foreground ,base02 :background unspecified))))
     `(org-level-5 ((t (:foreground ,base02 :background unspecified))))
     `(org-level-6 ((t (:foreground ,base02 :background unspecified))))
     `(org-special-keyword ((t (:foreground ,base06))))
     `(org-scheduled-previously ((t (:foreground ,comment-color))))
     `(org-date ((t (:foreground ,base09))))
     `(org-agenda-date ((t (:foreground ,base06 :slant italic :height 140))))
     `(org-agenda-date-today ((t (:foreground ,highlight-color :slant italic :height 140))))
     `(org-time-grid ((t (:foreground ,comment-color :slant italic))))
     `(org-scheduled ((t (:height 120 :foreground ,comment-color))))
     `(org-agenda-done ((t (:slant italic :foreground ,base11))))
     `(org-scheduled-today ((t (:height 120 :foreground ,base02))))
     `(org-agenda-calendar-event ((t (:foreground ,base09 :height 120))))
     `(org-agenda-current-time ((t (:foreground ,highlight-color :slant italic))))
     `(org-mode-line-clock ((t (:background unspecified :foreground ,base02))))
     `(org-pomodoro-mode-line ((t (:background unspecified :foreground ,base13))))
     `(org-table ((t (:background unspecified :foreground ,base08))))

     ;; mode-line
     `(minibuffer-prompt ((t (:background unspecified :foreground ,base02))))
     `(mode-line-highlight ((t (:background ,base13))))
     `(mode-line-buffer-id ((t (:background unspecified :foreground unspecified))))
     `(mode-line-buffer-id-inactive ((t (:background unspecified :foreground unspecified))))
     `(mode-line-inactive ((t (:background ,background-color :foreground "#444466" :weight light :height 110 :box(:line-width 10 :color ,background-color)))))
     `(mode-line ((t (:inherit mode-line-inactive :background ,base00 :foreground "#bbbbcc" :box(:line-width 10 :color ,base00)))))

     ;; Elixir Mode
     `(elixir-attribute-face ((t (:foreground ,base14))))

     ;; JSDoc minor mode
     `(jsdoc-tags-face ((t (:foreground ,base14))))

     ;; Ocaml (taureg) mode
     `(tuareg-font-lock-governing-face ((t (:inherit ,font-lock-keyword-face))))

     ;; Compilation mode. I use this mostly with projectile
     `(compilation-error ((t (:foreground ,base04))))
     `(compilation-info ((t (:foreground ,base12))))
     `(compilation-line-number ((t (:foreground ,base04))))

     ;; Helm
     `(helm-selection ((t (:foreground ,base13))))
     `(helm-match ((t (:foreground ,base10))))
     `(helm-header ((t (:height 100))))
     `(helm-source-header ((t (:height 120))))
     `(helm-ff-dotted-directory ((t (:background nil :foreground ,base04))))
     `(helm-ff-dotted-symlink-directory ((t (:background nil :foreground ,base04))))
     `(helm-ff-executable ((t (:background nil :foreground ,base12))))
     `(helm-ff-directory ((t (:background nil :foreground ,base04))))
     `(helm-ff-invalid-symlink ((t (:background ,error-color :foreground ,base01))))
     `(helm-grep-finish ((t (:background nil :foreground ,base12))))
     `(helm-grep-lineno ((t (:background nil :foreground ,base04))))
     `(helm-buffer-directory ((t (:background nil :foreground ,base04))))
     `(helm-buffer-file ((t (:background nil :foreground ,base02 :height 100))))
     `(helm-ff-file ((t (:background nil :foreground ,base02 :height 110))))
     `(helm-grep-file ((t (:background nil :foreground ,comment-color))))
     `(helm-grep-lineno ((t (:background nil :foreground ,text-color))))
     `(helm-grep-match ((t (:background nil :foreground ,highlight-color))))

     ;; Company
     `(company-preview ((t (:background nil :foreground ,comment-color))))
     `(company-preview-common ((t (:background nil :foreground ,comment-color))))

     ;; Grizzl
     `(grizzl-selection-face ((t (:background nil :foreground ,highlight-color))))

     ;; Terminal
     `(term-color-black ((t (:foreground ,comment-color))))
     `(term-color-blue ((t (:foreground ,base10))))
     `(term-color-cyan ((t (:foreground ,base06))))
     `(term-color-green ((t (:foreground ,base12))))
     `(term-color-magenta ((t (:foreground ,base04))))
     `(term-color-red ((t (:foreground ,base03))))
     `(term-color-white ((t (:foreground ,base02))))
     `(term-color-yellow ((t (:foreground ,base13))))
     )))

;;;###autoload
(when load-file-name
  (add-to-list
   `custom-theme-load-path
   (file-name-as-directory (file-name-directory load-file-name))))

;;;###autoload
(defun gloomy-night-theme()
  "Load abyss-theme."
  (interactive)
  (load-theme 'gloomy-night t))

(provide-theme 'gloomy-night)

;;; gloomy-night-theme.el ends here
