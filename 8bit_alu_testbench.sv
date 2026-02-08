// 8bit alu test bench

module alu_tb;
  
// Step-1 internal 'wires' and 'regs'
  
        //inputs
        reg [7:0]a_in;
        reg [7:0]b_in;
        reg [2:0]op_in;
        //output
        wire [7:0]res_out;
        wire carry_out;
        wire neg_out;
        wire zero_out;
        
// Step-2 instantiate the Design under test(DUT)

    alu_8bit dut(
        .a(a_in),
        .b(b_in),
        .opcode(op_in),
        .result(res_out),
        .carry(carry_out),
        .negative(neg_out),
        .zero(zero_out)
       );
       
// Step-3 the 'self checking' task

    task check_result;
        input [7:0]expected_res;
        input expected_neg;
        input expected_carry;  
        begin
          #1; 
            if(res_out == expected_res && 
                neg_out == expected_neg && 
                carry_out == expected_carry &&  
                zero_out == (expected_res == 8'b00000000))begin
         $display("SUCCESS: Op:%b | A=%d B=%d | Res=%d Carry=%b Neg=%b Zero=%b", 
                  op_in, a_in, b_in, res_out, carry_out, neg_out, zero_out);
            end else begin
         $display("FAILURE: Op:%b | A=%d B=%d | Expected Res=%d Got=%d | Exp Carry=%b Got=%b | Exp Neg=%b Got=%b", 
                  op_in, a_in, b_in, expected_res, res_out, expected_carry, carry_out, expected_neg, neg_out);
            end
        end       
    endtask
    
// Step 4: Stimulus Block 
  
    initial begin
      
// Setup Waveform Dumping
        $dumpfile("dump.vcd");
        $dumpvars(0, alu_tb);
        $display("Starting Randomized Stress Test (100 Cases)");
        
// The Randomized Loop
      
      for (int i = 0; i < 200; i = i + 1) begin
// 1. Generate random inputs
          a_in  = $random & 8'hFF;
          b_in  = $random & 8'hFF;
          op_in = $random & 3'b111;
           
// 2. Automated Golden Model Check
            case (op_in)
                3'b000: begin // ADD
                  reg [8:0] s;
                  s = a_in + b_in;
                  check_result(s[7:0], s[7], s[8]);
                end

                3'b001: begin // SUB
                  reg [8:0] d;
                  d = a_in - b_in;
                  check_result(d[7:0], d[7], ~d[8]); // carry = NOT borrow
                end

                3'b010: begin // AND
                  reg [7:0] r;
                  r = a_in & b_in;
                  check_result(r, r[7], 1'b0);
                end

                3'b011: begin // OR
                  reg [7:0] r;
                  r = a_in | b_in;
                  check_result(r, r[7], 1'b0);
                end

                3'b100: begin // XOR
                  reg [7:0] r;
                  r = a_in ^ b_in;
                  check_result(r, r[7], 1'b0);
                end

                3'b101: begin // NOT
                  reg [7:0] r;
                  r = ~a_in;
                  check_result(r, r[7], 1'b0);
                end

                3'b110: begin // SHL
                  reg [7:0] r;
                  r = a_in << 1;
                  check_result(r, r[7], a_in[7]);
                end

                3'b111: begin // SHR
                  reg [7:0] r;
                  r = a_in >> 1;
                  check_result(r, r[7], a_in[0]);
                end
            endcase
        end
        $display("Randomized Stress Test Completed");
        $finish;
    end
endmodule
