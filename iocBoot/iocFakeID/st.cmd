#!../../bin/linux-x86_64/FakeID

## You may have to change FakeID to something else
## everywhere it appears in this file

#< envPaths

## Register all support components
dbLoadDatabase("../../dbd/FakeID.dbd",0,0)
FakeID_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("../../db/FakeID.db","SYS=ID,DEV=FAKE:1")



set_savefile_path("../../as","/save")
set_requestfile_path("../../as","/req")
set_pass0_restoreFile("ioc_settings.sav")
set_pass1_restoreFile("ioc_waveforms.sav")


iocInit()


makeAutosaveFileFromDbInfo("../../as/req/ioc_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("../../as/req/ioc_waveforms.req", "autosaveFields_pass1")
create_monitor_set("ioc_settings.req", 5, "")
create_monitor_set("ioc_waveforms.req", 60, "")

