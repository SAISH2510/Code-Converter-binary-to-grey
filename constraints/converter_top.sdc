# 1. Clock Definition
create_clock -name clk -period 1.000 [get_ports clk]

# 2. Clock Uncertainty
set_clock_uncertainty 0.050 [get_clocks clk]

# 3. Clock Transition
set_clock_transition 0.020 [get_clocks clk]

# 4. Input Delay Constraints
set_input_delay -clock clk -max 0.200 \
    [get_ports {start convert ext_in[*]}]

set_input_delay -clock clk -min 0.050 \
    [get_ports {start convert ext_in[*]}]

# 5. Input Transition
set_input_transition 0.020 \
    [get_ports {start convert ext_in[*]}]

# 6. Output Delay Constraints
set_output_delay -clock clk -max 0.200 \
    [get_ports {bus[*] done}]

set_output_delay -clock clk -min 0.050 \
    [get_ports {bus[*] done}]

# 7. Output Load
set_load 0.010 [get_ports {bus[*] done}]

# 8. Asynchronous Reset
set_false_path -from [get_ports rst]

#========================================================
# End of SDC
#========================================================
```
