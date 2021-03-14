ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:latest
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Fondue
Fondue_FILES = Tweak.x $(wildcard Classes/*.m)
Fondue_FRAMEWORKS = CoreGraphics UIKit
Fondue_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += fondue
include $(THEOS_MAKE_PATH)/aggregate.mk
