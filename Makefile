ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GuDestroyer

GuDestroyer_FILES = Tweak.xm
GuDestroyer_CFLAGS = -fobjc-arc
GuDestroyer_FRAMEWORKS = UIKit Foundation
GuDestroyer_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

# Установка entry.plist для PreferenceLoader
after-install::
	install.exec "mkdir -p /Library/PreferenceLoader/Preferences"
	install.exec "cp entry.plist /Library/PreferenceLoader/Preferences/"

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += gudestroyerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
