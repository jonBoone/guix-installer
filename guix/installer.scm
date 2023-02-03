;;; Copyright @ 2023 Iain Boone <ipmonger@delamancha.org>
;;; Copyright © 2019 Alex Griffin <a@ajgrf.com>
;;; Copyright © 2019 Pierre Neidhardt <mail@ambrevar.xyz>
;;; Copyright © 2019 David Wilson <david@daviwil.com>
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; Generate a bootable image (e.g. for USB sticks, etc.) with:
;; $ guix system image -t iso9660 installer.scm

(define-module (nongnu system install)
  #:use-module (gnu system)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages emacs)
  #:use-module (gnu system install)
  #:use-module (gnu services)
;;;  #:use-mobile (gnu)
;;;  #:use-module (gnu packages linux)
  #:use-module (guix)
;;;  #:use-module (guix build-system trivial)
;;;  #:use-module (guix download)
;;;  #:use-module (guix git-download)
;;;  #:use-module (guix packages)
;;;  #:use-module (guix store)
;;;  #:use-module (guix transformations)
;;;  #:use-module (nongnu packages linux)
;;;  #:use-module (nongnu packages nvidia)
   #:export (installation-os-nonfree)
  )

;;;(define transform
;;;  (options->transformation
;;;   '((with-graft . "mesa=vnda"))))

(define installation-os-nonfree
  (operating-system
    (inherit installation-os)
;;;    (kernel linux)
;;;    (firmware (list linux-firmware))

    ;; Add the 'net.ifnames' argument to prevent network interfaces
    ;; from having really long names.  This can cause an issue with
    ;; wpa_supplicant when you try to connect to a wifi network.
;;;    (kernel-arguments '("quiet" "modprobe.blacklist=nouveau" "net.ifnames=0"))
;;;    (kernel-loadable-modules (list nvidia-driver))

    (services
     (cons*
;;;      (simple-service 'custom-udev-rules udev-service-type
;;;		      (list nvidia-driver))
;;;      (service kernel-module-loader-service-type
;;;	       '("ipmt_devinft"
;;;		 "nvidia"
;;;		 "nvidia_modeset"
;;;		 "nvidia-uvm"))
;;;      (simple-service slim-service-type
;;;		      (slim-configuration
;;;		       (display ":0")
;;;		       (vt "vt8")
;;;		       (xorg-configuration (xorg-configuration
;;;					    (keyboard-layout (keyboard-layout "us" #:options '("crtl:nocaps")))
;;;					    (extra-config (list %xorg-libinput-config))
;;;					    (modules (cons* nvidia-driver %default-xorg-modules))
;;;					    (server (transform xorg-server))
;;;					    (drivers '("nvidia"))))))
      ;; Include the channel file so that it can be used during installation
      (simple-service 'channel-file etc-service-type
                      (list `("channels.scm" ,(local-file "channels.scm"))))
      (operating-system-user-services installation-os)))

    ;; Add some extra packages useful for the installation process
    (packages
     (append (list git curl stow vim emacs-no-x-toolkit)
             (operating-system-packages installation-os)))))

installation-os-nonfree
