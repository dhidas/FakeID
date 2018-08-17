TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = FakeID
# FakeID.dbd will be created and installed
DBD += FakeID.dbd

# FakeID.dbd will be made up from these files:
FakeID_DBD += base.dbd

# Include dbd files from all support applications:
#FakeID_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#FakeID_LIBS += xxx
ifneq ($(AUTOSAVE),)
FakeID_DBD += asSupport.dbd
FakeID_LIBS += autosave
endif


# FakeID_registerRecordDeviceDriver.cpp derives from FakeID.dbd
FakeID_SRCS += FakeID_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
FakeID_SRCS_DEFAULT += FakeIDMain.cpp
FakeID_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#FakeID_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
FakeID_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

