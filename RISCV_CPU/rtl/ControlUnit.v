module control_unit(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg ALUSrc,
    output reg Branch,
    output reg BranchNE,
    output reg Jump,
    output reg [2:0]  ALUControl
);

    // opcode definitions
    localparam [6:0] OPCODE_RTYPE = 7'b0110011;
    localparam [6:0] OPCODE_ITYPE = 7'b0010011;
    localparam [6:0] OPCODE_LOAD = 7'b0000011;
    localparam [6:0] OPCODE_STORE = 7'b0100011;
    localparam [6:0] OPCODE_BRANCH = 7'b1100011;
    localparam [6:0] OPCODE_JAL = 7'b1101111;

    // ALU control definitions
    localparam [2:0] ALU_ADD = 3'b000;
    localparam [2:0] ALU_SUB = 3'b001;
    localparam [2:0] ALU_AND = 3'b010;
    localparam [2:0] ALU_OR = 3'b011;
    localparam [2:0] ALU_XOR = 3'b100;

    always @(*) begin

        // default values
        RegWrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        MemToReg = 1'b0;
        ALUSrc = 1'b0;
        Branch = 1'b0;
        BranchNE = 1'b0;
        Jump = 1'b0;
        ALUControl = ALU_ADD;

        // decode inst
        case (opcode)

            // R-TYPE INSTRUCTIONS (ADD, SUB, AND, OR, XOR)
            OPCODE_RTYPE: begin

                RegWrite = 1'b1;
                ALUSrc = 1'b0;
                case (funct3)

                    3'b000: begin
                        if (funct7 == 7'b0000000)
                            ALUControl = ALU_ADD;  //ADD
                        else if (funct7 == 7'b0100000)
                            ALUControl = ALU_SUB;  //SUB
                    end

                    3'b111: begin
                        ALUControl = ALU_AND;  // AND
                    end

                    3'b110: begin
                        ALUControl = ALU_OR;   // OR
                    end

                    3'b100: begin
                        ALUControl = ALU_XOR;   // XOR
                    end

                    default: begin
                        ALUControl = ALU_ADD;
                    end
                endcase
            end

            // I-TYPE ALU INSTRUCTIONS (ADDI, ANDI, ORI, XORI)
            OPCODE_ITYPE: begin

                RegWrite = 1'b1;
                ALUSrc = 1'b1;
                case (funct3)

                    3'b000: begin
                        ALUControl = ALU_ADD;  // ADDI
                    end
                    3'b111: begin
                        ALUControl = ALU_AND;  // ANDI
                    end
                    3'b110: begin
                        ALUControl = ALU_OR;   // ORI
                    end
                    3'b100: begin
                        ALUControl = ALU_XOR; // XORI
                    end
                    default: begin
                        ALUControl = ALU_ADD;
                    end
                endcase
            end

            // LOAD WORD (LW)
            OPCODE_LOAD: begin

                // LW rd, imm(r1)
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemToReg = 1'b1;
                ALUSrc = 1'b1;
                ALUControl = ALU_ADD;   // Address calculation: r1 + immediate
            end

            // STORE WORD (SW)
            OPCODE_STORE: begin

                // SW r2, imm(r1)
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                ALUControl = ALU_ADD;   // Address calculation: r1 + immediate
            end

            // CONDITIONAL BRANCH (BEQ / BNE)
            OPCODE_BRANCH: begin

                Branch = 1'b1;
                ALUSrc = 1'b0;

                case (funct3)

                    3'b000: begin
                        BranchNE = 1'b0;    // BEQ
                    end
                    3'b001: begin
                        BranchNE = 1'b1;  // BNE
                    end
                    default: begin
                        Branch   = 1'b0;
                        BranchNE = 1'b0;
                    end
                endcase
                ALUControl = ALU_SUB;
            end

            // JUMP AND LINK (JAL)
            OPCODE_JAL: begin

                Jump = 1'b1;
                RegWrite = 1'b1;
                ALUControl = ALU_ADD; // JAL writes PC + 4 to rd
            end
            
            // UNSUPPORTED OPCODE
            default: begin

                // default values 
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                ALUSrc = 1'b0;
                Branch = 1'b0;
                BranchNE = 1'b0;
                Jump = 1'b0;
                ALUControl = ALU_ADD;
            end
        endcase
    end
endmodule
