# S3.el

Interact with AWS S3 from Emacs

## Installation

Copy s3.el into your Emacs source directory, set `s3-access-key` and `s3-secret-key` to appropriate values and add this to your .emacs:

```elisp
(autoload 's3 "s3" "Interact with Amazon Web Services S3" t nil)
```

### Prerequisites

Install `hmac-sha1` from [http://www.emacswiki.org/emacs/HmacShaOne](http://www.emacswiki.org/emacs/HmacShaOne).

## Usage

Call `s3-get-url` to generate a GET URL. Expiration defaults to 24 hours.

## To Do

(A lot.)

+  Add downloading/buffer insertion
+  Add post-buffer-to-S3
+  S3 bucket listing
+  S3 key deletion

## License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with GNU Emacs; see the file COPYING.  If not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
