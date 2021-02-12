;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;;(require 'dap-python)
;;(add-to-list 'doom-autoloads-files (concat doom-private-dir "some-other-file.el"))
;;(require 'dap-python)

(after! dap-mode
(setq dap-python-executable "python3")
(dap-register-debug-template "My App"
  (list :type "python"
        :cwd "/home/dave/PythonProjects/triangulation-2"
        :target-module (expand-file-name "../src/Main.py")
        :request "launch"
        :name "My App"))
(dap-register-debug-template "Triangulation"
  (list :type "python"
        :cwd "/home/dave/PythonProjects/triangulation-2/"
        :target-module "./src/Main.py"
        :request "launch"
        :name "My App2"))

)
(setq deft-directory "~/Dropbox/org"
      deft-extensions '("org" "txt")
      deft-recursive t)

(setq org-roam-directory "~/Dropbox/org/roam")

(after! org-agenda
  (setq org-agenda-clockreport-parameter-plist
;'(:scope file :maxlevel 3 :link t :properties ("Effort") :formula "$5='(- $1 $4);U::@1$1=string(\"Effort\")::@1$3=string(\"Total\")::@1$4=string(\"Task time\")" :formatter my-clocktable-write)
        '(:maxlevel 3 :properties ("Effort") :fileskip0 t :formatter my-clocktable-write :formula "$7='(- $2 $4);U::$8='(- $2 $5);U::$9='(- $2 $6);U" )
        )
  (setq  org-agenda-custom-commands
         (append org-agenda-custom-commands
        '(
        ("w" "work todos"
                (
                        (agenda "")
                        (tags-todo "work")
                        ;(tags-todo "-personal")
                )

                )
        ("p" "personal todos"
                (
                        (agenda "")
                        (tags-todo "personal")
                )

                )

        ("h" "household"
                (
                        (agenda "")
                        (tags-todo "household")
                )

                )
      ("i" "inbox todos"
                (
                        (agenda "")
                        (tags-todo "inbox")
                        ;(tags-todo "-personal")
                )

                )

;;        ("hl" "Calendar" agenda ""
;;         ((org-agenda-span 4)                          ;; [1]
;;          (org-agenda-start-on-weekday 0)               ;; [2]
;;          (org-agenda-time-grid nil)
;;          (org-agenda-repeating-timestamp-show-all t)   ;; [3]
;;          (org-agenda-entry-types '(:timestamp :sexp))))  ;; [4]
;;      ;; other commands go here
;;        ("ho" agenda)
;;        ("hk" tags "+home+Kim")
        ))))
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;;
(setq user-full-name "David H"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq python-pytest-executable "pytest-3")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; (setq lsp-python-ms-extra-paths ["." ".." "/home/dave/PythonProjects/MyProject/src/" "/home/dave/PythonProjects/MyProject/" "src/"])

(setq lsp-python-ms-python-executable-cmd "python3")

(after! realgud-pdb
  (setq realgud:pdb-command-name "python3 -m pdb"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")
(setq org-agenda-files "~/Dropbox/org/")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/flagged.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
;;(setq org-image-actual-width 800)

;; not working
(after! python
        (setq flycheck-checker 'python-flake8)
)
(setq x-super-keysym 'meta)


;; Format org-mode clocktables the way we want to include Effort
;; In the clocktable header:
;; :formatter my/clocktable-write
(defun my-clocktable-write (&rest args)
  "Custom clocktable writer.
Uses the default writer but shifts the first column right 3 columns,
;and names the estimation error column."
  (apply #'org-clocktable-write-default args)
  (save-excursion
    (forward-char) ;; move into the first table field
    (org-table-next-field)
    (org-table-move-column-right)
    (org-table-move-column-right)
    (org-table-move-column-right)
    (org-table-move-column-right)
    (org-table-next-field)
    (org-table-previous-field)))

;
(defun myownfunction ()
       (interactive)
       (insert "hello fab")
       (insert "hello fab1")
       (insert "hello fab2")
       (insert "hello fab3")

)
;;(setq org-superstar-item-bullet-alist
;;  '((?* . ?⌬)
;;    (?+ . ?◐)
;;    (?- . ?⏭)))
(defun invoke-my-debugger ()
  (interactive)
  (let ((default-directory (doom-project-root)))
    (cd default-directory)
    (realgud:pdb "python3 -m pdb ./src/Main.py")))

(setq org-superstar-leading-bullet ?⁂)
;; bullet points in org mode
;;(setq org-superstar-headline-bullets-list '(204E 203B 2023 2043))

(defun myownfunction2 ()
  (interactive)
  (insert "hi from hook")
  )

;; does not work (add-hook 'myownfunction 'myownfunction2)

;(map! :leader
;      (:prefix-map ("a" . "applications")
;       (:prefix ("j" . "journal")
;        :desc "New journal entry" "j" #'org-journal-new-entry
;        :desc "Search journal entry" "s" #'org-journal-search)))


(setq org-plantuml-jar-path "/opt/plantuml/plantuml.jar")


(after! org
  (pushnew! org-modules 'org-habit)
;  (add-to-list 'org-modules 'org-checklist 'org-habit)
;  (setq org-habit-show-habits t)
  (setq org-image-actual-width 800)
  (setq
   org-lowest-priority ?D
   org-priority-faces '((?A :foreground "#DC143C" :weight bold)
                        (?B :foreground "#E76E34" :weight bold)
                        (?C :foreground "#D8A743" :weight bold)
                        (?D :foreground "#3BAB60" :weight bold)))
)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;evil-tutor
;;
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
;(use-package! '('org-drill'))
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; example configuration for mu4e
;;
;; if you installed it using your package manager
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
(set-email-account! "web.de"
  '((mu4e-sent-folder       . "/web.de/Sent Mail")
    (mu4e-drafts-folder     . "/web.de/Drafts")
    (mu4e-trash-folder      . "/web.de/Trash")
    (mu4e-refile-folder     . "/web.de/All Mail")
    (smtpmail-smtp-user     . "lifeainteasy@web.de")
    (user-mail-address      . "lifeainteasy@web.de")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nDavid H"))
  t)
