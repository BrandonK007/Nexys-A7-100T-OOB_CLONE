## This file is a general .xdc for the Nexys A7-100T
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets { SW_IBUF[0] } ];

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { SW[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0] SMOKE DETECTED

set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { LED[0] }]; #IO_L18P_T2_A24_15 Sch=led[0] ALARM

set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { BTN }]; #IO_L9P_T1_DQS_14 Sch=btnc RESET

set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { SW[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1] GATE

set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { LED[1] }]; #IO_L24P_T3_RS1_15 Sch=led[1] ALARM

set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { LED[2] }];

set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { SW[2] }]; 

## Question 2 Part B Implementation, both parts

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets { LED_OBUF[0] } ];

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets { sa_level_dut/LED_OBUF[1]_inst_i_2_n_0} ];
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {SW_IBUF[1] } ];

# Question 3 Part B Implementaiton, four parts

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {LED_OBUF[1]_inst_i_2_n_0 } ];

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {LED_OBUF[2] } ];

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {SW_IBUF[2] } ];

create_clock sys_clk_pin -period 1000.00 -waveform {0 5}[get_ports{SW[2]}];                     


#Laboratory 6 Question 1, Two Parts

create_clock sys_clk_pin -period 1000.00 -waveform {0 5} [get_ports { SW[1] } ];

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets { SW_IBUF[1] } ];


#Laboratory 6 Question 2, Both Parts

#create_clock sys_clk_pin -period 1000.00 -waveform {0 5} [get_ports { SW[1] } ];

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets { SW_IBUF[1] } ];

#constraint used to replace a ddr.xdc constrant which is not working for some unknown reason
#"set_false_path -through [get_nets -hier -filter {NAME =~ */u_iodelay_ctrl/sys_rst_i}]"
set_false_path -from [get_pins Inst_Audio/DDR/rstn_reg/C] -to [get_pins Inst_Audio/DDR/Inst_DDR/u_ddr_mig/u_ddr2_infrastructure/rstdiv0_sync_r*/PRE]

#needed for sync-async modules
set_false_path -through [get_pins -filter {NAME =~ *SyncAsync*/oSyncStages_reg[*]/D} -hier]
 

