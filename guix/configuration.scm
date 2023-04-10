;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
(use-service-modules cups desktop networking ssh xorg)
(use-package-modules linux)

(operating-system
  (kernel linux-libre-5.15)
  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout (keyboard-layout "us" "dvorak"))
  (host-name "host")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "dave")
                  (comment "David")
                  (group "users")
                  (home-directory "/home/dave")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "i3-wm")
                          (specification->package "i3status")
                          (specification->package "dmenu")
                          (specification->package "st")
                          (specification->package "nss-certs")
                          (specification->package "icecat")
                          (specification->package "nss-certs")
                          (specification->package "vim")
                          (specification->package "keepassxc")
                          (specification->package "git")
                          (specification->package "flatpak")
                          (specification->package "python")
                          (specification->package "xclip")
                          (specification->package "emacs")
                          (specification->package "sakura")
			  )
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   %desktop-services)
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "66475178-98b8-4150-8d4c-081975376673")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "9C59-D9E8"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "3ea92a00-0f23-49cd-8088-9c39b17f6e9d"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
