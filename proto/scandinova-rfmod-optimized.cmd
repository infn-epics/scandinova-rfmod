##############################################################################
# Optimized Scandinova RF Modulator Modbus Configuration
# This version groups registers into logical blocks and uses offsets
# Reduces number of asyn ports from 45+ to ~10
##############################################################################

##epicsEnvSet("RFMOD_ID",         "1")
##epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
##epicsEnvSet("RFMOD_TCP_IP",     "10.5.2.131")
##epicsEnvSet("RFMOD_TCP_PORT",   "502")

epicsEnvSet("RFMOD_ASYNPORT", "RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_MSGS", "SCN_RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_POLLING", "900")
epicsEnvSet("RFMOD_WD_POLLING", "250")

##############################################################################
# TCP/IP Port Configuration
##############################################################################
## drvAsynIPPortConfigure(portName, hostInfo, priority, noAutoConnect, noProcessEos)
drvAsynIPPortConfigure("$(RFMOD_ASYNPORT)","$(RFMOD_TCP_IP):$(RFMOD_TCP_PORT)",0,0,1)

## modbusInterposeConfig(portName, linkType, timeoutMsec, writeDelayMsec)
modbusInterposeConfig("$(RFMOD_ASYNPORT)", 0, 2000, 0)

##############################################################################
# GROUPED INPUT REGISTERS (Function Code 4: Read Input Registers)
##############################################################################
## Modbus Data Types:
##  0=UINT16, 1=INT16SM, 4=INT16, 5=INT32_LE, 6=INT32_BE
##  7=FLOAT32_LE, 8=FLOAT32_BE, 9=FLOAT64_LE, 10=FLOAT64_BE
##
## drvModbusAsynConfigure(portName, tcpPortName, slaveAddr, modbusFunction, 
##                        startAddr, length, dataType, pollMsec, plcType)

##############################################################################
# GROUP 1: System Status Block (Offsets 0-25)
# Contains: Protocol ID, revision, watchdog, state, status, access level, 
#           delay timer, pulse rate, and setpoint readbacks
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SYS_STATUS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 0, 27, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Watchdog needs faster polling (separate port for different scan rate)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_WD_RB", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 2, 1, 0, $(RFMOD_WD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 2: CCPS Voltages Block (Offsets 100-106)
# Contains: CCPS1, CCPS2, CCPS3 voltage readbacks (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 100, 6, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 3: CCPS Interlock Status (Offsets 120-123)
# Contains: CCPS1, CCPS2, CCPS3 interlock bits
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_ILCK", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 120, 3, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 4: Filament Power Supply (Offsets 200-203)
# Contains: Current and voltage readbacks (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 200, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 5: Ion Pump (Offsets 300-301)
# Contains: Recorder readback (2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_IONPS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 300, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 6: Solenoid Power Supply (Offsets 400-403)
# Contains: Current and voltage readbacks (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLPS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 400, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 7: Pulse Digitizer (Offsets 500-505)
# Contains: Current, voltage, pulse width readbacks (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PULSE", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 500, 6, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 8: Tank Monitoring (Offsets 600-603)
# Contains: Oil temperature and level (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TANK", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 600, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 9: Cooling System Temperatures (Offsets 700-707)
# Contains: Inlet, outlet, solenoid, and klystron body temperatures 
#           (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_COOL_TEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 700, 8, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 10: Klystron RF Monitoring (Offsets 820-827)
# Contains: Forward power, reflected power, VSWR, pulse length 
#           (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_KLY_RF", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 820, 8, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 11: Cooling System Flows (Offsets 900-913)
# Contains: All cooling water flow measurements (each 2 words = FLOAT32)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_COOL_FLOW", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 900, 14, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# HOLDING REGISTERS (Function Codes 3/6/16: Read/Write Holding Registers)
##############################################################################

##############################################################################
# GROUP 12: Control Registers Block (Offsets 0-2)
# Contains: Watchdog setpoint, state target, command bits
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CTRL", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 0, 3, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 13: CCPS Voltage Setpoint (Offset 100-101)
# Write using Function 16 (Write Multiple Registers) for FLOAT32
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_V_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 100, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 14: Filament Current Setpoint (Offset 200-201)
# Write using Function 16 (Write Multiple Registers) for FLOAT32
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FIL_I_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 200, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 15: Pulse Width Setpoint (Offset 300-301)
# Write using Function 16 (Write Multiple Registers) for FLOAT32
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PW_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 300, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# Debug Settings (commented out by default)
##############################################################################
## Enable ASYN_TRACEIO_HEX on octet server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)

## Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("$(RFMOD_ASYNPORT)", 0, 11)

##############################################################################
# Summary of Optimization:
# OLD: 45+ individual asyn ports (one per register)
# NEW: 15 grouped asyn ports covering all registers
# 
# Benefits:
# - Reduced network traffic (fewer Modbus transactions)
# - Clearer organization by functional groups
# - Easier maintenance and debugging
# - Better performance (fewer context switches)
##############################################################################
