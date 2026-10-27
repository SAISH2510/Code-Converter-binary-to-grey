`timescale 1ns/1ps

module tb_converter;

    reg        clk;
    reg        rst;
    reg        start;
    reg        convert;
    reg  [7:0] ext_in;

    wire [7:0] bus;
    wire       done;

    // DUT
    converter_top dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .convert(convert),
        .ext_in(ext_in),
        .bus(bus),
        .done(done)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    // Task to apply one binary input
    task apply_bin(input [7:0] bin);
        begin
            ext_in = bin;
            start  = 1'b1;
            #10;
            start  = 1'b0;

            // Wait until conversion completes
            wait(done);

            #5; // allow bus to settle
            $display("BIN = %b  ->  GRAY = %b", bin, bus);

            #20;
        end
    endtask

    initial begin
        // VCD dump (THIS IS CRITICAL)
        $dumpfile("dump21.vcd");
        $dumpvars(0, tb2_converter);

        // Init
        clk     = 0;
        rst     = 1;
        start   = 0;
        convert = 0;   // 0 = Binary → Gray
        ext_in  = 0;

        // Reset
        #20 rst = 0;

        // ---- Apply 4 test vectors ----
        apply_bin(8'b00000000);
        apply_bin(8'b00000011);
        apply_bin(8'b01011010);
        apply_bin(8'b10110110);
        
        //grey-bin
        convert=1;
        #10;
        apply_bin(8'b00000000);
        apply_bin(8'b10001011);
        apply_bin(8'b01011010);
        apply_bin(8'b10111110);
 
        rst=1; #10
        $display("All Binary → Gray tests completed");
        #20;
        $finish;
    end

endmodule
