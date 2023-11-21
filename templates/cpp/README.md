## simple cpp template with Makefile

1. external libs are stored in `libs.mk`
2. update `LIB_DIR` in `Makefile` to your path
3. build file: `make build script_name`
4. build and run file: `make run file=script_name`
5. build and run file with local dependencies: `make run file=script_name deps=local_dep1,local_dep2`
6. clean build directory with `make clean`
7. assets are copied from `./assets` into `.build/assets`