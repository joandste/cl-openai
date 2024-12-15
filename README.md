# cl-openai

(Very) Simple WIP library to use OpenAI API with Common Lisp

Examples using Serapeum's dict to write a concise API call:
```
(create-completion (dict :model "gpt-4o-mini"
                         :messages (list
                                    (dict :role "user"
                                          :content "hello chatgpt"))))
```