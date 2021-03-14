ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:latest
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Blots
Blots_FILES = Tweak.x $(wildcard Classes/*.m)
Blots_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS = blots
include $(THEOS_MAKE_PATH)/aggregate.mk
