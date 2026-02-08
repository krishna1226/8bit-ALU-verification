// module: alu_8bit
module alu_8bit(
              input [7:0]a,         // 8-bit input A                
              input [7:0]b,         // 8-bit input B                        
              input [2:0]opcode,    // 3-bit selection (8 possible operation)
              output reg [7:0]result, // 8-bit output register for result     
              output reg carry,     // Carry flag for addition overflow 
              output reg negative,  // Borrow/sign bit for subtraction
                                    // Negative flag for subtraction borrow 
              output zero           // if the final result is 0 it set's to 1
                                   // Zero flag indicates result is all zeros
                );
                
// Internal registers to do intermediate math

reg [8:0]sum;// 9-bit register for addition (bit 8 is carry)
reg [8:0]diff;// 9-bit register for subtraction (bit 8 is borrow)


// Combinational Blocks: This runs every time if a, b, or opcode changes
always@(*)begin// Runs whenever inputs change


// Step-1 pre calculate arithmetic
sum  = a + b;// Pre-calculate addition with carry
diff = a - b;// Pre-calculate subtraction with borrow

  
// Step-2 initialize the output

    result   = 8'b00000000;
    carry    = 1'b0; 
    negative = 1'b0;
  
  
// Step-3 select the operation ( the multiplexer)
    case (opcode)// Select operation based on opcode
    
    
     3'b000: begin // ADDITION operation
       result   = sum[7:0];
       carry    = sum[8];   
       negative = result[7];  
     end
   
     3'b001: begin  // SUBTRACTION operation
       result   = diff[7:0]; 
       carry    = ~diff[8];    // carry = NOT borrow 
       negative = result[7];  
     end
   
     3'b010: begin // BITWISE AND operation
       result   = a & b; 
       negative = result[7];
     end
   
     3'b011: begin // BITWISE OR operation
       result   = a | b; 
       negative = result[7];
     end
   
     3'b100: begin  // BITWISE XOR operation
       result   = a ^ b;
       negative = result[7];
     end
   
     3'b101: begin  // BITWISE NOT operation
       result   = ~a; 
       negative = result[7];
     end
   
     3'b110: begin   // LOGICAL SHIFT LEFT
       result   = a << 1; // moves bits left: 00000001 becomes 00000010
       carry    = a[7];   
       negative = result[7];
     end
   
     3'b111: begin    // LOGICAL SHIFT RIGHT 
       result   = a >> 1; // moves bits right: 10000000 becomes 01000000
       carry    = a[0];  
       negative = result[7];
     end
   
     default: begin
        result   = 8'b00000000;
        carry    = 1'b0;
        negative = 1'b0;
        // Output zero for safety
     end   
    endcase
end

// Step-4 final flag logic

// if all bits are of result are 0, 'zero' become 1
assign zero = (result == 8'b00000000);

endmodule
