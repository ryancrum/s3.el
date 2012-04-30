;;; s3.el --- Interact with Amazon Web Services S3

;; Copyright (C) 2012 Ryan Crum

;; Author: Ryan Crum
;; URL: http://github.com/thorstadt/s3.el
;; Version: 0.1-super-early-pre-alpha
;; Created: 2012-04-30
;; Keywords: convenience

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; This currently just generates an S3 URL, given a bucket and a key.

;;; Install

;; To install, copy this file into your Emacs source directory, set
;; `s3-access-key' and `s3-secret-key' to
;; appropriate values, and add this to your .emacs file

;; (autoload 's3 "s3" "Interact with Amazon Web Services S3" t nil)


;; NOTE: Make sure you grab and install `hmac-sha1' from
;; http://www.emacswiki.org/emacs/HmacShaOne

;;; Usage

;; Call `s3-get-url' to generate a GET url. Expiration of URL defaults
;; to 24 hours

;;; Todo:

;; Add downloading/buffer insertion
;; Add post-buffer-to-S3
;; S3 bucket listing
;; S3 key deletion

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:


(require 'hmac-sha1) ;; http://www.emacswiki.org/emacs/HmacShaOne

(defvar s3-access-key
  ""
  "Your AWS S3 Access Key")

(defvar s3-secret-key
  ""
  "Your AWS S3 Secret Key")

(defun s3-canonical-string (bucket key &optional expiration method md5 content-type)
  (string-make-unibyte
   (concat
    (or method "GET")
    "\n"
    (or md5 "")
    "\n"
    (or content-type "")
    "\n"
    (or expiration "")
    "\n/"
    bucket
    "/"
    key)))

(defun s3-get-url (bucket key &optional expiration)
  (interactive)
  (let* ((expiration (number-to-string
                      (or expiration
                          (+ 86400 ;; 1 day
                             (string-to-int
                              (format-time-string "%s"))))))
         (canon (s3-canonical-string bucket key expiration))
         (signature (base64-encode-string
                     (hmac-sha1 s3-secret-key canon))))
    (concat
     "https://"
     bucket
     ".s3.amazonaws.com/"
     key
     "?AWSAccessKeyId="
     s3-access-key
     "&Signature="
     (url-hexify-string signature)
     "&Expires="
     expiration)))

(provide 's3)

