;;; private/my/+ui.el -*- lexical-binding: t; -*-

(load-theme 'doom-one-light t)

(when (display-graphic-p)
  (cond (IS-MAC
         (setq doom-font (font-spec :family "Operator Mono Light" :size 14)
               doom-big-font (font-spec :family "Operator Mono Light" :size 20)
               doom-modeline-height 30))
        (IS-LINUX
         (setq resolution-factor (eval (/ (x-display-pixel-height) 1080.0)))
         (setq doom-font (font-spec :family "Operator Mono" :size (eval (round (* 16 resolution-factor))) :weight 'light)
               doom-big-font (font-spec :family "Operator Mono" :size (eval (round (* 22 resolution-factor))))
               doom-modeline-height (eval (round (* 32 resolution-factor))))))

  ;; set initl screen size
  (setq initial-frame-alist
        '((width . 90)
          (height . 50))))

(after! doom-modeline
  (setq doom-modeline-buffer-file-name-style 'relative-to-project
        doom-modeline-major-mode-icon t))

(setq +workspaces-on-switch-project-behavior t)

(remove-hook 'doom-init-ui-hook #'blink-cursor-mode)

;; disable line-numbers by default
;; (setq display-line-numbers-type nil)
(setq display-line-numbers-type t)

;; my custom faces
(custom-set-faces!
  '(variable-pitch :family nil)
  '(font-lock-doc-face :italic t)
  `(show-paren-match :background ,(doom-lighten (doom-color 'teal) 0.4) :foreground ,(doom-color 'base1))
  '(tide-hl-identifier-face :inherit 'lsp-face-highlight-read)
  `(breakpoint-enabled :background ,(doom-color 'red) :foreground "white")
  `(lsp-ui-peek-highlight :foreground "white")
  `(ivy-posframe-border :background ,(doom-color 'blue))
  `(magit-diff-file-heading :background ,(doom-lighten (doom-color 'blue) 0.5))
  `(magit-diff-file-heading-highlight :background ,(doom-lighten (doom-color 'blue) 0.2))
  '(markdown-header-face-1 :inherit 'org-level-1)
  '(markdown-header-face-2 :inherit 'org-level-2)
  '(markdown-header-face-3 :inherit 'org-level-3)
  `(web-mode-jsx-depth-1-face :background ,(doom-lighten (doom-color 'teal) 0.9))
  `(web-mode-jsx-depth-2-face :background ,(doom-lighten (doom-color 'teal) 0.8))
  `(web-mode-jsx-depth-3-face :background ,(doom-lighten (doom-color 'teal) 0.7))
  `(web-mode-jsx-depth-4-face :background ,(doom-lighten (doom-color 'teal) 0.6))
  `(web-mode-jsx-depth-5-face :background ,(doom-lighten (doom-color 'teal) 0.5))
  `(flyspell-incorrect :underline ,(doom-color 'red))
  `(flyspell-duplicate :underline ,(doom-color 'orange))
  '(flymake-warning :underline nil)
  '(flycheck-warning :underline nil)
  `(ein:cell-input-area :background ,(doom-lighten (doom-color 'red) 0.85))
  `(ein:cell-input-prompt :background ,(doom-color 'red) :foreground ,(doom-color 'base0) :bold t))

(custom-theme-set-faces! 'doom-city-lights
  `(hl-line :background ,(doom-color 'base0))
  `(magit-diff-file-heading-highlight :foreground ,(doom-color 'base0))
  `(magit-diff-file-heading :foreground ,(doom-color 'base4))
  ;; ediff
  `(ediff-current-diff-A :foreground ,(doom-color 'red)   :background ,(doom-darken (doom-color 'red) 0.8))
  `(ediff-current-diff-B :foreground ,(doom-color 'green) :background ,(doom-darken (doom-color 'green) 0.8))
  `(ediff-current-diff-C :foreground ,(doom-color 'blue)  :background ,(doom-darken (doom-color 'blue) 0.8))
  `(ediff-current-diff-Ancestor :foreground ,(doom-color 'teal)  :background ,(doom-darken (doom-color 'teal) 0.8))
  `(markdown-code-face :background ,(doom-color 'base2)))

;; for terminal
(unless (display-graphic-p)
  (custom-set-faces!
    `(font-lock-comment-face :foreground ,(doom-color 'base6))
    `(font-lock-doc-face :foreground ,(doom-color 'base6))))

(when IS-MAC
  ;; enable ligatures support
  ;; details here: https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
  (ignore-errors
    (mac-auto-operator-composition-mode)))

(after! ibuffer
  ;; set ibuffer name column width
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))

  (setq ibuffer-formats
        '((mark modified read-only " "
                (name 50 50 :left :nil) " "
                (size-h 9 -1 :right) " "
                (mode 16 16 :left :elide) " "
                filename-and-process))))

(add-hook! 'process-menu-mode-hook
  (setq-local tabulated-list-format [("Process" 30 t)
                                     ("PID"      7 t)
                                     ("Status"   7 t)
                                     ("Buffer"  15 t)
                                     ("TTY"     12 t)
                                     ("Command"  0 t)]))
