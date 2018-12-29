CXXFLAGS+= -std=c++11
INC+=-I../G2S/include
LIB_PATH+=-L../G2S/build/c++-build
LDFLAGS+= -lg2s -lz

.DEFAULT:
	cd mpslib; bash ./configure.sh
	$(MAKE) -C mpslib $@

%.o: src/%.cpp
	$(CXX) -c -o $@ $< $(CFLAGS) $(CXXFLAGS) $(INC) $(LIBINC)

ds: ds.o
	$(CXX) -o $@ $^ $(LIB_PATH) $(LDFLAGS)

wrapper: ds
	echo test

install: wrapper
	echo test2
	#mkdir -p ../3party_bin/ && which deesseOMP 2>/dev/null | xargs -I{} ln -s {} ../3party_bin/deesseOMP 2>/dev/null || exit 0

algoNames:
	ln -sf ../algosName.config algosName.config

clean:
	rm -rf *.o
	rm ds