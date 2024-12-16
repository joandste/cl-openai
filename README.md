# cl-openai

(Very) Simple WIP library to use OpenAI API with Common Lisp, can generate chats and images

Example using Serapeum's dict to write an API call with lisp datastructures:
```
(create-chat-completion (dict :model "gpt-4o-mini"
                              :messages (list
                                            (dict :role "user"
                                                  :content "hello chatgpt"))))
```

A simple function that answers to the user with option to specify model:
```
(defun get-message (response)
    (~>> response
        (gethash "choices")
        ((lambda (vector) (svref vector 0)))
        (gethash "message")
        (gethash "content")))

(defun answer (question-string &key (model "gpt-4o-mini"))
    (get-message 
        (create-chat-completion
            (dict :model model
                  :messages (list
                                (dict :role "user"
                                      :content question-string))))))
```