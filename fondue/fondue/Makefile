ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:latest

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Fondue
Fondue_FILES = FUIRootListController.m
Fondue_FRAMEWORKS = UIKit
Fondue_PRIVATE_FRAMEWORKS = Preferences
Fondue_INSTALL_PATH = /Library/PreferenceBundles
Fondue_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
