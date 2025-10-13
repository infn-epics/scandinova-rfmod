

##epicsEnvSet("RFMOD_ID",         "1")
##epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
##epicsEnvSet("RFMOD_TCP_IP",     "10.5.2.131")
##epicsEnvSet("RFMOD_TCP_PORT",   "502")

epicsEnvSet("RFMOD_ASYNPORT", "RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_MSGS", "SCN_RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_POLLING", "900")
epicsEnvSet("RFMOD_WD_POLLING", "250")

## Use the following commands for TCP/IP
## drvAsynIPPortConfigure(const char *portName,
##                       const char *hostInfo,
##                       unsigned int priority,
##                       int noAutoConnect,
##                       int noProcessEos);
drvAsynIPPortConfigure("$(RFMOD_ASYNPORT)","$(RFMOD_TCP_IP):$(RFMOD_TCP_PORT)",0,0,1)

## modbusInterposeConfig(const char *portName,
##                      modbusLinkType linkType,
##                      int timeoutMsec, 
##                      int writeDelayMsec)
modbusInterposeConfig("$(RFMOD_ASYNPORT)", 0, 2000, 0)

## ModBus function types
## 16-bit word access 	Read Input Registers 4
## 16-bit word access 	Read Holding Registers 	3
## 16-bit word access 	Write Single Register 	6

## ModBus types
## 0 	UINT16 	
## 1 	INT16SM 	
## 2 	BCD_UNSIGNED 
## 3 	BCD_SIGNED 	
## 4 	INT16
## 5 	INT32_LE
## 6 	INT32_BE
## 7 	FLOAT32_LE
## 8 	FLOAT32_BE
## 9 	FLOAT64_LE
## 10 	FLOAT64_BE

## drvModbusAsynConfigure(portName, 
##                       tcpPortName,
##                       slaveAddress, 
##                       modbusFunction, 
##                       modbusStartAddress, 
##                       modbusLength,
##                       dataType,
##                       pollMsec, 
##                       plcType);
## drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), function type, offset, length, dataType, 100, "SCN_RFMod")

## Input Registers
## Function type - 4

## Offset:0  ModbusTcpProtocolId  Uint 
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TCP_PROT_ID", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 0, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:1  ModbusTcpProtocolRev  Uint 
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TCP_PROT_REV", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 1, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:2  ModbusTcpWatchdogPrev  Uint 
## RFMod is active and should be read more than once per second. Watchdog value
## (WD_SP) is incremented every 500 ms (set by .SCAN field), so the readback
## value that is used for comparison should be polled at least as fast as that. 
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TCP_WD_PREV", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 2, 1, 0, $(RFMOD_WD_POLLING), $(RFMOD_MSGS))

## Offset:3  StateRead  Int 
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATE_RB", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 3, 1, 4, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:4  StatusBits  Uint16 A word containing 16 status bit's
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATUS_RB", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 4, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:5  AccessLevel  Int16  (* See Strings\Message 0-3 in GUI Resource.xml *)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_ACC_LVL_RB", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 5, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:6  Delay[1].TimeRemaining  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TIME_REMAINING", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 6, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:8  PulseRepetitionRate  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_REP_RATE", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 8, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))



## Offset:20  State set readback  Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATE_SR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 20, 1, 4, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:21  Voltage set readback  Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLT_SR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 21, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:23  Filaments current set readback  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_CURR_SR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 23, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:25  Pulse width set readback  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_WDTH_SR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 25, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))


## Offset:100  CcpsUnit[1].VoltRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS1_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 100, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:102 CcpsUnit[2].VoltRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS2_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 102, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:104 CcpsUnit[3].VoltRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS3_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 104, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:200 FilPs.CurrRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_CURR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 200, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:202 FilPs.VoltRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 202, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:300 IonPs[1].RecorderRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_IONPS_R", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 300, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:400 SolPs[1].CurrRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLPS_CURR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 400, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:402 SolPs[1].VoltRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 402, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:500 Digi[1].CtRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_CURR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 500, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:502 Digi[1].CvdRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 502, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:504 Digi[1].CtPlswthRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_WDTH", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 504, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:600 Tank.OilTempRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_OIL_TEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 600, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:602 Tank.OilLevelRead  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_OIL_LVL", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 602, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:700 Cool.CollectorInletTemp  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_INLETTEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 700, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:702 Cool.CollectorOutletTemp  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_OUTLETTEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 702, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:704 Solenoid Temperature  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLPSTEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 704, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:706 Klystron Body Return Temperature  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_KLYBDRTNTEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 706, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:820 Kly.RF Fwd Read  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_KLYRFFWD", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 820, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:822 Kly.RF Rfl Read  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_KLYRFREFL", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 822, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:824 Kly.RF VSWR Read  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_KLYRFVSWR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 824, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:826 Kly.RF Pulse Len Read  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_KLYRFPLEN", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 826, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:900 Cool.CcpsSuFlow1  Single  
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPSSUFLOW1", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 900, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:902 Cool.CcpsSuFlow2  Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPSSUFLOW2", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 902, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:904 Cool.CcpsSuFlow3 Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPSSUFLOW3", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 904, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:906 Cool.CcpsSuFlow4 Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPSSUFLOW4", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 906, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:908 Cool.BodyFlow Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_BODYFLOW", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 908, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:910 Cool.CollectorFlow  Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_COLLFLOW", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 910, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:912 Cool.SolenoidFlow  Single
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLFLOW", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 912, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## CCPS1 interlock status records
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS1_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 120, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## CCPS2 interlock status records
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS2_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 121, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## CCPS3 interlock status records
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS3_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 122, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))


## Holding registers
## Read Holding Registers 	3
## Write Single Register 	6

## Offset:0  ModbusTcpWatchdog  Uint16
## Increment this value at least every second, used by the
## modulator to monitor this communication
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_WD_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 0, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:1  StateTarget  Int 
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATE_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 1, 1, 4, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:2  CommandBits  Uint16 A word containing 16 command bit's
## Bit0: Reset  (* 0=Idle/ready, 1=Clear interlocks and return to 0 *)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CMD_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 2, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:100  Ccps.VoltSet  Single  V  Set value of all CCPS which defines the pulse amplitude
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLT_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 100, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:200  SR_FastCall.IFB_FastKly.IFB_FastFilPS.IFB_CurrSet.ati_rSet1Rem  Single  A  Filaments current set value
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_CURR_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 200, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:300  Su.PlswthSet  Single  us  Pulse width set value
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_WDTH_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 300, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Enable ASYN_TRACEIO_HEX on octet server
asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)

## Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("$(RFMOD_ASYNPORT)", 0, 11)

## Enable ASYN_TRACEIO_HEX on modbus server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 4)

## Enable ASYN_TRACE_ERROR, ASYN_TRACEIO_DEVICE, and ASYN_TRACEIO_DRIVER on modbus server
#asynSetTraceMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 11)
