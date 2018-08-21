#!../../bin/linux-x86_64/FakeID

## You may have to change FakeID to something else
## everywhere it appears in this file

#< envPaths

epicsEnvSet("ENGINEER", "Dean Andrew Hidas is not an engineer. <dhidas@bnl.gov>")
epicsEnvSet("PMACUTIL", "/usr/share/epics-pmacutil-dev")
epicsEnvSet("PMAC1_IP", "192.168.1.103:1025")
epicsEnvSet("sys", "ID")
epicsEnvSet("dev", "FAKE:1")
epicsEnvSet("STREAM_PROTOCOL_PATH", "/usr/share/epics-pmacutil-dev/protocol")


## Register all support components
dbLoadDatabase("../../dbd/FakeID.dbd",0,0)
FakeID_registerRecordDeviceDriver(pdbbase) 



pmacAsynIPConfigure("P0", $(PMAC1_IP))
pmacCreateController("PMAC1", "P0", 0, 1, 50, 500)
pmacCreateAxis("PMAC1", 1)
dbLoadRecords("../../db/FakeID.db","SYS=$(sys),DEV=$(dev),PORT=P0")
dbLoadRecords("../../db/motor.db","P=$(sys),M={$(dev)-Mtr1},MOTOR=PMAC1,ADDR=1,DESC=asd,DTYP=asynMotor")
dbLoadRecords("../../db/motorstatus.db","SYS=$(sys),DEV={$(dev)-Mtr1},PORT=P0,AXIS=1")
dbLoadRecords("../../db/pmacStatus.db","SYS=$(sys),PMAC=$(dev),VERSION=1,PLC=5,NAXES=1,PORT=P0")
dbLoadRecords("../../db/pmac_asyn_motor.db","SYS=$(sys),DEV={$(dev)-Mtr1},ADDR=1,SPORT=P0,DESC=asd,PREC=5,EGU=cts")
dbLoadRecords("../../db/pmacStatusAxis.db","SYS=$(sys),DEV={$(dev)-Ax:1},AXIS=1,PORT=P0")
dbLoadRecords("../../db/asynRecord.db","P=$(sys),R={$(dev)}Asyn,ADDR=1,PORT=P0,IMAX=128,OMAX=128")



#pmacSetIdlePollPeriod(0, 500)
#pmacSetMovingPollPeriod(0, 50)
#dbLoadRecords("../../db/pmac_asyn_motor.db","SYS=$(sys),DEV={$(dev)-Mtr1},ADDR=1,SPORT=P0,DESC=asd,PREC=5,EGU=cts")
#dbLoadRecords("../../db/motor.db","P=$(sys),M={$(dev)-MtrX},MOTOR=PMAC1,ADDR=1,DESC=Horizontal Motor,DTYP=asynMotor,MRES=1,ERES=1,EGU=um")
#dbLoadRecords("../../db/motorstatus.db","SYS=$(sys),DEV={$(dev)-MtrX},PORT=P0,AXIS=1")
#dbLoadRecords("../../db/pmacStatusAxis.db","SYS=$(sys),DEV={$(dev)-Ax:1},AXIS=1,PORT=P0")





set_savefile_path("../../as","/save")
set_requestfile_path("../../as","/req")
set_pass0_restoreFile("ioc_settings.sav")
set_pass1_restoreFile("ioc_waveforms.sav")


iocInit()


makeAutosaveFileFromDbInfo("../../as/req/ioc_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("../../as/req/ioc_waveforms.req", "autosaveFields_pass1")
create_monitor_set("ioc_settings.req", 5, "")
create_monitor_set("ioc_waveforms.req", 60, "")

