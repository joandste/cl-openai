(in-package #:openai)

(defvar api-url "https://api.openai.com/v1/chat/completions")
(defvar api-key (uiop:getenv "OPENAI_API_KEY"))

(defun get-message (response)
    (~>> response
        (gethash "choices")
        ((lambda (vector) (svref vector 0)))
        (gethash "message")
        (gethash "content")))

(defun create-completion (params)
    "generates response, expects a hashmap specifying arguments exactly like py/js sdk. Returns a hashmap"
    (com.inuoe.jzon:parse
        (dex:post api-url :headers (list (cons "Content-Type" "application/json")
                                         (cons "Authorization" (concatenate 'string "Bearer " api-key)))
                          :content (com.inuoe.jzon:stringify params))))

(defun answer (question-string &key (model "gpt-4o-mini"))
    "answers the users question, simple as that. Uses gpt-4o-mini by default"
    (get-message 
        (create-completion (dict :model model
                                 :messages (list
                                            (dict :role "user"
                                                  :content question-string))))))
