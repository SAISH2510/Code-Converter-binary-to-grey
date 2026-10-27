# Clock: 0.1 GHz (100 MHz)
create_clock -name clk -period 10.000 [get_ports clk]

# Illustrative timing assumptions
set_clock_uncertainty 0.500 [get_clocks clk]
set_clock_transition 0.020 [get_clocks clk]

set_input_delay -clock clk -max 2.000 \
    [get_ports {start convert ext_in[*]}]

set_input_delay -clock clk -min 0.500 \
    [get_ports {start convert ext_in[*]}]

set_input_transition 0.020 \
    [get_ports {start convert ext_in[*]}]

set_output_delay -clock clk -max 2.000 \
    [get_ports {bus[*] done}]

set_output_delay -clock clk -min 0.500 \
    [get_ports {bus[*] done}]

set_load 0.010 [get_ports {bus[*] done}]

set_false_path -from [get_ports rst]