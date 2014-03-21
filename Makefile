CXXFLAGS = -Ofast -std=c++11 -Wall -Wno-unused-function
LIBS = `pkg-config --libs jack`
INCLUDE = -I/usr/local/include/ -I/usr/include `pkg-config --cflags jack`

GCC = g++

SOURCES = jack_volume.cpp
OBJS = $(SOURCES:.cpp=.o) /usr/local/lib/libOSC++.a
TARGET = jack-volume

all: $(OBJS)
	$(GCC) -o $(TARGET) $(OBJS) $(LIBS)

install: $(TARGET)
	cp -f $(TARGET) /usr/local/bin/
	cp -f jvctl.py /usr/local/bin/jvctl
	chmod a+rx /usr/local/bin/$(TARGET)
	chmod a+rx /usr/local/bin/jvctl

clean:
	rm -f $(SOURCES:.cpp=.o) $(TARGET)

%.o:%.cpp
	$(GCC) $(CXXFLAGS) $(INCLUDE) -c $< -o $@
