module immediate_generator ( input  wire [31:0] instruction, output reg  [31:0] immediate);

    wire [6:0] opcode;
    assign opcode = instruction[6:0];

    // opcode definitions
    localparam [6:0] OPCODE_ITYPE = 7'b0010011;
    localparam [6:0] OPCODE_LOAD = 7'b0000011;
    localparam [6:0] OPCODE_STORE = 7'b0100011;
    localparam [6:0] OPCODE_BRANCH = 7'b1100011;
    localparam [6:0] OPCODE_JAL = 7'b1101111;

    always @(*) begin

        // default immediate
        immediate = 32'b0;

        case (opcode)

            // I-TYPE (ADDI, ANDI, ORI, XORI, LW)
            OPCODE_ITYPE, OPCODE_LOAD: begin
                // instruction[31:20]
                immediate = {{20{instruction[31]}},instruction[31:20]};
            end

            // S-TYPE (SW)
            OPCODE_STORE: begin
                // instruction[31:25] = imm[11:5], instruction[11:7]  = imm[4:0]
                immediate = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
            end

            OPCODE_BRANCH: begin
                immediate = {{19{instruction[31]}},instruction[31], instruction[7],instruction[30:25],instruction[11:8],1'b0};      // B-TYPE (BEQ / BNE)
            end

            OPCODE_JAL: begin
                immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21],1'b0};     // J-TYPE (JAL)
            end

            // R-TYPE/UNSUPPORTED
            default: begin
                immediate = 32'b0;
            end
        endcase
    end
endmodule