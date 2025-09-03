ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = GuDestroyerPrefs

GuDestroyerPrefs_FILES = GuDestroyerRootListController.m
GuDestroyerPrefs_FRAMEWORKS = UIKit Foundation
GuDestroyerPrefs_INSTALL_PATH = /Library/PreferenceBundles
GuDestroyerPrefs_CFLAGS = -fobjc-arc
GuDestroyerPrefs_LDFLAGS = -lprefs

include $(THEOS_MAKE_PATH)/bundle.mk
