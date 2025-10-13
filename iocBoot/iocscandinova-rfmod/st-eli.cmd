#!../../bin/linux-x86_64/scandinova-rfmod

#- You may have to change scandinova-rfmod to something else
#- everywhere it appears in this file

< envPaths

## Register all support components
dbLoadDatabase "../../dbd/scandinova-rfmod.dbd"
scandinova_rfmod_registerRecordDeviceDriver(pdbbase) 

epicsEnvSet("RFMOD_ID",         "2")
epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
epicsEnvSet("RFMOD_TCP_IP", "modulator2.star.unical.it")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod.cmd

epicsEnvSet("RFMOD_ID",         "3")
epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
epicsEnvSet("RFMOD_TCP_IP", "modulator3.star.unical.it")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod.cmd

## Enable ASYN_TRACEIO_HEX on octet server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)

## Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("$(RFMOD_ASYNPORT)", 0, 11)

## Enable ASYN_TRACEIO_HEX on modbus server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 4)

## Enable ASYN_TRACE_ERROR, ASYN_TRACEIO_DEVICE, and ASYN_TRACEIO_DRIVER on modbus server
#asynSetTraceMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 11)

## Load record instances
dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_2, PREFIX=MODHEL01")
dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_3, PREFIX=MODHEL02")

iocInit()

## Start any sequence programs
#seq sncscandinova-rfmod,"user=prelz"
