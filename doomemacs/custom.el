(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-reports
   '(("reg" "ledger [[ledger-mode-flags]] -f /home/dave/Dropbox/org1/ledger-2021.dat reg")
     ("bal" "ledger [[ledger-mode-flags]] -f /home/dave/Dropbox/org1/ledger-2021.dat bal")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)")))
        '(org-agenda-files
        '("/home/dave/Dropbox/org/notebook.org" "/home/dave/Dropbox/org1/schedule.org" "/home/dave/Dropbox/org1/schedule.org_archive" "/home/dave/Dropbox/org1/birthdays.org" "/home/dave/Dropbox/org1/mypdf.org" "/home/dave/Dropbox/org1/priv.org" "/home/dave/Dropbox/org1/test.org" "/home/dave/Dropbox/org1/events.org" "/home/dave/Dropbox/org1/work.org"))
 '(package-selected-packages '(request)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
