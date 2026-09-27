module branch_unit (
    input wire [31:0] pc,
    input wire [31:0] immediate,
    input wire BEQ,
    input wire BNE,
    input wire Jump,
    input wire zero,

    output wire branch_taken,
    output wire [31:0] target_address,
    output wire [31:0] next_pc
);
    // BEQ:
    // BEQ = 1
    // BNE = 0
    // zero = 1
    // BNE:
    // BEQ = 1
    // BNE = 1
    // zero = 0

    assign branch_taken = BEQ && ((!BNE && zero) || ( BNE && !zero) );
    assign target_address = pc + immediate;

    // Priority:
    // 1. JAL
    // 2. Taken branch
    // 3. Sequential PC + 4

    assign next_pc = Jump ? target_address : branch_taken ? target_address : pc + 32'd4;

endmodule