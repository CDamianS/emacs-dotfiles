(defvar bootstrap-version)
(let ((bootstrap-file
    (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
    (bootstrap-version 6))
(unless (file-exists-p bootstrap-file)
        (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
(load bootstrap-file nil 'nomessage))
;; use-package macro and set to default
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package evil
   :init
   (setq evil-want-integration t)
   (setq evil-want-keybinding nil)
   (setq evil-want-vsplit-window-right t)
   (setq evil-want-split-window-below t)
   (evil-mode))

(use-package evil-collection
   :after evil
   :config
   (setq evil-collection-mode-list '(org dashboard dired ibuffer magit))
   (evil-collection-init))

(use-package evil-commentary)
(evil-commentary-mode)

(global-set-key (kbd "C-u") 'evil-scroll-up)

(use-package all-the-icons
:ensure t
:if (display-graphic-p))

(use-package all-the-icons-dired
:hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(set-face-attribute 'default nil
  :font "FiraCode Nerd Font"
  :height 140
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Source Code Pro"
  :height 140
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "FiraCode Nerd Font"
  :height 140
  :weight 'medium)

  (set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
  (set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font-11"))
(setq-default line-spacing 0.12)

(use-package lsp-mode)

  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  (global-display-line-numbers-mode 1)
  (global-visual-line-mode t)
  (setq display-line-numbers-type 'relative)

(setq scroll-step            1
      scroll-conservatively  10000
      scroll-margin 8)

   (add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
   (straight-use-package 'catppuccin-theme)
   (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'mocha) ;; or 'frappe, 'latte, or 'mocha
  ;; (catppuccin-reload)

;;(load-theme 'Bloom t)

;;(load-theme 'spaceduck t)

  (use-package general
      :config
      (general-evil-setup)

  ;; set up Space as the global leader key
  (general-create-definer leader-keys
      :states '(normal insert visual emacs)
      :keymaps 'override
      :prefix "SPC" ;; set leader
      :global-prefix "M-SPC")

  ;; File
  ;; TODO: highlighted 
  (leader-keys
      "f" '(:ignore :wk "File")
      "." '(find-file :wk "Find file")
      "fr" '(counsel-recentf :wk "Find recent file")
      "fp" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit config")
      "fs" '(save-buffer :wk "Save File"))

  ;; Buffer
  (leader-keys
      "b" '(:ignore t :wk "Buffer")
      "bb" '(switch-to-buffer :wk "Switch buffer")
      "bi" '(ibuffer :wk "Ibuffer")
      "bd" '(kill-this-buffer :wk "Kill this buffer")
      "bn" '(next-buffer :wk "Next buffer")
      "bp" '(previous-buffer :wk "Previous buffer")
      "br" '(revert-buffer :wk "Reload buffer"))

  ;; Elisp eval 
  (leader-keys
      "e" '(:ignore t :wk "Evaluate")
      "eb" '(eval-buffer :wk "Eval elisp in buffer")
      "ed" '(eval-defun :wk "Eval defun containing or after point")
      "ee" '(eval-expression :wk "Eval an elisp expression")
      "el" '(eval-last-sexp :wk "Eval elisp expression before point")
      "er" '(eval-region :wk "Eval elisp in region"))

  ;; Help (I need somebody :o)
  (leader-keys
      "h" '(:ignore t :wk "Help")
      "hf" '(describe-function :wk "Describe function")
      "hv" '(describe-variable :wk "Describe variable")
      "hrr" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))

  ;; Window management
  (leader-keys
      "w" '(:ignore t :wk "Window")
      "wh" '(evil-window-left :wk "Window left")
      "wj" '(evil-window-down :wk "Window down")
      "wk" '(evil-window-up :wk "Window up")
      "wl" '(evil-window-right :wk "Window right")
      "wq" '(evil-window-delete :wk "Delete current window")
      "wv" '(evil-window-vsplit :wk "Move to the left window")
      "ws" '(evil-window-split :wk "Move to the left window"))

  ;; Open stuff 
  (leader-keys
      "o" '(:ignore t :wk "Open")
      "ot" '(vterm-toggle :wk "Vterm toggle")
      "op" '(treemacs :wk "treemacs"))
  )

(general-create-definer evil-keys
    :keymaps 'override
    )

(evil-keys
    :prefix "j"
    :states '(insert)
    "k" '(evil-normal-state :wk "Normal state"))

(use-package eshell-syntax-highlighting
    :after  esh-mode
    :config
    (eshell-syntax-highlighting-global-mode +1))

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
:config
(setq vterm-shell "/bin/zsh"))

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.3))))

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Welcome to GNU Emacs!")
  (setq dashboard-startup-banner 'official) ;; use standard emacs logo as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents  . 3)
                         (bookmarks . 5)
                         (projects . 5)
                         (agenda . 5)))
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-footer-messages '("TQMT"))
(setq dashboard-set-init-info nil)

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package nerd-icons)
(use-package doom-modeline)
(doom-modeline-mode 1)

(use-package magit)
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

(leader-keys
    "g" '(:ignore t :wk "Git")
    "gg" '(magit-status :wk "Magit Status"))

(use-package go-mode)
(use-package lua-mode)
(use-package web-mode)

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

(use-package diminish)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(setq org-agenda-files (quote ("~/Agenda/")))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)
(setq org-src-preserve-indentation t)
(setq ation t)

(require 'org-tempo)

(leader-keys
    "m" '(:ignore t :wk "Org")
    "oa" '(org-agenda :wk "Org agenda")
    "me" '(org-export-dispatch :wk "Org export dispatch")
    "mi" '(org-toggle-item :wk "Org toggle item")
    "mt" '(org-todo :wk "Org todo")
    "mB" '(org-babel-tangle :wk "Org babel tangle")
    "mT" '(org-todo-list :wk "Org todo list"))

(leader-keys
    "mb" '(:ignore t :wk "Tables")
    "mb -" '(org-table-insert-hline :wk "Insert hline in table"))

(leader-keys
    "md" '(:ignore t :wk "Date/deadline")
    "mdt" '(org-time-stamp :wk "Org time stamp"))

(leader-keys
    "p" '(projectile-command-map :wk "Projectile")
    "ff" '(projectile-find-file :wk "Projectile find file"))

(use-package projectile
    :config
    (projectile-mode 1))

(use-package rainbow-mode
    :hook org-mode prog-mode)

(use-package sudo-edit
    :config
    (leader-keys
        "fu" '(sudo-edit-find-file :wk "Sudo find file")
        "fU" '(sudo-edit :wk "Sudo edit this file")))

(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.8
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit nil
	which-key-separator " → "))
