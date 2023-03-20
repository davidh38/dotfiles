 ;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

; don't want to lose time during startup
;(package-initialize)
;(package-refresh-contents)
 

;; Keep the menu bar visible.  The menu bar includes entries like
;; "File" and "Buffers".  It can be helpful at this early stage as it
;; shows the key bindings for commands.
(menu-bar-mode 1)

;; Disable the icons that are shown at the top of the Emacs window.
;; We do not need them because we already have the global menu bar.
(tool-bar-mode -1)

;; Keep the scroll bar enabled for the time being.  It helps if you
;; intend to use the mouse (might be needed if you try the Emacs
;; keys).
(scroll-bar-mode 1)

;not needed for new
;; When you have some text selected, any input will delete it and
;; replace it with what you typed in.  This is how virtually all
;; programs work nowadays.  I think it is a better default.
;(delete-selection-mode 1)

;dired in colors
(unless (package-installed-p 'diredfl)
  (package-install 'diredfl))

(require 'diredfl)

(diredfl-global-mode 1)

;; *** Org mode ***
;; deletes super ugly dots at the start of a bullet
;; https://www.reddit.com/r/spacemacs/comments/hrdj0x/dots_appearing_in_orgmode_bullet_lists

;(setq org-todo-keywords
;      '((sequence "TODO" "DONE" "KILL")))

;(setq org-todo-keyword-faces
;      '(("KILL" . "red")
;        ("DONE" . "gray"))
;      )

(setq org-hide-leading-stars nil) ;; ugly dots
(setq org-superstar-leading-bullet ?\s) ;; ogly dots
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

; intentation of log book for example and text
(setq org-adapt-indentation t)
;(org-agenda-files '("/home/dave/Dropbox/org/notebook.org" "/home/dave/Dropbox/org1/schedule.org" "/home/dave/Dropbox/org1/schedule.org_archive" "/home/dave/Dropbox/org1/birthdays.org" "/home/dave/Dropbox/org1/mypdf.org" "/home/dave/Dropbox/org1/priv.org" "/home/dave/Dropbox/org1/test.org" "/home/dave/Dropbox/org1/events.org" "/home/dave/Dropbox/org1/work.org"))


(setq org-agenda-files (list "/home/dave/Dropbox/org1/schedule.org"))

                                        ;(lambda () (writeroom-mode 1)))
  (setq org-tags-exclude-from-inheritance '("time_booking"))
  (setq org-agenda-start-on-weekday 1)         ;; calendar begins today
  (setq org-agenda-start-day "1d")
  (setq org-agenda-clockreport-parameter-plist
                                        ;'(:scope file :maxlevel 3 :link t :properties ("Effort") :formula "$5='(- $1 $4);U::@1$1=string(\"Effort\")::@1$3=string(\"Total\")::@1$4=string(\"Task time\")" :formatter my-clocktable-write)
                                        ;'(:maxlevel 3) :properties ("Effort") :fileskip0 t :formatter my-clocktable-write :formula "$7='(- $2 $4);U::$8='(- $2 $5);U::$9='(- $2 $6);U" )
        '(:maxlevel 4 ;:properties ("Effort") :fileskip0 t :formatter my-clocktable-write :formula "$9='(- $3 $5);U::$10='(- $2 $6);U::$11='(- $2 $7);U::$12='(- $3 $8);U"
          )
        )


;
;(setq org-agenda-custom-commands
;      '(
;	("w" "work todos"
;(agenda "" (org-agenda-span 7)
;(org-agenda-files '("/home/dave/Dropbox/org/notebook.org" "/home/dave/Dropbox/org1/schedule.org" "/home/dave/Dropbox/org1/schedule.org_archive" "/home/dave/Dropbox/org1/birthdays.org" "/home/dave/Dropbox/org1/mypdf.org" "/home/dave/Dropbox/org1/priv.org" "/home/dave/Dropbox/org1/test.org" "/home/dave/Dropbox/org1/events.org" "/home/dave/Dropbox/org1/work.org"))
;
;	)
;))
;      )
;

;       (setq org-agenda-custom-commands
;               
;                        '("w" "work todos"
;                                (
;                                        (agenda ""
;
;                                                (                                                (org-agenda-span 7)                      ;; overview of appointments
;                                                (calendar-week-start-day 0)
;                                                (org-agenda-start-on-weekday 1)         ;; calendar begins today
;                                                )
;                                        )
;                                        (tags-todo "work")
;                                        ;(tags-todo "-personal")
;                                )
;
;                        )
;		
;	)
;

;(add-to-list 'org-agenda-custom-commands 'test-org-agenda-custom-commands)       
		
;   (setq  org-agenda-custom-commands
;       '(append org-agenda-custom-commands
;                '(
;                        ("w" "work todos"
;                                (
;                                        (agenda ""
;
;                                                ((org-agenda-files '("/home/dave/Dropbox/org/notebook.org" "/home/dave/Dropbox/org1/schedule.org" "/home/dave/Dropbox/org1/schedule.org_archive" "/home/dave/Dropbox/org1/birthdays.org" "/home/dave/Dropbox/org1/mypdf.org" "/home/dave/Dropbox/org1/priv.org" "/home/dave/Dropbox/org1/test.org" "/home/dave/Dropbox/org1/events.org" "/home/dave/Dropbox/org1/work.org"))
;                                                (org-agenda-span 7)                      ;; overview of appointments
;                                                (calendar-week-start-day 0)
;                                                (org-agenda-start-on-weekday 1)         ;; calendar begins today
;                                                )
;                                        )
;                                        (tags-todo "work")
;                                        ;(tags-todo "-personal")
;                                )
;
;                        )
;
;                        ("r" "reflections"
;                                (
;                                        (agenda ""
;                                                ((org-agenda-span 7)                      ;; overview of appointments
;                                                (calendar-week-start-day 0)
;                                                (org-agenda-start-on-weekday 1)         ;; calendar begins today
;                                        )
;
;                                        )
;                                        (tags-todo "inbox -problems")
;                                        (tags-todo "-problems")
;                                )
;                        )
;
;                        ("p" "problems"
;                                (
;                                        (agenda ""
;                                                ((org-agenda-span 7)                      ;; overview of appointments
;                                                (calendar-week-start-day 0)
;                                                (org-agenda-start-on-weekday 1))         ;; calendar begins today
;
;                                        )
;                                        (tags-todo "problems")
;                                )
;
;                        )
;
;                        ("~" "tasks"
;                                (
;                                        (agenda ""
;                                                ((org-agenda-span 7)                      ;; overview of appointments
;                                                (calendar-week-start-day 0)
;                                                (org-agenda-start-on-weekday 1))         ;; calendar begins today
;
;                                        )
;                                        (tags-todo "tasks")
;                                )
;
;                        )
;
;                        ("i" "inbox todos"
;                                        ; das ist fuer die todas
;                                (
;                                        (agenda ""
;                                                ((org-agenda-files '("/home/dave/Dropbox/org/notebook.org" "/home/dave/Dropbox/org1/schedule.org" "/home/dave/Dropbox/org1/schedule.org_archive" "/home/dave/Dropbox/org1/birthdays.org" "/home/dave/Dropbox/org1/mypdf.org" "/home/dave/Dropbox/org1/priv.org" "/home/dave/Dropbox/org1/test.org" "/home/dave/Dropbox/org1/events.org"))
;                                        ;(org-agenda-sorting-strategy '(priority-up effort-down))
;                                                (org-agenda-span 7)                      ;; overview of appointments
;                                                (calendar-week-start-day 0)
;                                                (org-agenda-start-on-weekday 1)         ;; calendar begins today)
;                                        )
;                                )
;                                (tags-todo "inbox")
;                                )
;				)
;			)
;                   ))
;
;

;(global-set-key (kbd "C-c l") #'org-store-link)
;(global-set-key (kbd "C-c a") #'org-agenda)
;(global-set-key (kbd "C-c c") #'org-capture)

(add-hook 'org-tab-first-hook
           ;; Only fold the current tree, rather than recursively
            #'+org-cycle-only-current-subtree-h)
         
;;;###autoload
(defun +org-cycle-only-current-subtree-h (&optional arg)
  "Toggle the local fold at the point, and no deeper.
`org-cycle's standard behavior is to cycle between three levels: collapsed,
subtree and whole document. This is slow, especially in larger org buffer. Most
of the time I just want to peek into the current subtree -- at most, expand
*only* the current subtree.
All my (performant) foldings needs are met between this and `org-show-subtree'
(on zO for evil users), and `org-cycle' on shift-TAB if I need it."
  (interactive "P")
  (unless (or (eq this-command 'org-shifttab)
              (and (bound-and-true-p org-cdlatex-mode)
                   (or (org-inside-LaTeX-fragment-p)
                       (org-inside-latex-macro-p))))
    (save-excursion
      (org-beginning-of-line)
      (let (invisible-p)
        (when (and (org-at-heading-p)
                   (or org-cycle-open-archived-trees
                       (not (member org-archive-tag (org-get-tags))))
                   (or (not arg)
                       (setq invisible-p (outline-invisible-p (line-end-position)))))
          (unless invisible-p
            (setq org-cycle-subtree-status 'subtree))
          (org-cycle-internal-local)
          t)))))

;; set letters to bigger font size
(set-face-attribute 'default nil :height 200)

;; set margin because of my big monitor
(setq-default left-margin-width 50)

;function, that could chang the margin
;(setq my-margin-left 50) ;; eval to change the left margin immediately.
;(setq my-margin-right 0) ;; eval to change the right margin immediately.
;
;(defun my-update-margins ()
;  (set-window-margins (get-buffer-window) my-margin-left my-margin-right))
;
;(add-hook 'window-configuration-change-hook 'my-update-margins)
;(add-hook 'window-state-change-hook 'my-update-margins)
;

;; find file preview
(unless (package-installed-p 'vertico)
  (package-install 'vertico))

(require 'vertico)

(vertico-mode 1)

; find file preview last used in hours etc.
;;; `marginalia' is a package that we need to install.
(unless (package-installed-p 'marginalia)
(package-install 'marginalia))
;
(require 'marginalia)
;
(marginalia-mode 1)

;better regex search in find file
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion orderless))))

;; recentf stuff -> must be enabled for consult
(require 'recentf)
(recentf-mode 1)
;
(unless (package-installed-p 'consult)
  (package-install 'consult))

; Example configuration for Consult - narrows for example in search-org-heading
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :config
(setq consult-narrow-key "<") ;; "C-+"
 ; (;; C-c bindings (mode-specific-map)
         ;("C-c M-x" . consult-mode-command)
         ;("C-c h" . consult-history)
;	 )
  )
;					;
;
;
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
(define-key file-map "r" '("Open Recent files" . consult-recent-file))
(define-key file-map "f" '("find file" . find-file))
(setq search-map (make-sparse-keymap))
(define-key search-map "s" '("search-buffer" . consult-line))
(setq org-map (make-sparse-keymap))
(define-key org-map "." '("search-heading" . consult-org-heading))
(setq notes-map (make-sparse-keymap))
(define-key notes-map "a" '("agenda" . org-agenda))
(setq my-map (make-sparse-keymap))
(define-key my-map "m" (cons "org" org-map))
(define-key my-map "s" (cons "search" search-map))
(define-key my-map "f" (cons "files" file-map))
(define-key my-map "n" (cons "notes" notes-map))
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


(add-to-list 'load-path "/home/dave/.emacs.d/myloadpath/zen-mode")
(require 'zen-mode)
(global-set-key (kbd "C-M-z") 'zen-mode)


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
