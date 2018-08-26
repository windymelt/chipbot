.PHONY: setup-libraries

bundle-libraries: core/bundle-libs/bundle-info.sexp

core/bundle-libs/bundle-info.sexp: core/qlfile.lock
	/usr/bin/docker-compose run --rm core qlot bundle

core/qlfile.lock: core/qlfile
	/usr/bin/docker-compose run --rm core qlot install
