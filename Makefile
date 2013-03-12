.PHONY: sim clean

vpath %.m src
vpath %.m src/app
vpath %.xcdatamodeld lib
vpath %.png lib/img
vpath %.plist etc

DEV = /Applications/Xcode.app/Contents/Developer
TOOLS = $(DEV)/Toolchains/XcodeDefault.xctoolchain/usr/bin
MOMC = $(DEV)/usr/bin/momc
CC = $(TOOLS)/clang
LD = $(TOOLS)/clang
DSYMUTIL = $(TOOLS)/dsymutil
PREFIX = src/app.pch

PRODNAME = AnApp
COMPANY = qmoya
BUNDLEID = $(COMPANY).$(PRODNAME)
BUNDLEVERSION = 1.0
BUNDLESHORTVERSIONSTRING = 1.0
BUNDLEEXECUTABLE = $(PRODNAME)
BUNDLENAME = $(PRODNAME)
BUNDLEDISPLAYNAME = $(PRODNAME)
PLATFORMNAME = iphonesimulator
SDKVERSION = 6.1
SDKNAME = $(PLATFORMNAME)$(SDKVERSION)

CCFLAGS = -x objective-c -arch i386 -fmessage-length=0 -std=gnu99 -fobjc-arc -Wno-trigraphs -fpascal-strings -O0 -Wno-missing-field-initializers -Wno-missing-prototypes -Wreturn-type -Wno-implicit-atomic-properties -Wno-receiver-is-weak -Wduplicate-method-match -Wformat -Wno-missing-braces -Wparentheses -Wswitch -Wno-unused-function -Wno-unused-label -Wno-unused-parameter -Wunused-variable -Wunused-value -Wempty-body -Wuninitialized -Wno-unknown-pragmas -Wno-shadow -Wno-four-char-constants -Wno-conversion -Wconstant-conversion -Wint-conversion -Wenum-conversion -Wno-shorten-64-to-32 -Wpointer-sign -Wno-newline-eof -Wno-selector -Wno-strict-selector-match -Wno-undeclared-selector -Wno-deprecated-implementations -DDEBUG=1 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk -fexceptions -fasm-blocks -fstrict-aliasing -Wprotocol -Wdeprecated-declarations -g -Wno-sign-conversion -fobjc-abi-version=2 -fobjc-legacy-dispatch -mios-simulator-version-min=6.1 -iquote /Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/Empty-generated-files.hmap -I/Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/Empty-own-target-headers.hmap -I/Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/Empty-all-target-headers.hmap -iquote /Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/Empty-project-headers.hmap -I/Users/guingu/Desktop/Empty/build/Debug-iphonesimulator/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include -I/Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/DerivedSources/i386 -I/Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/DerivedSources -F/Users/guingu/Desktop/Empty/build/Debug-iphonesimulator -include $(PREFIX) -MMD -MT dependencies -MF /Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/Objects-normal/i386/AppDelegate.d --serialize-diagnostics /Users/guingu/Desktop/Empty/build/Empty.build/Debug-iphonesimulator/Empty.build/Objects-normal/i386/AppDelegate.dia
MOMCFLAGS = -XD_MOMC_SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk -XD_MOMC_IOS_TARGET_VERSION=6.1 -MOMC_PLATFORMS iphonesimulator -MOMC_PLATFORMS iphoneos -XD_MOMC_TARGET_VERSION=10.6
LDFLAGS = -arch i386 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk -Xlinker -objc_abi_version -Xlinker 2 -fobjc-arc -fobjc-link-runtime -Xlinker -no_implicit_dylibs -mios-simulator-version-min=6.1 -framework UIKit -framework Foundation -framework CoreGraphics -framework CoreData

%.o: %.m
	$(CC) $(CCFLAGS) -MF $*.d --serialize-diagnostics $*.dia -o $@ -c $<

%.momd: %.xcdatamodeld
	$(MOMC) $(MOMCFLAGS) $(realpath $<) $(shell pwd)/$@

sim: Empty.app Empty.app.dsym
	waxsim Empty.app

Info.plist: debug.plist
	cp $< Info.plist

Empty.app: Empty db.momd Default-568h@2x.png Default.png Info.plist
	mkdir -p Empty.app
	mv db.momd Empty.app
	mv Empty Empty.app
	mv Info.plist Empty.app
	cp lib/img/*.png Empty.app

Empty.app.dsym:
	$(DSYMUTIL) Empty.app/Empty -o Empty.app.dSYM

%.png:
	cp $@ Empty.app

Empty: delegate.o main.o 
	$(LD) $(LDFLAGS) -o Empty $?

clean:
	rm -f *.o
	rm -f *.dia
	rm -f *.d
	rm -rf *.momd
	rm -rf build
	rm -rf Empty.app
	rm -rf Empty.app.dsym

