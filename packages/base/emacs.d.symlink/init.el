; enable mouse + scrolling
(xterm-mouse-mode 1)
(mouse-wheel-mode 1)

; put auto save files in temp directory instead of in project directory
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; set up melpa and use-package
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

; automatically set theme to match system
(use-package auto-dark
  :ensure t
  :custom
  (auto-dark-themes '((modus-vivendi) (leuven)))
  (auto-dark-allow-osascript t)
  :init
  (auto-dark-mode))

; better file/command pickers
(use-package vertico
  :ensure t
  :init
  (vertico-mode))
(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode))
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless flex basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))
(use-package consult
  :ensure t)

; modal editing
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
(use-package meow
  :ensure t
  :config
  (meow-setup)
  (meow-global-mode 1))

; company and eglot for lsp completion
(use-package company
  :hook (prog-mode . company-mode))
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(zig-mode . ("zls")))
  :hook
  (zig-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  (eglot--confirm-server-edits nil))

(use-package zig-mode
  :ensure t
  :mode ("\\.zig\\'" "\\.zon\\'")
  :custom
  (zig-format-on-save t))

(keymap-global-set "M-\\" #'split-window-right)
(keymap-global-set "M--" #'split-window-below)
(keymap-global-set "M-h" #'windmove-left)
(keymap-global-set "M-j" #'windmove-down)
(keymap-global-set "M-k" #'windmove-up)
(keymap-global-set "M-l" #'windmove-right)
(keymap-global-set "C-M-h" #'windmove-swap-states-left)
(keymap-global-set "C-M-j" #'windmove-swap-states-down)
(keymap-global-set "C-M-k" #'windmove-swap-states-up)
(keymap-global-set "C-M-l" #'windmove-swap-states-right)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("653bc7ac0de0537b10facb11a2872b7dbe1da12eec99d19adead120aa6285712"
     "9afcf2d0d88a677acd2c5db94e867fff840beef6bf2dbcdae25a61a1fb5ffd2b"
     "36a9aa30ed9f3e23e956b03007852d43d6f38a25f22bf40e8cd3026097775a41"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
