;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; *** Org mode ***
;; deletes super ugly dots at the start of a bullet
;; https://www.reddit.com/r/spacemacs/comments/hrdj0x/dots_appearing_in_orgmode_bullet_lists/
(setq org-hide-leading-stars nil) ;; ugly dots
(setq org-superstar-leading-bullet ?\s) ;; ogly dots
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(setq org-agenda-files (list "~/test"))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; *** Ivy mode ***
(ivy-mode 1)
(use-package ivy :demand
      :config
      (setq ivy-use-virtual-buffers t
            ivy-count-format "%d/%d "))
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;;enable this if you want `swiper' to use it
(setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
;;(global-set-key "\C-x\ \C-r" 'counsel-recentf)

;; *** Which key ***
;; shows shortcuts, when clicking C-x
(add-to-list 'load-path "/Users/dave/.emacs.d/elpa/which-key-20220811.1616/which-key.el")
(require 'which-key)
(which-key-mode)
;; https://github.com/doomemacs/doomemacs/blob/master/modules/config/default/+evil-bindings.el

;  (:prefix-map ("f" . "file")
;       :desc "Open project editorconfig"   "c"   #'editorconfig-find-current-editorconfig
;       :desc "Copy this file"              "C"   #'doom/copy-this-file
;       :desc "Find directory"              "d"   #'+default/dired
;       :desc "Delete this file"            "D"   #'doom/delete-this-file
;       :desc "Find file in emacs.d"        "e"   #'doom/find-file-in-emacsd
;       :desc "Browse emacs.d"              "E"   #'doom/browse-in-emacsd
;       :desc "Find file"                   "f"   #'find-file
;       :desc "Find file from here"         "F"   #'+default/find-file-under-here
;       :desc "Locate file"                 "l"   #'locate
;       :desc "Find file in private config" "p"   #'doom/find-file-in-private-config
;       :desc "Browse private config"       "P"   #'doom/open-private-config
;       :desc "Recent files"                "r"   #'recentf-open-files
;       :desc "Rename/move file"            "R"   #'doom/move-this-file
;       :desc "Save file"                   "s"   #'save-buffer
;       :desc "Save file as..."             "S"   #'write-file
;       :desc "Sudo find file"              "u"   #'doom/sudo-find-file
;       :desc "Sudo this file"              "U"   #'doom/sudo-this-file
;       :desc "Yank file path"              "y"   #'+default/yank-buffer-path
;       :desc "Yank file path from project" "Y"   #'+default/yank-buffer-path-relative-to-project)

(setq file-map (make-sparse-keymap))
(define-key file-map "s" '("Save file" . save-buffer))
(define-key file-map "r" '("Open Recent files" . counsel-recentf))
(define-key file-map "f" '("find file" . counsel-find-file))
(define-key file-map "b" '("bar-prefix" . (keymap)))
(setq my-map (make-sparse-keymap))
(define-key my-map "f" (cons "files" file-map))
;;(define-key evil-normal-state-map (kbd "SPC") my-map)
(global-set-key (kbd "C-c") my-map)

;; *** Theme ***
;; nice theme
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


(add-to-list 'load-path "~/.emacs.d/myloadpath")
(require 'zen-mode)
(global-set-key (kbd "C-M-z") 'zen-mode)

;; commented evil *** Evil mode ***

;; Download Evil
;;(unless (package-installed-p 'evil)
;;(package-install 'evil))
;; needs to be before require evil
;;(setq evil-want-C-u-scroll t) ;; scroll with C-u
;;(setq evil-want-C-i-jump nil) ;; tab in org mode
;; Enable Evil
;;(require 'evil)
;;(evil-mode  0)

;;Exit insert mode by pressing j and then j quickly
;;(setq key-chord-two-keys-delay 0.5)
;;(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;;(key-chord-mode 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(zen-mode counsel ivy org-superstar evil-org org-modern evil-visual-mark-mode evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
