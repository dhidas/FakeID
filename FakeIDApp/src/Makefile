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
FakeID_DBD += asyn.dbd
FakeID_DBD += motorSupport.dbd
#FakeID_DBD += drvAsynIPPort.dbd
#FakeID_DBD += drvAsynSerialPort.dbd
FakeID_DBD += pmacAsynMotorPort.dbd
FakeID_DBD += pmacAsynMotor.dbd
FakeID_DBD += pmacAsynIPPort.dbd
FakeID_DBD += pmacAsynCoord.dbd
FakeID_DBD += asSupport.dbd
#FakeID_DBD += busySupport.dbd
#FakeID_DBD += calcSupport.dbd
FakeID_DBD += system.dbd
FakeID_DBD += stream.dbd
FakeID_DBD += devIocStats.dbd

# Include dbd files from all support applications:
#FakeID_DBD += xxx.dbd



FakeID_LIBS += pmacAsynIPPort
FakeID_LIBS += pmacAsynCoord
FakeID_LIBS += motor
FakeID_LIBS += asyn
FakeID_LIBS += autosave
#FakeID_LIBS += busy
#FakeID_LIBS += calc
FakeID_LIBS += stream
FakeID_LIBS += devIocStats
FakeID_LIBS += pmacAsynMotor
FakeID_LIBS += pmacAsynMotorPort




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

