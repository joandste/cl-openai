(ql:quickload :jonathan)
(ql:quickload :dexador)

(defvar openai-url "https://api.openai.com/v1/chat/completions")
(defvar api-key (uiop:getenv "OPENAI_API_KEY"))


(defun create-completion (list)
    "generates response, expects an assoc list specifying arguments exactly like py/js sdk"
    (let ((json (jonathan:to-json list)))
        (dex:post openai-url :headers `(("Content-Type" . "application/json")
                                        ("Authorization" . ,(concatenate 'string "Bearer" api-key)))
                             :content json)))

(defun answer-user-question (question-string &key (model "gpt-4o-mini"))
    "answers the users question, simple as that. Uses gpt-4o-mini by default"
    (create-completion `(:model ,model :messages (:role user :content ,question-string))))


(create-completion '(:model "gpt-4o" :messages (:role user :content "hello gipppity")))

(jonathan:to-json '(("model" . "gpt-4o-mini") ("messages" . (("role" . "user") ("content" . "hello gipppity")))) :from :alist)