(defpackage #:openai
    (:use :cl :alexandria :serapeum)
    (:import-from #:dex #:com.inuoe.jzon)
    (:export #:create-completion #:answer))