(operating-system
  (host-name "gnu")
  (timezone "Etc/UTC")
  (locale "en_US.utf8")
  (keyboard-layout (keyboard-layout "dvorak" #:options '("ctrl:nocaps"))) ;;#"altgr-intl" ;; Label for the GRUB boot menu.
  (label (string-append "GNU Guix "
                        (or (getenv "GUIX_DISPLAYED_VERSION")
                            (package-version guix))))
 
  (firmware '())
 
  ;; Below we assume /dev/vda is the VM's hard disk.
  ;; Adjust as needed.
  (bootloader (bootloader-configuration
               (bootloader grub-bootloader)
               (targets '("/dev/vda"))
               (terminal-outputs '(console))))
  (file-systems (cons (file-system
                        (mount-point "/")
                        (device "/dev/vda2")
                        (type "ext4"))
                      %base-file-systems))
 
  (users (cons (user-account
                (name "dave")
                (comment "GNU Guix Liva")
                (password "")                     ;no password
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))
 
  ;; Our /etc/sudoers file.  Since 'guest' initially has an empty password,
  ;; allow for password-less sudo.
  (sudoers-file (plain-file "sudoers" "\
root ALL=(ALL) ALL
%wheel ALL=NOPASSWD: ALL\n"))
 
  (packages (append (list font-bitstream-vera nss-certs nvi wget vim emacs i3-wm i3status dmenu st xrandr git keepassxc icecat flatpak dbus python xclip)
                    %base-packages))
 
  (services
   (append (list ;service xfce-desktop-service-type)
                 ;; Choose SLiM, which is lighter than the default GDM.
                 (service slim-service-type
                          (slim-configuration
                           (auto-login? #t)
                           (default-user "dave")
                           (xorg-configuration
                            (xorg-configuration
                             ;; The QXL virtual GPU driver is added to provide
                             ;; a better SPICE experience.
                             (modules (cons xf86-video-qxl
                                            %default-xorg-modules))
                             (keyboard-layout keyboard-layout)))))
 
                 ;; Uncomment the line below to add an SSH server.
                 ;;(service openssh-service-type)
 
                 ;; Add support for the SPICE protocol, which enables dynamic
                 ;; resizing of the guest screen resolution, clipboard
                 ;; integration with the host, etc.
                 (service spice-vdagent-service-type)
 
;                 (simple-service 'cron-jobs mcron-service-type
;                                 (list auto-update-resolution-crutch))
 
                 ;; Use the DHCP client service rather than NetworkManager.
                 (service dhcp-client-service-type))
 
           ;; Remove some services that don't make sense in a VM.
           (remove (lambda (service)
                     (let ((type (service-kind service)))
                       (or (memq type
                                 (list gdm-service-type
                                       sddm-service-type
                                       wpa-supplicant-service-type
                                       cups-pk-helper-service-type
                                       network-manager-service-type
                                       modem-manager-service-type))
                           (eq? 'network-manager-applet
                                (service-type-name type)))))
                   (modify-services %desktop-services
                     (login-service-type config =>
                                         (login-configuration
                                          (inherit config)
                                          (motd vm-image-motd)))
 
                     ;; Install and run the current Guix rather than an older
                     ;; snapshot.
 
                     (guix-service-type config =>
                                        (guix-configuration
                                         (inherit config)
                                         (guix (current-guix))))))))
 
  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
