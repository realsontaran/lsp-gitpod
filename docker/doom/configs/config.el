;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; NOTE: This is a slimmed down version of doom-emacs/core/templates/config.example.el

(load "~/startup.el")
(setq user-full-name "penguin"
      user-mail-address "therealsontaran@protonmail.com")

;; (setq doom-font (font-spec :family "Terminus" :size 14 :weight 'normal)
;;       doom-big-font (font-spec :family "Terminus" :size 28 :weight 'normal)
;;       doom-unicode-font (font-spec :family "Noto Color Emoji")
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'normal)
;;      ;; doom-big-font (font-spec :family "JetBrains Mono" :size 20)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12 :weight 'normal)
;;      doom-unicode-font (font-spec :family "JuliaMono")
;;      doom-serif-font (font-spec :family "Fira Code" :size 12 :weight 'normal))

(setq doom-font (font-spec :family "Iosevka SS04" :size 14 :weight 'semi-light))

(setq display-line-numbers-type 'relative)
(setq doom-theme 'modus-operandi)
(setq fancy-splash-image "~/.config/doom/orangutan.png")

;; Transparency
;; (set-frame-parameter (selected-frame) 'alpha '(100 100))
;; (add-to-list 'default-frame-alist '(alpha 90 90))
(windmove-default-keybindings)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t)

(setq auth-sources '("~/.authinfo"))
(setq save-interprogram-paste-before-kill nil)
(setq evil-want-fine-undo t)

(map! :ne "M-/" #'comment-line)

(map! :leader
      :desc "Dired Jump"
      "[" #'dired-jump)
(map! :g "C-s" #'save-buffer)
(map! :after evil :gnvi "C-f" #'swiper)
(map! :gnvi "<C-tab>" #'evil-switch-to-windows-last-buffer)
(map! :gnvi "<C-tab>" #'evil-switch-to-windows-last-buffer)

(map! :leader
      (:prefix ("r" . "Org-Roam")
      :desc "Capture" "c" #'org-roam-capture
      :desc "DB Sync" "u" #'org-roam-db-sync
      :desc "Find" "f" #'org-roam-node-find
      :desc "Insert" "i" #'org-roam-node-insert
      :desc "Graph" "g" #'org-roam-graph
      :desc "Toggle Buffer" "t" #'org-roam-buffer-toggle
      :desc "Roam UI" "w" #'org-roam-ui-mode
      :desc "Org ID Update" "o" #'org-id-update-id-locations ))

(defun insert-current-date ()(interactive)
    (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(defun org-move-subtree-to-next-superior()
  "Moving subtree to next superior."
  (interactive)
  (org-promote-subtree)
  (org-move-subtree-down)
  (org-demote-subtree))

  (map!
   :map 'org-mode-map
   :localleader
   :ni "j" #'org-move-subtree-to-next-superior )

(remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config)
(after! (:and treemacs ace-window)
  (setq aw-ignored-buffers (delq 'treemacs-mode aw-ignored-buffers)))

(setq which-key-idle-delay 0.5)
(setq which-key-allow-multiple-replacements t)
(setq which-key-allow-imprecise-window-fit nil)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))))

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(setq ibuffer-saved-filter-groups
          (quote (("default"
                   ("dired" (mode . dired-mode))
                   ("C/C++" (or (mode . c-mode) (mode . cpp-mode)))
                   ("erc" (mode . erc-mode))
                   ("planner" (or
                               (name . "^\\*Calendar\\*$")
                               (name . "^diary$")
                               (mode . muse-mode)))
                   ("emacs" (or
                             (name . "^\\*scratch\\*$")
                             (name . "^\\*doom\\*$")
                             (name . "^\\*Messages\\*$")))
                   ("svg" (name . "\\.svg")) ; group by file extension
                   ("gnus" (or
                            (mode . message-mode)
                            (mode . bbdb-mode)
                            (mode . mail-mode)
                            (mode . gnus-group-mode)
                            (mode . gnus-summary-mode)
                            (mode . gnus-article-mode)
                            (name . "^\\.bbdb$")
                            (name . "^\\.newsrc-dribble")))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; (require 'org-bullets)
(remove-hook 'org-mode-hook #'org-superstar-mode)

(after! org
  (setq org-directory "~/Dropbox/org")
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files '("~/Dropbox/org/capture"))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE" "CNCL")
          (sequence "[ ]" "[-]" "|" "[X]")
          (sequence "LECTURE(l)" "|" "DONE")
          (type "PLAY" "READ" "WATCH" "ONIT" "|" "DONE")))
  ;; (setq org-todo-keyword-faces
  ;;       '(("TODO" . "orange")
  ;;         ("HOMWRK" . "orange")
  ;;         ("DONE" . "green")
  ;;         ("CNCL" . (:foreground "red" :weight bold))
  ;;         ("LECTURE" . "purple")
  ;;         ("PLAY" . "pink")
  ;;         ("READ" . "pink")
  ;;         ("WATCH" . "blue")
  ;;         ("ONIT" . "yellow")
  ;;         ("[ ]" . "orange")
  ;;         ("[-]" . "yellow")
  ;;         ("[X]" . "green")))

  ;; (add-hook 'org-mode-hook (lambda () (prettify-symbols-mode)))
  (setq org-ellipsis " ↴ "
        org-tags-column -80
        org-log-done 'time)

  (setq org-fancy-priorities-mode 'nil)
  (map!
   :map 'org-mode-map
   :localleader
   :ni "v" #'org-insert-clipboard-image ))

 ;; Create new Org buffer.
(evil-define-command evil-buffer-org-new (count file)
  "Creates a new ORG buffer replacing the current window, optionally
   editing a certain FILE"
  :repeat nil
  (interactive "P<f>")
  (if file
      (evil-edit file)
    (let ((buffer (generate-new-buffer "*new org*")))
      (set-window-buffer nil buffer)
      (with-current-buffer buffer
        (org-mode)))))
(map! :leader
      (:prefix "b"
       :desc "New empty ORG buffer" "o" #'evil-buffer-org-new))

(defun org-insert-clipboard-image ()
  "Insert screenshot to org file"
  (interactive)
  (make-directory "./resources/" :parents)
  (let ((filename (concat
                   (string-trim (file-name-nondirectory (buffer-file-name)) "[0-9]*-" ".[a-z]*")
                   "_" (format-time-string "%Y_%m_%d_%H%M%S") ".png")))
    (shell-command (concat "cd resources && " "xclip -selection clipboard -t image/png -o > " filename))
    (insert (concat "[[./resources/" filename "]]"))))

(defun my/modify-org-done-face ()
  (setq org-fontify-done-headline t)
  (set-face-attribute 'org-done nil :strike-through t)
  (set-face-attribute 'org-headline-done nil :strike-through t))

(eval-after-load "org"
  (add-hook 'org-add-hook 'my/modify-org-done-face))

(setq +org-habit-graph-window-ratio 0.5
      org-habit-show-done-always-green 't
      org-habit-graph-column 10)

(map! :leader
      (:prefix ("j" . "journal") ;; org-journal bindings
        :desc "Create new journal entry" "j" #'org-journal-new-entry
        :desc "Open previous entry" "p" #'org-journal-open-previous-entry
        :desc "Open next entry" "n" #'org-journal-open-next-entry
        :desc "Search journal" "s" #'org-journal-search-forever))

(setq org-journal-dir "~/Dropbox/org/journal/"
      org-journal-file-type 'weekly
      org-journal-file-format "%Y-W%W.org"
      org-journal-file-header "#+title: Weekly Journal W%W\n#+startup: folded\n"
      org-journal-time-format "%R"
      org-journal-date-format "%A, %B %d"
      org-journal-created-property-timestamp-format "%Y%m%d")

(setq +org-capture-notes-file "~/Dropbox/org/capture/notes.org"
      +org-capture-changelog-file "~/Dropbox/org/capture/changelog.org"
      +org-capture-todo-file "~/Dropbox/org/capture/todo.org"
      +org-capture-projects-file "~/Dropbox/org/capture/projects.org"
      +org-capture-journal-file "~/Dropbox/org/capture/journal.org")

(use-package! doct
  :commands (doct))

(after! org-capture
  (setq +org-capture-uni-units (condition-case nil
                                   (split-string (f-read-text "~/.org/.uni-units"))
                                 (error nil)))
  (defun +doct-icon-declaration-to-icon (declaration)
    "Convert :icon declaration to icon"
    (let ((name (pop declaration))
          (set  (intern (concat "all-the-icons-" (plist-get declaration :set))))
          (face (intern (concat "all-the-icons-" (plist-get declaration :color))))
          (v-adjust (or (plist-get declaration :v-adjust) 0.01)))
      (apply set `(,name :face ,face :v-adjust ,v-adjust))))

  (defun +doct-iconify-capture-templates (groups)
    "Add declaration's :icon to each template group in GROUPS."
    (let ((templates (doct-flatten-lists-in groups)))
      (setq doct-templates (mapcar (lambda (template)
                                     (when-let* ((props (nthcdr (if (= (length template) 4) 2 5) template))
                                                 (spec (plist-get (plist-get props :doct) :icon)))
                                       (setf (nth 1 template) (concat (+doct-icon-declaration-to-icon spec)
                                                                      "\t"
                                                                      (nth 1 template))))
                                     template)
                                   templates))))
  (setq doct-after-conversion-functions '(+doct-iconify-capture-templates))

(defun transform-square-brackets-to-round-ones(string-to-transform)
  "Transforms [ into ( and ] into ), other chars left unchanged."
  (concat
   (mapcar #'(lambda (c) (if (equal c ?\[) ?\( (if (equal c ?\]) ?\) c))) string-to-transform))
  )
(defun my/find-journal-tree ()
  (interactive)
  "Find or create my default journal tree"
  (setq hd (format-time-string "%A, %B %d"))
  (goto-char (point-min))
  (if (re-search-forward
       (format org-complex-heading-regexp-format (regexp-quote hd))
       nil t)
      (goto-char (point-at-bol))
    (goto-char (point-max))
    (or (bolp) (insert "\n"))
    (insert "* " hd "\n")
    (beginning-of-line 0))
  (org-end-of-line))

(defun set-org-capture-templates ()
    (setq org-capture-templates
          (doct `(
                 ("Protocol" :keys "p"
                   :file +org-capture-notes-file
                   :prepend t
                   :headline "Pocket Inbox"
                   :type entry
                   :immediate-finish t
                   :template ("* TODO %(transform-square-brackets-to-round-ones\"%:description\")"
                              "Source: [[%:link][link]]"
                              "Captured On: %U"
                              "#+BEGIN_QUOTE"
                              "%i"
                              "#+END_QUOTE")
                   )
                  ("Protocol Link" :keys "L"
                   :file +org-capture-notes-file
                   :prepend t
                   :headline "Pocket Inbox"
                   :type entry
                    :immediate-finish t
                   :template ("* TODO [[%:link][%(transform-square-brackets-to-round-ones\"%:description\")]]"
                    )
                   )
                  ("University" :keys "u"
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "University"
                   :type entry
                   :immediate-finish t
                   :template ("* TODO %?"
                              "DEADLINE: %^t"
                              )
                   )

                  ("Global Capture" :keys "g"
                   :file +org-capture-notes-file
                   :prepend t
                   :headline "Global Capture"
                   :type entry
                   :immediate-finish t
                   :template ("* %U"
                              "Source: %:description"
                              "#+BEGIN_QUOTE"
                              "%i"
                              "#+END_QUOTE"))
                  ("Journal Capture" :keys "j"
                   :file (lambda () (concat org-journal-dir (format-time-string "%Y-W%W") ".org"))
                   :type entry
                   :function my/find-journal-tree
                   :template ("** %<%R>"
                              "%?"))))))

  (set-org-capture-templates)
  (unless (display-graphic-p)
    (add-hook 'server-after-make-frame-hook
              (defun org-capture-reinitialise-hook ()
                (when (display-graphic-p)
                  (set-org-capture-templates)
                  (remove-hook 'server-after-make-frame-hook
                               #'org-capture-reinitialise-hook ))))))

(defun my/delete-capture-frame (&rest _)
  "Delete frame with its name frame-parameter set to \"capture\"."
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))
(advice-add 'org-capture-finalize :after #'my/delete-capture-frame)

(defun my/org-capture-frame (str)
  "Run org-capture in its own frame."
  (interactive)
  (require 'cl-lib)
  (select-frame-by-name "capture")
  (delete-other-windows)
  (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
    (condition-case err
        (org-capture)
      ;; "q" signals (error "Abort") in `org-capture'
      ;; delete the newly created frame in this scenario.
      (user-error (when (string= (cadr err) "Abort")
                    (delete-frame))))))

(map! :leader
      :desc "Org Agenda"
      "a" #'org-agenda-list)

(setq org-agenda-scheduled-leaders '("" "")
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-timestamp-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-remove-tags t
      org-agenda-compact-blocks t
      org-agenda-start-day "+0d")
;; (setq org-super-agenda-header-map evil-org-agenda-mode-map)
(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups
        '((:name "Routine and Chores"
           :tag "routine"
           :order 1)
          (:name "IMPORTANT"
           :priority "A"
           :order 2)
          (:name "School TODOS"
           :tag "todo"
           :order 3)
          (:name "Internet"
           :tag "internet"
           :order 3)
          (:name "Lectures"
           :todo "LECTURE"
           :order 4)
          (:name "Overdue"
           :deadline past
           :face error
           :order 7)
          (:name "Assignments"
           :tag "assignments"
           :order 10)
          (:name "Projects"
           :tag "idea"
           :order 14)
          (:name "To Read/Watch"
           :todo ("READ" "WATCH")
           :order 30)))
  (setq org-agenda-custom-commands
        '(("o" "Overview"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name "Today"
                            :time-grid t
                            :date today
                            :scheduled today
                            :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Routine and Chores"
                             :tag "routine"
                             :order 1)
                            (:name "Due Today"
                             :deadline today
                             :order 2)
                            (:name "Important"
                             :priority "A"
                             :order 3)
                            (:name "Lectures"
                             :todo "LECTURE"
                             :order 4)
                            (:name "Overdue"
                             :deadline past
                             :face error
                             :order 7)
                            (:name "Assignments"
                             :tag "assignment"
                             :order 10)
                            (:name "Projects"
                             :tag "idea"
                             :order 14)
                            (:name "To Read/Watch"
                             :todo ("READ" "WATCH")
                             :order 30)))))))))
  :config
  (org-super-agenda-mode))

(set 'org-habit-show-all-today t)

(defun my/org-export-agenda ()
  "Export agenda to html"
  (interactive)
  (org-agenda-list)
  (org-agenda-write "~/Dropbox/org/agenda.html")
  (kill-buffer "*Org Agenda*"))

(setq org-clock-sound "~/.config/doom-emacs/ding.wav")

(use-package! dired
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(map! :leader :desc "find-file-other-window" "d" #'find-file-other-window)
;; Make windmove work in Org mode:
;; (add-hook 'org-shiftup-final-hook 'windmove-up)
;; (add-hook 'org-shiftleft-final-hook 'windmove-left)
;; (add-hook 'org-shiftdown-final-hook 'windmove-down)
;; (add-hook 'org-shiftright-final-hook 'windmove-right)

(setq TeX-auto-untabify 't)
(setq TeX-parse-self 't)
(defun save-latex-and-export ()
  (interactive)
  (save-buffer)
  (org-latex-export-to-pdf))
(map!
 :map 'org-mode-map
 :localleader
 :ni "k" #'save-latex-and-export)
(setq-default TeX-master "main")

(require 'org-roam)
(setq org-roam-v2-ack t)
(setq org-roam-directory "~/Dropbox/org/roam")
;; (setq org-roam-dailies-directory "journal/")
(server-start)
(require 'org-protocol)
(require 'org-id)
(setq org-id-track-globally t)
(setq org-id-locations-file "~/Dropbox/org/.orgids")
(add-hook! 'org-roam-mode-hook #'org-id-update-id-locations)

(setq org-roam-db-node-include-function
      (lambda ()
        (not (member "DO_NOT_ORG_ROAM" (org-get-tags)))))

(add-to-list 'display-buffer-alist
    '("\\*org-roam\\*"
        (display-buffer-in-side-window)
        (side . right)
        (slot . 0)
        (window-width . 0.25)
        (preserve-size . (t nil))
        (window-parameters . ((no-other-window . t)
                              (no-delete-other-windows . t)))))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
    :hook (org-roam . org-roam-ui-mode)
    :config)

(setq org-roam-ui-follow nil)

(defun fold-level-2 ()
    (interactive)
    (set-selective-display (* 2 tab-width)))

(setq lsp-clients-clangd-args '("-j=2"
                "--background-index"
                "--clang-tidy"
                "--completion-style=detailed"
                "--header-insertion=never"
                "--header-insertion-decorators=0"
                "--inlay-hints=true"))

(after! lsp-clangd (set-lsp-priority! 'clangd 1))

(setq org-notifications-notify-before-time 60
      org-notifications-title "Org Mode Task")

(setq dap-auto-configure-mode t
      dap-auto-configure-features '(sessions locals breakpoints expressions tooltip))

(require 'dap-lldb)
(setq dap-lldb-debug-program '("/usr/bin/lldb-vscode"))
;;; ask user for executable to debug if not specified explicitly (c++)
(setq dap-lldb-debugged-program-function (lambda () (read-file-name "Select file to debug.")))

;;; default debug template for (c++)
(dap-register-debug-template
 "C++ LLDB dap"
 (list :type "cppdbg"
       :cwd nil
       :args nil
       :request "launch"
       :program nil))

(map! "M-h" #'windmove-left
      "M-l" #'windmove-right
      "M-j" #'windmove-down
      "M-k" #'windmove-up
      )

(add-hook 'delete-terminal-functions (lambda (terminal) (recentf-save-list)))

(add-hook 'kill-emacs-hook #'(lambda ()
                               (setq-local savehist-additional-variables '(command-history))
                               (savehist-save)
                               (recentf-save-list)))

;; (setq vterm-shell "/usr/bin/zsh")

(defun create-c-header-source-files (filename)
  "Create a .c and .h file pair in the current directory with the given filename."
  (interactive "sEnter the base filename: ")
  (let* ((c-file (concat filename ".c"))
         (h-file (concat filename ".h")))
    (find-file c-file)
    (insert (format "#include \"%s\"\n\n" h-file))
    (save-buffer)
    (find-file h-file)
    (insert (format "#ifndef %s_H_\n#define %s_H_\n\n\n#endif // %s_H_\n" (upcase filename) (upcase filename) (upcase filename)))
    (save-buffer)
    (message "Created %s and %s" c-file h-file)))

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
