LOCAL_DIR := $(GET_LOCAL_DIR)

INCLUDES += -I$(LOCAL_DIR)/include -I$(LK_TOP_DIR)/platform/msm_shared

INCLUDES += -I$(LK_TOP_DIR)/dev/gcdb/display -I$(LK_TOP_DIR)/dev/gcdb/display/include

ifeq ($(ENABLE_MDTP_SUPPORT),1)
INCLUDES += -I$(LK_TOP_DIR)/app/aboot
endif

PLATFORM := msmtitanium

MEMBASE := 0x8F600000 # SDRAM
MEMSIZE := 0x00400000 # 1MB

BASE_ADDR        := 0x80000000
SCRATCH_ADDR     := 0xA0100000

DEFINES += PMI_CONFIGURED=1
DEFINES += DISPLAY_SPLASH_SCREEN=1
DEFINES += DISPLAY_TYPE_MIPI=1
DEFINES += DISPLAY_TYPE_DSI6G=1

MODULES += \
	dev/keys \
	dev/vib \
	lib/ptable \
	dev/pmic/pm8x41 \
	dev/qpnp_haptic \
	lib/libfdt \
	dev/qpnp_wled \
	dev/gcdb/display

DEFINES += \
	MEMSIZE=$(MEMSIZE) \
	MEMBASE=$(MEMBASE) \
	BASE_ADDR=$(BASE_ADDR) \
	SCRATCH_ADDR=$(SCRATCH_ADDR)

OBJS += \
	$(LOCAL_DIR)/init.o \
	$(LOCAL_DIR)/meminfo.o \
	$(LOCAL_DIR)/target_display.o \
	$(LOCAL_DIR)/oem_panel.o
ifeq ($(ENABLE_SMD_SUPPORT),1)
OBJS += \
	$(LOCAL_DIR)/regulator.o
endif

ifeq ($(ENABLE_MDTP_SUPPORT),1)
OBJS += \
	$(LOCAL_DIR)/mdtp_defs.o
endif
