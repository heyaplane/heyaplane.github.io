(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(package-install 'htmlize)
(setq org-html-htmlize-output-type 'css)

(require 'ox-publish)

(setq org-publish-project-alist
      (list
       (list "site"
            :recursive t
            :base-directory "./content"
            :publishing-directory "./docs"
            :publishing-function 'org-html-publish-to-html
            :with-author nil
            :with-creator t
            :with-toc nil
            :section-numbers nil
            :time-stamp-file nil
            )
       (list "sb_files"
            :base-directory "../sb"
            :base-extension "none"
            :publishing-directory "./docs"
            :publishing-function 'org-html-publish-to-html
            :with-author nil
            :with-creator t
            :with-toc nil
            :section-numbers nil
            :time-stamp-file nil
            :include '(
                      "org_to_website.org"
             ))
       (list "site_all"
            :components '("site" "sb_files")
             )))

(setq org-html-validation-link nil)
(setq org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"rethink.css\" />"
      )
(setq org-html-preamble
      "<nav id=navbar>
        <ul>
         <li><a href=\"index.html\">Home</a></li>
         <li><a href=\"index.html\">About</a></li>
        </ul>
       </nav>"
      )

(org-publish-all t)

(message "Build complete!")
