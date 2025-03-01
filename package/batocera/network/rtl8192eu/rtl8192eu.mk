################################################################################
#
# rtl8192eu
#
################################################################################

RTL8192EU_VERSION = e39c4e7a66b05fab6eceb2bb251d399c003fb544
RTL8192EU_SITE = $(call github,Mange,rtl8192eu-linux-driver,$(RTL8192EU_VERSION))
RTL8192EU_LICENSE = GPL-2.0
RTL8192EU_LICENSE_FILES = LICENSE

RTL8192EU_MODULE_MAKE_OPTS = \
	CONFIG_RTL8192EU=m \
# batocera: setting KVER breaks top level parallelization
	# KVER=$(LINUX_VERSION_PROBED)
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
		-Wno-error"

define RTL8192EU_MAKE_SUBDIR
        (cd $(@D); ln -s . rtl8192eu)
endef

RTL8192eu_PRE_CONFIGURE_HOOKS += RTL8192EU_MAKE_SUBDIR

$(eval $(kernel-module))
$(eval $(generic-package))
