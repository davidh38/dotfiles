
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
                          (specification->package "sakura")
                          (specification->package "icecat")
                          (specification->package "vim")
                          (specification->package "keepassxc")
                          (specification->package "git")
                          (specification->package "flatpak")
                          (specification->package "python")
                          (specification->package "xclip")
                          (specification->package "emacs")
                          (specification->package "thefuck")
                          (specification->package "emacs-exwm")
                          (specification->package "emacs-desktop-environment")
                          (specification->package "docker")
                          (specification->package "docker-cli")
                          (specification->package "xrandr")
                          (specification->package "unzip")
                          (specification->package "openssh")			  
			  )
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  ;; use 'sudo blkid' and search TYPE swap
  (services
  %desktop-services)
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "1c9df0b1-a65f-4578-9123-54d1d469cfb9")))))
				 
  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'sudo blkid' in a terminal.
 (file-systems (cons* (file-system
                       (mount-point "/boot/efi")
                       (device (uuid "9C59-D9E8"
                                    'fat32))
                    (type "vfat"))
                  (file-system
                  (mount-point "/")
                  (device (uuid
                          "8b2817ac-a4a1-47ff-bfec-0aa5b1c82728"
                         'ext4))
				                      (type "ext4")) %base-file-systems))
  )
