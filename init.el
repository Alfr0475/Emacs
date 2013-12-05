;;----------------------------------------------------------------------
;; Emacs Configuration
;;----------------------------------------------------------------------
;; Author           : $Author: koga $
;; Created On       : 2010-05-13 17:13:00
;; Last Modified On : $Date: 2011-05-26 18:37:58 +0900 (木, 26 5 2011) $
;; Revision         : $Rev: 17 $
;;----------------------------------------------------------------------

;;----------------------------------------------------------------------
;; File System
;;----------------------------------------------------------------------
;; +.emacs.d/
;;   + conf/             (設定ファイルディレクトリ)
;;   + dic/
;;     + lookup/         (lookup用の辞書)
;;   + elisp/            (同梱されてないElisp群)
;;   + etc/
;;     + howm/           (メモの実態置き場)
;;     + migemo/         (migemo用の辞書)
;;     + auto-complete/  (auto-complete用の辞書)
;;     + auto-insert/    (auto-insert用のテンプレ)
;;----------------------------------------------------------------------

;;----------------------------------------------------------------------
;; Must External Application
;;----------------------------------------------------------------------
;; C/Migemo
;; eblook
;; Firefox + MozRepl
;; apel
;;----------------------------------------------------------------------

;;----------------------------------------------------------------------
;; Elisp Editing History
;;----------------------------------------------------------------------
;; 2011-05-26 PHPとJavaScriptの開発環境設定が一応一段落
;; 2011-05-20 font設定をバージョン環境毎に分けた
;; 2010-05-24 anything.elに挑戦し始める
;; 2010-05-19 微妙にMeadowに対応し始める
;; 2010-05-13 まじめに拡張を始める
;;----------------------------------------------------------------------

;;----------------------------------------------------------------------
;; Todo
;;----------------------------------------------------------------------
;; 英単語辞書
;;   英辞郎は持ってるからどうにかできるようにしたい
;;
;; snippet系
;;   yasnippetあたりが定番かな？
;;
;; navi2ch
;;   2chブラウザが無いしなぁ・・・
;;
;; コンソール
;;   Linux上でEmacsガチは初めてだからいれておかないと
;;
;; バージョン管理系
;;   SVNとCVSあたりがあれば充分だよね。Gitもいるかな？
;;
;; IME設定
;;   イマイチWindows系でのIME設定がうまくいってない
;;
;; auto-insert
;;   上手いテンプレ構成考えないと・・・
;;----------------------------------------------------------------------

;;----------------------------------------------------------------------
;; 実行環境判別
;; http://d.hatena.ne.jp/hito-d/20060220#1140445790
;;----------------------------------------------------------------------
;; OSを判別
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))
(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin ;; cygwinもunixグループにしておく
  (equal system-type 'cygwin))
(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))
(defvar run-darwin (equal system-type 'darwin))

;; Emacsの種類とバージョンを判別
(defvar run-emacs20
  (and (equal emacs-major-version 20)
       (null (featurep 'xemacs))))
(defvar run-emacs21
  (and (equal emacs-major-version 21)
       (null (featurep 'xemacs))))
(defvar run-emacs22
  (and (equal emacs-major-version 22)
       (null (featurep 'xemacs))))
(defvar run-emacs23
  (and (equal emacs-major-version 23)
       (null (featurep 'xemacs))))
(defvar run-emacs24
  (and (equal emacs-major-version 24)
       (null (featurep 'xemacs))))
(defvar run-meadow (featurep 'meadow))
(defvar run-meadow1 (and run-meadow run-emacs20))
(defvar run-meadow2 (and run-meadow run-emacs21))
(defvar run-meadow3 (and run-meadow run-emacs22))
(defvar run-xemacs (featurep 'xemacs))
(defvar run-xemacs-no-mule
  (and run-xemacs (not (featurep 'mule))))
(defvar run-carbon-emacs (and run-darwin window-system))



;;----------------------------------------------------------------------
;; package configuration
;;----------------------------------------------------------------------
(cond ((and run-emacs24)
       (require 'package)
       (setq package-user-dir (concat user-emacs-directory "site-lisp"))
       (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
       (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
       (package-initialize)

       ;; インストールされていなければ自動でインストールを行う
       (require 'cl)
       (defvar installing-package-list
         '(
           anzu
           auto-async-byte-compile
           auto-complete
           browse-kill-ring
           csharp-mode
           dsvn
           editorconfig
           elscreen
           foreign-regexp
           fuzzy
           gh
           git-commit-mode
           git-rebase-mode
           helm
           helm-dired-recent-dirs
           helm-migemo
           helm-open-github
           init-loader
           js2-mode
           json-mode
           logito
           magit
           markdown-mode
           migemo
           multi-term
           open-junk-file
           org
           pcache
           php-mode
           popup
           pos-tip
           recentf-ext
           revive
           ruby-mode
           ruby-block
           ruby-electric
           session
           textile-mode
           wgrep
           yaml-mode
           yasnippet
           zencoding-mode
           ))
       (let ((not-installed (loop for x in installing-package-list
                                  when (not (package-installed-p x))
                                  collect x)))
         (when not-installed
           (package-refresh-contents)
           (dolist (pkg not-installed)
             (package-install pkg))))
       )
      )

;;----------------------------------------------------------------------
;; load-path configuration
;;----------------------------------------------------------------------
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/elisp")
        (expand-file-name "~/.emacs.d/elisp/navi2ch")
        (expand-file-name "~/.emacs.d/elisp/library")
        (expand-file-name "~/.emacs.d/elisp/library/apel")
        (expand-file-name "~/.emacs.d/elisp/library/emu")
        (expand-file-name "~/.emacs.d/elisp/mode")
        (expand-file-name "~/.emacs.d/elisp/mode/bat")
        (expand-file-name "~/.emacs.d/elisp/mode/pukiwiki")
        )
       load-path))

;;----------------------------------------------------------------------
;; load settings
;;----------------------------------------------------------------------
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")

;;----------------------------------------------------------------------
;; start server
;;----------------------------------------------------------------------
(require 'server)

(unless (server-running-p)              ; 複数サーバー起動を防ぐ
  (server-start))
