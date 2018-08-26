(in-package :cl-user)
(defpackage core.web
  (:use :cl
        :caveman2
        :core.config
        :core.view
        :core.db
        :datafly
        :sxql
        :anaphora)
  (:export :*web*))
(in-package :core.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (render #P"index.html"))

(defvar *singleton-string-hash* (make-hash-table :test #'equal))
(defun singleton-string (str)
  (sif (gethash str *singleton-string-hash*)
      it
      (progn
        (setf it str))))

(defmethod respond ((sender string) (q (eql (singleton-string "chipbot core help"))))
  "help not implemented")
(defmethod respond ((sender string) (q t))
  (throw-code 404))

(defroute "/api/hear" (&key |q| |sender|)
  (unless (or |q| |sender|) (throw-code 404))
  (render-json `(:|q| ,|q| :|answer| ,(respond |sender| (singleton-string |q|)))))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (if (string= (gethash "accept" (request-headers *request*)) "application/json")
      (render-json `(:|error| "not found"))
      (merge-pathnames #P"_errors/404.html"
                       *template-directory*)))
