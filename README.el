(fido-vertical-mode)
(define-key icomplete-minibuffer-map (kbd "TAB") 'icomplete-force-complete)
(use-package savehist :init (savehist-mode))
(use-package marginalia
  :ensure t
  :init (marginalia-mode))

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(pixel-scroll-precision-mode 1)
(pixel-scroll-mode 1)
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 8)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 70))
(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font-12"))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(fset 'yes-or-no-p 'y-or-n-p)
(electric-pair-mode)
(setq electric-pair-inhibit-predicate (lambda (c) (char-equal c ?\<)))

(require 'org-tempo)
(electric-indent-mode 1)
(setq org-src-preserve-indentation t
      org-startup-with-inline-images t)
(setq create-lockfiles nil
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(use-package catppuccin-theme
  :ensure t
  :config (setq catppuccin-flavor 'mocha)
  :init (load-theme 'catppuccin :noconfirm))

(use-package all-the-icons-completion
  :ensure t
  :config (all-the-icons-completion-mode))

(use-package corfu
  :ensure t
  :config
  (setq corfu-auto t)
  (global-corfu-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 3) (projects . 2))
	dashboard-footer-messages '("TQMR")
	dashboard-center-content t
	initial-buffer-choice 'dashboard-open
	dashboard-banner-logo-title nil
	dashboard-startup-banner "~/.config/emacs/logo-small.xpm"))

(use-package dirvish
  :ensure t
  :config (dirvish-override-dired-mode))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package eat :ensure t)

(use-package org-bullets
  :ensure t
  :hook ((org-mode . org-indent-mode)
	     (org-mode . (lambda () (org-bullets-mode 1)))))

(use-package rainbow-delimiters 
  :ensure t
  :hook prog-mode org-mode)

(use-package magit :ensure t)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(defun open-config ()
  "Open configuration file"
  (interactive)
  (find-file "~/.config/emacs/README.org"))

(global-set-key (kbd "C-c o c") #'open-config)

(use-package go-mode :ensure t)
(use-package sly
  :ensure t
  :config (setq inferior-lisp-program "ros -Q run"))
(use-package emmet-mode :ensure t
  :hook (html-mode . emmet-mode))
