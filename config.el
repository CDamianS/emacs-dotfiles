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

(straight-use-package 'evil)
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
 (setq evil-collection-mode-list '(dashboard dired ibuffer))
 (evil-collection-init))

(global-set-key (kbd "C-u") 'evil-scroll-up)

(set-face-attribute 'default nil
  :font "FiraCode Nerd Font"
  :height 110
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Source Code Pro"
  :height 110
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "FiraCode Nerd Font"
  :height 110
  :weight 'medium)

(set-face-attribute 'font-lock-comment-face nil
:slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
:slant 'italic)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font-11"))
(setq-default line-spacing 0.12)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(setq display-line-numbers-type 'relative)

(straight-use-package 'catppuccin-theme)
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'latte) ;; or 'frappe, 'macchiato, or 'mocha
(catppuccin-reload)

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
    "." '(find-file :wk "Find file")
    "fp" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit config")
    "fs" '(save-buffer :wk "Save buffer"))

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
)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)

(require 'org-tempo)

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
	which-key-allow-imprecise-window-fit t
	which-key-separator " → "))
