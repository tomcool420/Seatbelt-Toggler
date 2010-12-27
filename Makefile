export FW_DEVICE_IP=AppleTV.local
export GO_EASY_ON_ME=1
include $(THEOS)/makefiles/common.mk



BUNDLE_NAME = SeatbeltToggler
SeatbeltToggler_FILES =   MLoader.m 
SeatbeltToggler_INSTALL_PATH = /Library/SettingsBundles/
SeatbeltToggler_BUNDLE_EXTENSION = bundle
SeatbeltToggler_LDFLAGS = -undefined dynamic_lookup
SeatbeltToggler_CFLAGS = -I../ATV2Includes
SeatbeltToggler_OBJ_FILES = ../SMFramework/obj/SMFramework

include $(FW_MAKEDIR)/bundle.mk

after-install::
	ssh root@$(FW_DEVICE_IP) killall Lowtide