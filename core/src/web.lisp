(in-package :cl-user)
(defpackage core.web
  (:use :cl
        :caveman2
        :core.config
        :core.view
        :core.db
        :datafly
        :sxql)
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

(defroute "/api/hear" (&key |q| |sender|)
  (if (equal |q| "chipbot ping")
      (render-json `(:|q| ,|q| :|answer| "chipbot pong!"))
      (throw-code 404)))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
