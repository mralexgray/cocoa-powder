vpath %.m Empty
vpath %.xcdatamodeld Empty

MOMC = /Applications/Xcode.app/Contents/Developer/usr/bin/momc
MOMC_FLAGS = -XD_MOMC_SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk -MOMC_PLATFORMS iphonesimulator -MOMC_PLATFORMS iphoneos
LD = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -arch armv7 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk -L/Users/guingu/Desktop/Empty/build/Debug-iphoneos -F/Users/guingu/Desktop/Empty/build/Debug-iphoneos -filelist /Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphoneos/Empty.build/Objects-normal/armv7/Empty.LinkFileList -dead_strip -fobjc-arc -fobjc-link-runtime -miphoneos-version-min=6.1 -framework UIKit -framework Foundation -framework CoreGraphics -framework CoreData
CLANG = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
CLANG_FLAGS = -x objective-c \
	-arch armv7s \
	-fmessage-length=0 \
	-std=gnu99 \
	-fobjc-arc \
	-Wno-trigraphs \
	-fpascal-strings \
	-Os \
	-Wno-missing-field-initializers \
	-Wno-missing-prototypes \
	-Wreturn-type \
	-Wno-implicit-atomic-properties \
	-Wno-receiver-is-weak \
	-Wduplicate-method-match \
	-Wformat \
	-Wno-missing-braces \
	-Wparentheses \
	-Wswitch \
	-Wno-unused-function \
	-Wno-unused-label \
	-Wno-unused-parameter \
	-Wunused-variable \
	-Wunused-value \
	-Wempty-body \
	-Wuninitialized \
	-Wno-unknown-pragmas \
	-Wno-shadow \
	-Wno-four-char-constants \
	-Wno-conversion \
	-Wconstant-conversion \
	-Wint-conversion \
	-Wenum-conversion \
	-Wno-shorten-64-to-32 \
	-Wpointer-sign \
	-Wno-newline-eof \
	-Wno-selector \
	-Wno-strict-selector-match \
	-Wno-undeclared-selector \
	-Wno-deprecated-implementations \
	-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk \
	-fstrict-aliasing \
	-Wprotocol \
	-Wdeprecated-declarations \
	-g \
	-fvisibility=hidden \
	-Wno-sign-conversion \
	-miphoneos-version-min=6.1 \
	-iquote /Users/guingu/Desktop/Empty/build/Empty.build/Release-iphoneos/Empty.build/Empty-generated-files.hmap \
	-I/Users/guingu/Desktop/Empty/build/Empty.build/Release-iphoneos/Empty.build/Empty-own-target-headers.hmap \
	-I/Users/guingu/Desktop/Empty/build/Empty.build/Release-iphoneos/Empty.build/Empty-all-target-headers.hmap \
	-iquote /Users/guingu/Desktop/Empty/build/Empty.build/Release-iphoneos/Empty.build/Empty-project-headers.hmap \
	-I/Users/guingu/Desktop/Empty/build/Release-iphoneos/include \
	-I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include \
	-I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include \
	-I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include \
	-I/Users/guingu/Desktop/Empty/build/Empty.build/Release-iphoneos/Empty.build/DerivedSources/armv7s \
	-I/Users/guingu/Desktop/Empty/build/Empty.build/Release-iphoneos/Empty.build/DerivedSources \
	-F/Users/guingu/Desktop/Empty/build/Release-iphoneos \
	-DNS_BLOCK_ASSERTIONS=1 \
	-include Empty/Empty-Prefix.pch \
	-MMD \
	-MT dependencies
COMPILE.c = $(CLANG) $(CLANG_FLAGS)

%.o: %.m
	$(COMPILE.c) -MF $*.d --serialize-diagnostics $*.dia -o $@ -c $<

%.momd: %.xcdatamodeld
	$(MOMC) $(MOMC_FLAGS) $(realpath $<) $(shell pwd)/$@

.PHONY: debug
debug: main.o AppDelegate.o Empty.momd
	$(shell mkdir -p build/debug/Empty.app)
	$(LD) -o build/debug/Empty.app/Empty $?

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.dia
	rm -f *.d
	rm -r *.momd
