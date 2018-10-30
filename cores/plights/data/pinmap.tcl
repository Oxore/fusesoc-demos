#
# Clock / Reset
#
set_location_assignment PIN_E1 -to usrkey_n_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to usrkey_n_pad_i
set_location_assignment PIN_J15 -to rst_n_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to rst_n_pad_i
set_location_assignment PIN_R8 -to sys_clk_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sys_clk_pad_i

#
# GPIO0
#
set_location_assignment PIN_A15 -to gpio0_io[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[0]
set_location_assignment PIN_A13 -to gpio0_io[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[1]
set_location_assignment PIN_B13 -to gpio0_io[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[2]
set_location_assignment PIN_A11 -to gpio0_io[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[3]
set_location_assignment PIN_D1 -to gpio0_io[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[4]
set_location_assignment PIN_F3 -to gpio0_io[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[5]
set_location_assignment PIN_B1 -to gpio0_io[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[6]
set_location_assignment PIN_L3 -to gpio0_io[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[7]

#============================================================
# GPIO1 (Switches)
#============================================================
set_location_assignment PIN_M1  -to gpio1_i[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio1_i[0]
set_location_assignment PIN_T8  -to gpio1_i[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio1_i[1]
set_location_assignment PIN_B9  -to gpio1_i[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio1_i[2]
set_location_assignment PIN_M15 -to gpio1_i[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio1_i[3]
