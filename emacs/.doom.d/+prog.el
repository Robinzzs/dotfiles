;;; ~/.doom.d/+prog.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPANY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! company
  ;; (setq company-idle-delay 0.1)
  (setq company-idle-delay 0
        company-minimum-prefix-length 1)
  )
(setq smartparens-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FLYCHECK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar cspell-base-program "cspell")
(defvar cspell-config-file-path (concat "'" (expand-file-name  "~/Dotfiles/misc/apps/.cspell.json") "'"))
(defvar cspell-args (string-join `("--config" ,cspell-config-file-path) " "))
(defun cspell-check-buffer ()
  (interactive)
  (if cspell-base-program
      (let* ((file-name (concat "'" (file-name-nondirectory (buffer-file-name)) "'"))
             (command (string-join `(,cspell-base-program ,cspell-args ,file-name) " ")))
        (compilation-start command 'grep-mode))
    (message "Cannot find cspell, please install with `npm install -g cspell`")
    ))

(defun cspell-check-HEAD ()
  (interactive)
  (if cspell-base-program
      (let* ((project-root (doom-project-root))
             (default-directory
               (if (string-match-p "av/detection" project-root)
                   (expand-file-name "~/av")
                 project-root))
             (command (string-join `("git diff --name-only HEAD | xargs -I{}" ,cspell-base-program ,cspell-args "'{}'") " ")))
        (compilation-start command 'grep-mode))
    (message "Cannot find cspell, please install with `npm install -g cspell`")))

;; (use-package! wucuo
;;   :defer t
;;   :init
;;   (add-hook! (js2-mode rjsx-mode go-mode c-mode c++-mode) #'wucuo-start))

;; (remove-hook! '(python-mode-hook tex-mode-hook) #'flyspell-mode)
;; (remove-hook! 'text-mode-hook #'flyspell-mode)
;; (remove-hook! 'prog-mode-hook #'flyspell-prog-mode)
;; (setq! flyspell-mode nil);
;; (setq! flyspell-prog-model nil)
;; (use-package! wucuo
;;   :defer t
;;   :init
;;   (add-hook! (text-mode-hook prog-mode-hook) #'wucuo-start))

(after! flycheck
  (setq-default flycheck-disabled-checkers
                '(
                  javascript-jshint handlebars
                  json-jsonlist json-python-json
                  c/c++-clang c/c++-cppcheck c/c++-gcc
                  python-pylint python-pycompile
                  ))

  ;; customize flycheck temp file prefix
  (setq-default flycheck-temp-prefix ".flycheck")

  ;; ======================== JS & TS ========================
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (after! tide
    (flycheck-add-next-checker 'javascript-eslint '(t . javascript-tide) 'append)
    (flycheck-add-next-checker 'javascript-eslint '(t . jsx-tide) 'append)
    (flycheck-add-next-checker 'typescript-tslint '(t .  typescript-tide) 'append)
    (flycheck-add-next-checker 'javascript-eslint '(t . tsx-tide) 'append))

  ;; ======================== Python ========================
  (require 'flycheck-mypy)

  ;; ======================== CC ========================
  (require 'flycheck-google-cpplint)
  (setq flycheck-c/c++-googlelint-executable "cpplint")
  (flycheck-add-next-checker 'c/c++-gcc '(t . c/c++-googlelint))

  ;; (setq flycheck-c/c++-gcc-executable "gcc-7"
  ;;       flycheck-gcc-include-path '("/usr/local/inclue"
  ;;                                   "/Users/robinzzs/madagascar/include/"))

  (setq flycheck-c/c++-clang-executable "clang"
        flycheck-clang-include-path '("/usr/include"
                                      "/usr/local/inclue"
                                      "/Users/robinzzs/madagascar/include/"))

  (add-hook! c++-mode-hook
    (setq flycheck-gcc-language-standard "c++11"
          flycheck-clang-language-standard "c++11"))
  )

(defun disable-flycheck-mode ()
  (flycheck-mode -1))
;; (add-hook! (emacs-lisp-mode) 'disable-flycheck-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! ccls
  (setq
   ccls-initialization-options
   '(:clang
     (:extraArgs
      ["-I/Users/robinzzs/madagascar/include"]))))

;; (after! ccls
;;   (cond ((string-equal system-type "darwin")
;;          (setq ccls-initialization-options
;;                '(:clang (:extraArgs
;;                          ["-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
;;                           "-isystem/usr/local/include"
;;                           "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/12.0.0/include"
;;                           "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include"
;;                           "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include"
;;                           "-isystem/Library/Developer/CommandLineTools/usr/include/c++/v1"
;;                           "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks"
;;                           "-I/Users/robinzzs/madagascar/include"]
;;                          :resourceDir "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/12.0.0")))
;;          ))
;;   (cond ((string-equal system-type "gnu/linux")
;;          (setq ccls-initialization-options
;;                '(:clang (:extraArgs
;;                          ["/usr/include/c++/8"
;;                           "/usr/include/c++/9"
;;                           "/usr/include/x86_64-linux-gnu/c++/8"
;;                           "/usr/include/x86_64-linux-gnu/c++/9"
;;                           "/usr/include/c++/8/backward"
;;                           "/usr/include/c++/9/backward"
;;                           "/usr/local/include"
;;                           "/usr/lib/llvm-7/lib/clang/7.0.1/include"
;;                           "/usr/lib/gcc/x86_64-linux-gnu/8/include/"
;;                           "/usr/lib/llvm-9/lib/clang/9.0.0/include"
;;                           "/usr/include/x86_64-linux-gnu"
;;                           "/usr/include"]
;;                          :resourceDir "/usr/lib/llvm-7/lib/clang/7.0.1")))
;;          ))
;; )

;; (setq! lsp-clients-clangd-args '("-j=4" "-background-" "-log=error"))

;; (use-package lsp-mode
;;   :config
;;   ;; `-background-index' requires clangd v8+!
;;   (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error" ))
;;   )

;; (setq
;;  ccls-initialization-options
;;  `(:clang
;;    (:extraArgs
;;     ["-isystem/usr/local/include"]
;;     :resourceDir "/Users/robinzzs/madagascar/include")))

;;   (setq ccls-sem-highlight-method 'font-lock)
;;   (ccls-use-default-rainbow-sem-highlight)
;;   (evil-set-initial-state 'ccls-tree-mode 'emacs))

(use-package! bazel-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("BUILD\\(\\.bazel\\)?\\'" . bazel-mode))
  (add-to-list 'auto-mode-alist '("WORKSPACE\\'" . bazel-mode))
  :config
  ;; disable format-all becuase it doesn't sort BUILD list variables
  (setq bazel-mode-buildifier-before-save t)
  (appendq! +format-on-save-enabled-modes '(bazel-mode)))

(add-to-list 'auto-mode-alist '("\\.inl\\'" . +cc-c-c++-objc-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . +cc-c-c++-objc-mode))

(after! cc-mode
  (c-add-style
   "my-cc" '("user"
             (c-basic-offset . 2)
             (c-offsets-alist
              . ((innamespace . 0)
                 (access-label . -)
                 (case-label . 0)
                 (member-init-intro . +)
                 (topmost-intro . 0)
                 (arglist-cont-nonempty . +)))))
  (setq c-default-style "my-cc")

  (setq-default c-basic-offset 2)

  ;; set default while cc-mode startup
  (setq lsp-enable-file-watchers  nil)
  )

;; add this config at 20200518 as lsp not auto init
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'format-all-mode)
(add-hook 'c++-mode-hook #'format-all-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PYTHON
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (define-derived-mode asl-mode
;;   python-mode "ARGO Schema Language Mode"
;;   "Major mode for asl file."
;;   (flycheck-mode -1))
;; (add-to-list 'auto-mode-alist '("\\.asl\\'" . asl-mode))

(after! python
  (setq python-indent-offset 4
        python-shell-interpreter "python3"
        pippel-python-command "python3"
        conda-env-home-directory (expand-file-name "~/.conda")
        importmagic-python-interpreter "python3"
        flycheck-python-pylint-executable "pylint"
        flycheck-python-flake8-executable "flake8")

  ;; if you use pyton2, then you could comment the following 2 lines
  ;; (setq python-shell-interpreter "python2"
  ;;       python-shell-interpreter-args "-i")

  ;; ignore some linting info
  (if (featurep! :tools lsp)
      (setq lsp-pyls-plugins-pycodestyle-ignore '("E501")
            lsp-pyls-plugins-pylint-args [ "--errors-only" ]))
  )

;; (use-package! lsp-python-ms
;;   :hook (python-mode . (lambda ()
;;                          (require 'lsp-python-ms)
;;                          (lsp-deferred)))
;;   :init
;;   (setq lsp-python-executable-cmd "python3")
;;   (setq lsp-python-ms-extra-paths '("/Users/robinzzs/madagascar/lib/python3.7/site-packages"))
;; )
;; Setup PYTHONPATH
;; (add-to-list 'python-shell-extra-pythonpaths (expand-file-name "/Users/robinzzs/madagascar/lib/python3.7/site-packages"))
;; Init MYPYPATH
;; (setenv "MYPYPATH" (concat (expand-file-name "/Users/robinzzs/madagascar/lib/python3.7/site-packages:")

;; for executable of language server, if it's not symlinked on your PATH
(setq lsp-python-ms-executable
      "~/project-otherrepos/python-language-server/output/bin/Release/osx-x64/publish/Microsoft.Python.LanguageServer")


(after! lsp-python-ms
  (setq lsp-python-ms-python-executable-cmd "python3"))

(use-package! py-isort
  :defer t
  :init
  (define-minor-mode python-isort-autosave-mode
    "Isort autosave mode."
    :lighter " Isort"
    :global nil
    (when (not (derived-mode-p 'python-mode))
      (error "Isort only works with Python buffers"))
    (if python-isort-autosave-mode
        (add-hook! 'before-save-hook #'py-isort-before-save nil t)
      (remove-hook! 'before-save-hook #'py-isort-before-save nil t)))

  (add-hook! 'python-mode-hook #'python-isort-autosave-mode))
;; (add-hook 'python-mode-hook #'format-all-mode)

;; (use-package! importmagic
;;   :defer t
;;   :hook (python-mode . importmagic-mode)
;;   :commands (importmagic-fix-imports importmagic-fix-symbol-at-point)
;;   :config
;;   (dolist (func '(importmagic-fix-imports importmagic-fix-symbol-at-point))
;;     (advice-add func :before #'revert-buffer-no-confirm)))


(after! pipenv
  (setq pipenv-with-projectile t)
  ;; Override pipenv--clean-response to trim color codes
  (defun pipenv--clean-response (response)
    "Clean up RESPONSE from shell command."
    (replace-regexp-in-string "\n\\[0m$" "" (s-chomp response)))

  ;; restart flycheck-mode after env activate and deactivate
  (dolist (func '(pipenv-activate pipenv-deactivate))
    (advice-add func :after #'reset-flycheck)))


(after! conda
  (when IS-LINUX
    ;; Ubuntu anaconda
    (setq conda-anaconda-home "~/anaconda3"))

  ;; restart flycheck-mode after env activate and deactivate
  (dolist (func '(conda-env-activate conda-env-deactivate))
    (advice-add func :after #'reset-flycheck)))

;; For pytest-mode
(set-evil-initial-state! '(comint-mode) 'normal)

;; For scons file
(setq auto-mode-alist
      (cons '("SConstruct" . python-mode) auto-mode-alist))

;; add this config at 20200518 as lsp not auto init
(add-hook 'python-mode-hook #'lsp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JS, WEB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (use-package! import-js
;;   :defer t
;;   :init
;;   (add-hook! (js2-mode rjsx-mode) (run-import-js))
;;   (add-hook! (js2-mode rjsx-mode)
;;     (add-hook 'after-save-hook #'import-js-fix nil t)))
;; (advice-add '+javascript|cleanup-tide-processes :after 'kill-import-js)


;; (after! web-mode
;;   (web-mode-toggle-current-element-highlight)
;;   (web-mode-dom-errors-show))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'lsp-latex)
;; (add-hook 'tex-mode-hook 'lsp)
;; (add-hook 'latex-mode-hook 'lsp)
;; (with-eval-after-load "tex-mode"
;;   (add-hook 'tex-mode-hook 'lsp)
;;   (add-hook 'latex-mode-hook 'lsp))

;; (add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
;; (after! latex-mode
;;   (lsp!))
;; (add-hook 'latex-mode-hook 'lsp-mode-hook)
;; (add-hook 'latex-mode-hook 'lsp)
(add-hook 'LaTeX-mode-hook #'lsp)
;; (setq lsp-tex-server "digesttif")
(setq lsp-clients-texlab-executable
      "/Users/robinzzs/.cargo/bin/texlab")
;; (setq lsp-clients-digestif-executable
;;       "/usr/local/bin/digestif")
;; (add-hook 'text-mode-hook #'lsp)
;; (add-to-list 'company-lsp-filter-candidates '(digestif . nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (after! go-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LISPY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! lispy
  (remove-hook 'lispy-mode-hook #'turn-off-smartparens-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP & DAP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use format-all by default
(setq +format-with-lsp nil)

(after! lsp-mode
  (setq lsp-use-native-json t
        lsp-print-io nil)
  (dolist (dir '("[/\\\\]\\.ccls-cache$"
                 "[/\\\\]\\.mypy_cache$"
                 "[/\\\\]\\.pytest_cache$"
                 "[/\\\\]\\.cache$"
                 "[/\\\\]\\.clwb$"
                 "[/\\\\]_build$"
                 "[/\\\\]__pycache__$"
                 "[/\\\\]bazel-bin$"
                 "[/\\\\]bazel-code$"
                 "[/\\\\]bazel-genfiles$"
                 "[/\\\\]bazel-out$"
                 "[/\\\\]bazel-testlogs$"
                 "[/\\\\]third_party$"
                 "[/\\\\]third-party$"
                 ))
    (push dir lsp-file-watch-ignored))
  ;; ;; Add the clangd client for C++ mode.
  ;; (lsp-register-client
  ;;  (make-lsp-client
  ;;   :new-connection (lsp-stdio-connection
  ;;                    '("lsp.sh" "clangd"
  ;;                      "mkdir -p .clangd && clangd --compile-commands-dir=/code --background-index=true --clang-tidy"))
  ;;   :major-modes '(c++-mode)
  ;;   :server-id 'argo-clangd))
  )


;; (add-hook 'lsp-ui-mode-hook (λ!! #'lsp-ui-doc-mode -1))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-include-signature t
        lsp-ui-doc-max-height 15
        lsp-ui-doc-max-width 100
        lsp-ui-doc-position 'at-point))

;; (use-package! lsp-treemacs
;;   :defer t
;;   :config
;;   (lsp-treemacs-sync-mode 1))

;; (use-package! lsp-treemacs
;;   :defer t
;;   :config
;;   (lsp-treemacs-sync-mode 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEBUG & RUN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! quickrun
  (quickrun-add-command "c++/c1z"
    '((:command . "clang++")
      (:exec    . ("%c -std=c++1z %o -o %e %s"
                   "%e %a"))
      (:remove  . ("%e")))
    :default "c++"))


(after! realgud (advice-remove #'realgud:terminate #'+debugger--cleanup-after-realgud-a))


;; (defun +my/dap-start ()
;;   (interactive)
;;   (dap-mode 1)
;;   (call-interactively #'dap-debug))

;; (add-hook! dap-mode-hook ((dap-tooltip-mode 1) (tooltip-mode 1)))

;; (after! dap-mode
;;   (add-hook 'dap-stopped-hook
;;             (lambda (arg) (call-interactively #'dap-hydra))))
