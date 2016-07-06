generated_sources := $(local-generated-sources-dir)

ifneq ($(BOARD_BLUEDROID_VENDOR_CONF),)
SRC := $(BOARD_BLUEDROID_VENDOR_CONF)
else
SRC := $(call my-dir)/include/$(addprefix vnd_, $(addsuffix .txt,$(basename $(TARGET_DEVICE))))
ifeq (,$(wildcard $(SRC)))
# configuration file does not exist. Use default one
SRC := $(call my-dir)/include/vnd_generic.txt
endif
endif
GEN := $(generated_sources)/vnd_buildcfg.h
TOOL := $(LOCAL_PATH)/gen-buildcfg.sh

$(GEN): PRIVATE_PATH := $(call my-dir)
$(GEN): PRIVATE_CUSTOM_TOOL = $(TOOL) $< $@
$(GEN): $(SRC)  $(TOOL)
	$(transform-generated-source)

LOCAL_GENERATED_SOURCES += $(GEN)
