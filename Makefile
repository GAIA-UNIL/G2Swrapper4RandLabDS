CXXFLAGS+= -std=c++11
INC+=-I../../../include
LIB_PATH+=-L$(DEST_DIR_EXTENSION)
LDFLAGS+= -lg2s -lz

%.o: src/%.cpp 
	$(CXX) -c -o $@ $< $(CFLAGS) $(CXXFLAGS) $(INC) $(LIBINC)

ds: ds.o
	$(CXX) -o $@ $^ $(LIB_PATH) $(LDFLAGS)

build: ds
	echo test

install: build
	cp -f ds $(DEST_DIR_EXTENSION)
	mkdir -p $(DEST_DIR_EXTENSION)/../3party_bin/ && which deesseOMP 2>/dev/null | xargs -I{} ln -s {} $(DEST_DIR_EXTENSION)/../3party_bin/deesseOMP 2>/dev/null || exit 0

algoNames:
	ln -sf ../algosName.config algosName.config

clean:
	rm -rf *.o
	rm -r ds