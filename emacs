(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "957a573d5c7cb49c2f033b9d5a6f77445c782307e2d7ffca0d9b5b8141c49843" default))
 '(package-selected-packages
   '(spacemacs-theme spacegray-theme ancient-one-dark-theme ##)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; org mode configuration
(require 'org)
(transient-mark-mode t)

;; hide startup message
(setq inhibit-startup-message t)

;; adding my own custom home page
(setq initial-buffer-choice "~/Desktop/code/emacs_stuff/emacs_welcome.org")

;; hide tool bar, scroll bar, and menu bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; enable highlight and line numbers
(global-hl-line-mode t)
(line-number-mode t)


;; enable command button as meta (for mac)
(setq mac-command-modifier 'meta)

;; package installation
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)


;; adding a custom file
(setq custom-file "~/.emacs.d/custom-file.el")

;; set custom theme
(load-theme 'spacemacs-dark)


;; initializing the use-package
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

;; sidebar menu
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
 ;; (add-hook 'dired-sidebar-mode-hook
 ;;           (lambda ()
 ;;             (unless (file-remote-p default-directory)
 ;;               (auto-revert-mode))))
 ;; :config
 ;; (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
 ;; (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; org mode :))
(use-package org
  :mode (("\\.org$" . org-mode))
  ;;:ensure org
  :config
  (progn
    ;; config stuff
    ))

;; linter
(use-package flymake-kondor
  :ensure t
  :hook (clojure-mode . flymake-kondor-setup))


;; python
[
(add-to-list 'load-path user-emacs-directory)

(defun my:ensure-python.el (&optional branch overwrite)
  "Install python.el from BRANCH.
After the first install happens the file is not overwritten again
unless the optional argument OVERWRITE is non-nil.  When called
interactively python.el will always be overwritten with the
latest version."
  (interactive
   (list
    (completing-read "Install python.el from branch: "
                     (list "master" "emacs-24")
                     nil t)
    t))
  (let* ((branch (or branch "master"))
         (url (format
               (concat "http://git.savannah.gnu.org/cgit/emacs.git/plain"
                       "/lisp/progmodes/python.el?h=%s") branch))
         (destination (expand-file-name "python.el" user-emacs-directory))
         (write (or (not (file-exists-p destination)) overwrite)))
    (when write
      (with-current-buffer
          (url-retrieve-synchronously url)
        (delete-region (point-min) (1+ url-http-end-of-headers))
        (write-file destination))
      (byte-compile-file destination t)
      destination)))

(my:ensure-python.el)
]
