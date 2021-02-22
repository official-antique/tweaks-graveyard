ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:latest
INSTALL_TARGET_PROCESSES = UIKit

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Inset
Inset_FILES = Tweak.x
Inset_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
