(asdf:defsystem #:openai
  :description "OpenAI with Common Lisp"
  :author "Jonathan"
  :license "BSD-2-Clause"
  :depends-on (#:uiop #:dex #:serapeum #:alexandria #:com.inuoe.jzon)
  :components ((:file "package")
               (:file "openai")))