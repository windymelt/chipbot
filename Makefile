.PHONY: setup-libraries distclean-libraries


bundle-libraries: core/bundle-libs/bundle-info.sexp

core/bundle-libs/bundle-info.sexp: core/qlfile.lock core/quicklisp
	/usr/bin/docker-compose run --rm core qlot bundle

core/quicklisp : core/qlfile
	/usr/bin/docker-compose run --rm core qlot install


distclean-libraries:
	rm -rf core/quicklisp core/bundle-libs
