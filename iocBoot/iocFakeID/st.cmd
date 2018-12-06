#!../../bin/linux-x86_64/FakeID

## You may have to change FakeID to something else
## everywhere it appears in this file

#< envPaths

epicsEnvSet("ENGINEER", "Dean Andrew Hidas is not an engineer. <dhidas@bnl.gov>")
epicsEnvSet("PMACUTIL", "/usr/share/epics-pmacutil-dev")
epicsEnvSet("PMAC1_IP", "10.0.161.25:1025")
epicsEnvSet("sys", "ID")
epicsEnvSet("dev", "FAKE:1")
epicsEnvSet("STREAM_PROTOCOL_PATH", "/usr/share/epics-pmacutil-dev/protocol")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.0.153.255")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")


## Register all support components
dbLoadDatabase("../../dbd/FakeID.dbd",0,0)
FakeID_registerRecordDeviceDriver(pdbbase) 



pmacAsynIPConfigure("P0", $(PMAC1_IP))
pmacCreateController("PMAC1", "P0", 0, 9, 50, 500)

# Create CS (ControllerPort, Addr, CSNumber, CSRef, Prog)
# Gap: Coordinate System 2 | PROG 2
pmacAsynCoordCreate("P0", 0, 2, 0, 2)

# Configure CS (PortName, DriverName, CSRef, NAxes)
drvAsynMotorConfigure("PMAC1CS2", "pmacAsynCoord", 0, 9)
#drvAsynMotorConfigure("PMAC1", "pmacAsynMotor", 0, 9)

pmacCreateAxis("PMAC1", 1)
pmacCreateAxis("PMAC1", 2)
pmacCreateAxis("PMAC1", 3)
pmacCreateAxis("PMAC1", 4)

# pmacDisableLimitsCheck(int card, int axis, int allAxes)
pmacDisableLimitsCheck(0, 1, 1)

# Set scale factor (CSRef, axis, stepsPerUnit)
#pmacSetCoordStepsPerUnit(0, 0, 10000)
#pmacSetCoordStepsPerUnit(0, 1, 10000)
#pmacSetCoordStepsPerUnit(0, 2, 10000)
#pmacSetCoordStepsPerUnit(0, 3, 10000)

# Set Idle and Moving poll periods (CSRef, PeriodsMilliSeconds)
pmacSetCoordIdlePollPeriod(0, 500)
pmacSetCoordMovingPollPeriod(0, 100)

dbLoadRecords("../../db/FakeID.db","SYS=$(sys),DEV=$(dev),PORT=P0")

dbLoadRecords("../../db/motor.db","P=$(sys),M={$(dev)-Ax:TD},MOTOR=PMAC1,ADDR=1,DESC=Top Downstream Mtr,    DTYP=asynMotor")
dbLoadRecords("../../db/motor.db","P=$(sys),M={$(dev)-Ax:TU},MOTOR=PMAC1,ADDR=2,DESC=Top Upstream Mtr,      DTYP=asynMotor")
dbLoadRecords("../../db/motor.db","P=$(sys),M={$(dev)-Ax:BD},MOTOR=PMAC1,ADDR=3,DESC=Bottom Downstream Mtr, DTYP=asynMotor")
dbLoadRecords("../../db/motor.db","P=$(sys),M={$(dev)-Ax:BU},MOTOR=PMAC1,ADDR=4,DESC=Bottom Upstream Mtr,   DTYP=asynMotor")

dbLoadRecords("../../db/asynRecord.db","P=$(sys),R={$(dev)}Asyn,ADDR=1,PORT=P0,IMAX=128,OMAX=128")


pmacSetIdlePollPeriod(0, 500)
pmacSetMovingPollPeriod(0, 50)




set_savefile_path("../../as","/save")
set_requestfile_path("../../as","/req")
set_pass0_restoreFile("ioc_settings.sav")
set_pass1_restoreFile("ioc_waveforms.sav")


iocInit()


makeAutosaveFileFromDbInfo("../../as/req/ioc_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("../../as/req/ioc_waveforms.req", "autosaveFields_pass1")
create_monitor_set("ioc_settings.req", 5, "")
create_monitor_set("ioc_waveforms.req", 60, "")


dbl > records.dbl

