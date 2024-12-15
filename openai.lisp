(defpackage :openai
    (:use :cl :alexandria :serapeum)
    (:export #:chat-completion #:generate-image #:*api-key*))

(in-package :openai)

(defvar api-url "https://api.openai.com/v1")
(defparameter *api-key* nil)
(defun get-api-key () (if *api-key*
                          (uiop:getenv "OPENAI_API_KEY")
                          *api-key*))

(defun chat-completion (params)
    "generates response, expects a hashmap specifying arguments exactly like py/js sdk. Returns a hashmap"
    (com.inuoe.jzon:parse
        (dex:post (concat api-url "/chat/completions")
            :headers (list (cons "Content-Type" "application/json")
                           (cons "Authorization" (concat "Bearer " (get-api-key))))
            :content (com.inuoe.jzon:stringify params))))

(defun generate-image (params)
    "generates image, expects a hashmap specifying arguments exactly like py/js sdk. Returns a hashmap with urls to images"
    (com.inuoe.jzon:parse
        (dex:post (concat api-url "/images/generations")
            :headers (list (cons "Content-Type" "application/json")
                           (cons "Authorization" (concat "Bearer " (get-api-key))))
            :content (com.inuoe.jzon:stringify params))))
