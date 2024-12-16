(defpackage :openai
    (:use :cl :alexandria :serapeum)
    (:export #:create-chat-completion #:create-image #:*api-url* #:*api-timeout* #:api-request #:list-models))

(in-package :openai)

(defparameter *api-url* "https://api.openai.com/v1")
(defparameter *api-timeout* 100)

(defun api-request (method url &optional (params nil))
    "calls openai api with correct headers. Expects hashmap, returns hashmap"
    (com.inuoe.jzon:parse
        (dex:request url
            :method method
            :connect-timeout *api-timeout*
            :read-timeout *api-timeout*
            :headers (list (cons "Content-Type" "application/json")
                           (cons "Authorization" (concat "Bearer " (uiop:getenv "OPENAI_API_KEY"))))
            :content (when params (com.inuoe.jzon:stringify params)))))

(defun create-chat-completion (params)
    "generates chat completion, expects a hashmap specifying arguments exactly like py/js sdk. Returns a hashmap with the completions"
    (api-request :POST (concat *api-url* "/chat/completions") params))

(defun create-image (params)
    "generates image, expects a hashmap specifying arguments exactly like py/js sdk. Returns a hashmap with urls to images"
    (api-request :POST (concat *api-url* "/images/generations") params))

(defun list-models (&optional (model nil))
    "list all available models"
    (api-request :GET (concat *api-url* "/models" (when model (concat "/" model)))))

(defun create-thread (params)
      "create threads"
      (api-request :POST (concat *api-url* "/threads") params))

(defun retrieve-thread (thread)
    "get thread"
    (api-request :GET (concat *api-url* "/threads" "/" thread)))

(defun create-message (thread params)
    "create message"
    (api-request :POST (concat *api-url* "/threads" "/" thread) params))
