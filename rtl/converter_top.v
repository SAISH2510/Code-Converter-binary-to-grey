module converter_top (
    input        clk,
    input        rst,
    input        start,
    input        convert,     // 0: bin→gray, 1: gray→bin
    input  [7:0] ext_in,
    output [7:0] bus,
    output reg   done
);

    // Registers
    reg [7:0] R1, R2;
    reg       R3, R4;         // 1-bit regs
    reg [2:0] bit_ptr;

    // Control flags
    reg R1_in, R1_out, R2_in, R2_out;

    // Single XOR gate
    wire xor_out = R3 ^ R4;

    // Tri-state bus
    assign bus =
          R1_out ? R1 :
          R2_out ? R2 :
          8'bz;

    // FSM states
    localparam IDLE=0, LOAD=1, MSB=2, XOR_LOAD=3, STORE=4, DONE=5;
    reg [2:0] state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state   <= IDLE;
            bit_ptr<= 3'd7;
            done    <= 0;
            R1 <= 0; R2 <= 0; R3 <= 0; R4 <= 0;
        end else begin
            // defaults
            R1_in=0; R1_out=0; R2_in=0; R2_out=0;
            done = 0;

            case (state)

                IDLE: if (start) begin
                    //load binary
                    if (convert == 0) begin
                        R1 <= ext_in;
                         R1_in=1; 
                    end 
                   // load gray
                    else begin
                          R2 <= ext_in;
                          R2_in=1;    
                    end
                    bit_ptr <= 7;
                    state <= MSB;
                end

                MSB: begin
                    if(convert ==0)begin
                        R2[7] <= R1[7];   
                    end
                    else begin
                        R1[7] <= R2[7];     // MSB passes directly
                    end
                    bit_ptr <= 6;
                    state <= XOR_LOAD;
                end

                XOR_LOAD: begin
                    if(convert==0)begin
                        R3 <= R1[bit_ptr+1];
                        R4 <= R1[bit_ptr];
                    end
                    else begin 
                        R3 <= R1[bit_ptr+1];
                        R4 <= R2[bit_ptr];
                    end
                    state <= STORE;
                end

                STORE: begin
                    if(convert==0)begin
                        R2[bit_ptr] <= xor_out;
                    end
                    else begin
                    R1[bit_ptr] <= xor_out;
                     end
                    if (bit_ptr == 0)
                        state <= DONE;
                    else begin
                        bit_ptr <= bit_ptr - 1;
                        state <= XOR_LOAD;
                    end
                end

                DONE: begin
                    if(convert==0) begin
                        R2_out <= 1;
                    end
                    else begin
                        R1_out <= 1;
                    end
                    done <= 1;
                    state <= IDLE;
                end

            endcase
        end
    end
endmodule

