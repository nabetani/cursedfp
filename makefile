intel: log/gcc11-387-intel.txt log/gcc11-sse-intel.txt

log/gcc11-387-intel.txt: main.c
	mkdir -p log
	mkdir -p bin
	gcc-11 -std=c17 -Wall -mfpmath=387 -fexcess-precision=standard main.c -o bin/gcc11-387-intel
	bin/gcc11-387-intel > log/gcc11-387-intel.txt

log/gcc11-sse-intel.txt: main.c
	mkdir -p log
	mkdir -p bin
	gcc-11 -std=c17 -Wall -mfpmath=sse -msse2 -fexcess-precision=standard main.c -o bin/gcc11-sse-intel
	bin/gcc11-sse-intel > log/gcc11-sse-intel.txt
