module alu (
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [2:0] ALUControl,

    output reg[31:0] Result,
    output wire Zero
);

    // ALU operation definitions
    localparam [2:0] ALU_ADD = 3'b000;
    localparam [2:0] ALU_SUB = 3'b001;
    localparam [2:0] ALU_AND = 3'b010;
    localparam [2:0] ALU_OR  = 3'b011;
    localparam [2:0] ALU_XOR = 3'b100;

    always @(*) begin

        case (ALUControl)

            ALU_ADD: begin
                Result = A + B;
            end

            ALU_SUB: begin
                Result = A - B;
            end

            ALU_AND: begin
                Result = A & B;
            end

            ALU_OR: begin
                Result = A | B;
            end

            ALU_XOR: begin
                Result = A ^ B;
            end

            default: begin
                Result = 32'b0;
            end
        endcase
    end

    // Used for branch comparison
    assign Zero = (Result == 32'b0);
endmodule