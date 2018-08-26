(defsystem "core-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("core"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "core"))))
  :description "Test system for core"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
