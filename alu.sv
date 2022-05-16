`include "config.sv"
`include "constants.sv"

module alu (
    input        [4:0]  alu_function,
    input signed [31:0] operand_a,
    input signed [31:0] operand_b,
    
    output logic [31:0] result,
    output              result_equal_zero
);

always_comb begin 
    case(alu_function)
        5'b00001: result = operand_a + operand_b; // ADD
        
        5'b00010: result = operand_a - operand_b; // SUB
        
        5'b00011: result = operand_a << operand_b[4:0];//SLL
        
        5'b00100: result = operand_a >> operand_b[4:0];//SRL
        
        5'b00101: result = operand_a >>> operand_b[4:0];//SRA
        
        5'b00110: begin if (operand_a==operand_b) result = 31'b1; //SEQ
        else result = 31'b0;
        end
        
        5'b00111: begin if (operand_a<operand_b) result = 31'b1; //SLT
        else result = 31'b0;
        end
        
        5'b01000: begin if ($unsigned(operand_a) < $unsigned(operand_b)) result = 31'b1; //SLTU
        else result = 31'b0;
        end
        
        5'b01001: result = operand_a ^ operand_b;//XOR
        
        5'b01010: result = operand_a | operand_b; // OR
        
        5'b01011: result = operand_a & operand_b; // AND
       
        default:result = 31'b0; // default
    endcase
end

assign result_equal_zero = (result == 32'b0);
    
endmodule