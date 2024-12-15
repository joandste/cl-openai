(ql:quickload :dexador)
(ql:quickload :alexandria)
(ql:quickload :shasht)

(defvar openai-url "https://api.openai.com/v1/chat/completions")
(defvar api-key (uiop:getenv "OPENAI_API_KEY"))


(defparameter shasht:*write-plist-as-object* t)
(defparameter shasht:*symbol-name-function* (lambda (symbol) (string-downcase (symbol-name symbol))))


(defun create-completion (plist)
    "generates response, expects an plist specifying arguments exactly like py/js sdk"
    (shasht:read-json
        (dex:post openai-url :headers `(("Content-Type" . "application/json")
                                        ("Authorization" . ,(concatenate 'string "Bearer " api-key)))
                             :content (shasht:write-json plist nil))))

(defun answer-user-question (question-string &key (model "gpt-4o-mini"))
    "answers the users question, simple as that. Uses gpt-4o-mini by default"
    (create-completion `(:model ,model
                         :messages ((:role "user"
                                     :content ,question-string)))))


(create-completion '(:model "gpt-4o-mini" :messages ((:role "user" :content "hi"))))

(answer-user-question "whats 2+2")