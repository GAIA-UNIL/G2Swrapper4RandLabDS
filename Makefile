CXXFLAGS+= -std=c++11
INC+=-I../../../include
LIB_PATH+=-L$(DEST_DIR_EXTENSION)
LDFLAGS+= -lg2s -lz

%.o: src/%.cpp 
	$(CXX) -c -o $@ $< $(CFLAGS) $(CXXFLAGS) $(INC) $(LIBINC)

ds_randLab: ds.o
	$(CXX) -o $@ $^ $(LIB_PATH) $(LDFLAGS)

build: ds_randLab
	echo "build ds_randLab"

install: build
	cp -f ds_randLab $(DEST_DIR_EXTENSION)
	mkdir -p $(DEST_DIR_EXTENSION)/../3party_bin/ && which deesseOMP 2>/dev/null | xargs -I{} ln -s {} $(DEST_DIR_EXTENSION)/../3party_bin/deesseOMP 2>/dev/null || exit 0
	echo "ds	./ds_randLab	-ti,-di" >> $(DEST_DIR_EXTENSION)/algosName.config
	echo "DirectSampling	./ds_randLab	-ti,-di" >> $(DEST_DIR_EXTENSION)/algosName.config
	echo "DS	./ds_randLab	-ti,-di" >> $(DEST_DIR_EXTENSION)/algosName.config

algoNames:
	ln -sf ../algosName.config algosName.config

clean:
	rm -rf *.o
	rm -rf ds_randLab