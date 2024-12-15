(asdf:defsystem "openai"
  :description "OpenAI with Common Lisp"
  :author "Jonathan"
  :license "BSD-2-Clause"
  :depends-on ("alexandria" "serapeum" "dex" "com.inuoe.jzon")
  :components ((:file "openai")))