`timescale 1ns/1ps

module tb_converter;

    reg clk, rst, start, convert;
    reg [7:0] ext_in;
    wire [7:0] bus;
    wire done;

    converter_top DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .convert(convert),
        .ext_in(ext_in),
        .bus(bus),
        .done(done)
    );

    // clock
    always #25 clk = ~clk;

    initial begin
        $dumpfile("dumpy.vcd");   // ✅ THIS WAS MISSING
        $dumpvars(0, tb_converter);

        clk=0; rst=1; start=0; convert=0;
        ext_in = 8'b10110110;

      #100 rst=0;

        #10 start=1;
        #10 start=0;

        wait(done);
        #10;

        //2nd case
        ext_in=8'b01111000;// gray to binary
        #10 start=1;
        #10 start=0;
        wait(done);
        #10;

        //3rd case 
        convert=1; // binary to gray
        ext_in=8'b01100001;
        #10 start=1;
        #10 start=0;        

        wait(done);
        #10;

        //4th case
        convert=0; // gray to binary
        ext_in=8'b10010001;
        #10 start=1;
        #10 start=0;        
        wait(done);
        #10;

       

        #20 $finish;
    end
endmodule
