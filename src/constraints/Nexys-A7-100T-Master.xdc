## This file is a general .xdc for the Nexys A7-100T
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets { LED_OBUF[0] } ];

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets { SW_IBUF[0] } ];

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { SW[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0]

set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { LED[0] }]; #IO_L18P_T2_A24_15 Sch=led[0]

set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { BTN }]; #IO_L9P_T1_DQS_14 Sch=btnc


## Question 2 Part B Implementation, both parts

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets { LED_OBUF[0] } ];

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets { LED_OBUF[1] } ];


#constraint used to replace a ddr.xdc constrant which is not working for some unknown reason
#"set_false_path -through [get_nets -hier -filter {NAME =~ */u_iodelay_ctrl/sys_rst_i}]"
set_false_path -from [get_pins Inst_Audio/DDR/rstn_reg/C] -to [get_pins Inst_Audio/DDR/Inst_DDR/u_ddr_mig/u_ddr2_infrastructure/rstdiv0_sync_r*/PRE]

#needed for sync-async modules
set_false_path -through [get_pins -filter {NAME =~ *SyncAsync*/oSyncStages_reg[*]/D} -hier]
 
