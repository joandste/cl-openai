(defpackage :openai
    (:use :cl :alexandria :serapeum)
    (:export #:chat-completion #:generate-image #:*api-url* #:api-request #:list-models))

(in-package :openai)

(defparameter *api-url* "https://api.openai.com/v1")

(defun api-request (method url &optional (params nil))
    "calls openai api with correct headers. Expects hashmap, returns hashmap"
    (com.inuoe.jzon:parse
        (dex:request url
            :method method
            :headers (list (cons "Content-Type" "application/json")
                           (cons "Authorization" (concat "Bearer " (uiop:getenv "OPENAI_API_KEY"))))
            :content (when params (com.inuoe.jzon:stringify params)))))

(defun chat-completion (params)
    "generates chat completion, expects a hashmap specifying arguments exactly like py/js sdk. Returns a hashmap with the completions"
    (api-request :POST (concat *api-url* "/chat/completions") params))

(defun generate-image (params)
    "generates image, expects a hashmap specifying arguments exactly like py/js sdk. Returns a hashmap with urls to images"
    (api-request :POST (concat *api-url* "/images/generations") params))

(defun list-models (&optional (model nil))
    "list all available models"
    (api-request :GET (concat *api-url* "/models" (when model (concat "/" model)))))
