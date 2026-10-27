`timescale 1ns/1ps

module tb_gray_to_binary;

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

    // Clock generation (10 ns period)
    always #1 clk = ~clk;

    initial begin
        // VCD dump (REQUIRED for GTKWave)
        $dumpfile("dump6.vcd");
        $dumpvars(0, tb_gray_to_binary);

        // Initial values
        clk     = 0;
        rst     = 1;
        start   = 0;
        convert = 1;              // 1 = Gray → Binary
        ext_in  = 8'b1110_1101;   // Gray input

        // Reset pulse
        #2 rst = 0;

        // Start conversion
        #10 start = 1;
        #10 start = 0;

        // Wait for conversion to complete
        wait(done);

        #10; // allow bus to settle
        
        
        convert=0;
        # 30 ext_in=8'b10110110;
        
        #10 start=1;
        #10 start=0;
         
        wait(done);

        #10;
        // Display result
        $display("GRAY = %b  ->  BINARY = %b", ext_in, bus);

        #20;
        $finish;
    end

endmodule
