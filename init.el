;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))



;embark mode
(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))


;;; Programming in clojure and Python3
;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


(require 'cider)
(setq org-babel-clojure-backend 'cider)

(org-babel-do-load-languages
'org-babel-load-languages
'((python . t)
  (clojure . t)
  ))

(setq org-babel-clojure-backend 'cider)
(require 'cider)
;for using python with python and no confirmation
(setq org-confirm-babel-evaluate nil)
(setq org-babel-python-command "python3")


; cache projects, so the after restart the projects are added correctly
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(unless (package-installed-p 'terraform-mode)
  (package-install 'terraform-mode))

(add-hook 'terraform-mode-hook #'lsp-deferred)

(unless (package-installed-p 'cider)
  (package-install 'cider))

;clojure: start lsp mode automatically
(add-hook 'clojure-mode-hook #'lsp-deferred)

(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))

;Python: start lsp mode automatically
(add-hook 'python-mode-hook #'lsp-deferred)

(add-hook 'after-init-hook 'global-company-mode)


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


					; python mode works out of the box
					; start python-mode
					; start run-python and evaluate
; lisp mode

;dired in colors
(unless (package-installed-p 'diredfl)
  (package-install 'diredfl))

(require 'diredfl)
(diredfl-global-mode 1)

;; org-download is need for C-c map coying images
(require 'org-download)
;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; *** Org mode ***
;; deletes super ugly dots at the start of a bullet
;; https://www.reddit.com/r/spacemacs/comments/hrdj0x/dots_appearing_in_orgmode_bullet_lists

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "/home/dave/Dropbox/org1/tasks.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

(setq   org-highest-priority ?A
    org-default-priority ?B
    org-lowest-priority ?D
)

(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "KILL")))

; on doom KILL is nur highlighted, if hovered over
;(setq org-todo-keyword-faces
;      '(("KILL" . "darkred")))


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


(defun doom--update-files (&rest files)
  "Ensure FILES are updated in `recentf', `magit' and `save-place'."
  (let (toplevels)
    (dolist (file files)
      (when (featurep 'vc)
        (vc-file-clearprops file)
        (when-let (buffer (get-file-buffer file))
          (with-current-buffer buffer
            (vc-refresh-state))))
      (when (featurep 'magit)
        (when-let (default-directory (magit-toplevel (file-name-directory file)))
          (cl-pushnew default-directory toplevels)))
      (unless (file-readable-p file)
        (when (bound-and-true-p recentf-mode)
          (recentf-remove-if-non-kept file))
        (when (and (bound-and-true-p projectile-mode)
                   (doom-project-p)
                   (projectile-file-cached-p file (doom-project-root)))
          (projectile-purge-file-from-cache file))))
    (dolist (default-directory toplevels)
      (magit-refresh))
    (when (bound-and-true-p save-place-mode)
      (save-place-forget-unreadable-files))))




(defun doom/copy-this-file (new-path &optional force-p)
  "Copy current buffer's file to NEW-PATH.

If FORCE-P, overwrite the destination file if it exists, without confirmation."

  (interactive
   (list (read-file-name "Copy file to: ")
         current-prefix-arg))
  (unless (and buffer-file-name (file-exists-p buffer-file-name))
    (user-error "Buffer is not visiting any file"))
  (let ((old-path (buffer-file-name (buffer-base-buffer)))
        (new-path (expand-file-name new-path)))
    (make-directory (file-name-directory new-path) 't)
    (copy-file old-path new-path (or force-p 1))
    (doom--update-files old-path new-path)
    (message "File copied to %S" (abbreviate-file-name new-path))))



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

(setq dave/file-map (make-sparse-keymap))
(define-key dave/file-map "s" '("Save file" . save-buffer))
(define-key dave/file-map "r" '("Open Recent files" . consult-recent-file))
(define-key dave/file-map "f" '("find file" . find-file))
(define-key dave/file-map "C" '("copy file" . doom/copy-this-file))
(setq search-map (make-sparse-keymap))
(define-key search-map "s" '("search-buffer" . consult-line))

(setq attach-map (make-sparse-keymap))
(define-key attach-map "p" '("attach" . org-download-clipboard))
(setq links-map (make-sparse-keymap))
(define-key links-map "s" '("store link" . org-store-link))

(setq org-map (make-sparse-keymap))
(define-key org-map "." '("search-heading" . consult-org-heading))
(define-key org-map "l" (cons "links" links-map))
(define-key org-map "a" (cons "attachments" attach-map))
(setq notes-map (make-sparse-keymap))
(define-key notes-map "a" '("agenda" . org-agenda))
(setq projectile-map (make-sparse-keymap))
(define-key projectile-map "p" '("switch to project" . projectile-switch-project))
(define-key projectile-map "a" '("add project" . projectile-add-known-project))
(define-key projectile-map "f" '("find file in project" . projectile-find-file))
(setq bindings-map (make-sparse-keymap))
(define-key bindings-map "t" '("bindings map" . which-key-show-top-level))
(setq help-map (make-sparse-keymap))
(define-key help-map "b" (cons "bindings" bindings-map))

(setq my-map (make-sparse-keymap))
(define-key my-map "m" (cons "org" org-map))
(define-key my-map "s" (cons "search" search-map))
(define-key my-map "f" (cons "files" dave/file-map))
(define-key my-map "n" (cons "notes" notes-map))
(define-key my-map "p" (cons "project" projectile-map))
(define-key my-map "h" (cons "help" help-map))
(define-key my-map "X" '("Capture" . org-capture))

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

; show images in org mode
 '(org-startup-with-inline-images t)
 '(package-selected-packages
   '(embark zen-mode counsel ivy org-superstar evil-org org-modern evil-visual-mark-mode evil)))
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
