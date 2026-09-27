module riscv_cpu (input wire clk, input wire reset);

    wire [31:0] pc;
    wire [31:0] next_pc;
    wire [31:0] instruction;
    wire [31:0] pc_plus4;
    assign pc_plus4 = pc + 32'd4;

    program_counter PC (.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));
    instruction_memory IMEM ( .address(pc), .instruction(instruction));

    wire [31:0] if_id_pc;
    wire [31:0] if_id_pc_plus4;
    wire [31:0] if_id_instruction;
    wire stall;
    wire flush;

    if_id_register IF_ID (
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .flush(flush),
        .pc_in(pc),
        .pc_plus4_in(pc_plus4),
        .instruction_in(instruction),
        .pc_out(if_id_pc),
        .pc_plus4_out(if_id_pc_plus4),
        .instruction_out(if_id_instruction)
    );

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] r1;
    wire [4:0] r2;
    wire [4:0] rd;

    assign opcode = if_id_instruction[6:0];
    assign funct3 = if_id_instruction[14:12];
    assign funct7 = if_id_instruction[31:25];
    assign r1 = if_id_instruction[19:15];
    assign r2 = if_id_instruction[24:20];
    assign rd  = if_id_instruction[11:7];

    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire MemToReg;
    wire ALUSrc;
    wire Branch;
    wire BranchNE;
    wire Jump;
    wire [2:0] ALUControl;

    control_unit CONTROL (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .BranchNE(BranchNE),
        .Jump(Jump),
        .ALUControl(ALUControl)
    );

    wire [31:0] register_data1;
    wire [31:0] register_data2;

    wire [4:0] wb_rd;
    wire [31:0] wb_data;
    wire wb_RegWrite;

    register_file REGFILE (
        .clk(clk),
        .reset(reset),
        .r1(r1),
        .r2(r2),
        .read_data1(register_data1),
        .read_data2(register_data2),
        .RegWrite(wb_RegWrite),
        .rd(wb_rd),
        .write_data(wb_data)
    );

    wire [31:0] immediate;
    immediate_generator IMM_GEN (.instruction(if_id_instruction),.immediate(immediate));

    reg UsesR1;
    reg UsesR2;

    always @(*) begin

        UsesR1 = 1'b0;
        UsesR2 = 1'b0;

        case (opcode)

            // R-type
            7'b0110011: begin
                UsesR1 = 1'b1;
                UsesR2 = 1'b1;
            end

            // I-type ALU
            7'b0010011: begin
                UsesR1 = 1'b1;
                UsesR2 = 1'b0;
            end

            // LW
            7'b0000011: begin
                UsesR1 = 1'b1;
                UsesR2 = 1'b0;
            end

            // SW
            7'b0100011: begin
                UsesR1 = 1'b1;
                UsesR2 = 1'b1;
            end

            // BEQ / BNE
            7'b1100011: begin
                UsesR1 = 1'b1;
                UsesR2 = 1'b1;
            end

            // JAL
            7'b1101111: begin
                UsesR1 = 1'b0;
                UsesR2 = 1'b0;
            end

            default: begin
                UsesR1 = 1'b0;
                UsesR2 = 1'b0;
            end
        endcase
    end

    wire [31:0] id_mem_pc;
    wire [31:0] id_mem_pc_plus4;
    wire [31:0] id_mem_alu_result;
    wire [31:0] id_mem_r2_data;
    wire [4:0] id_mem_rd;
    wire id_mem_RegWrite;
    wire id_mem_MemRead;
    wire id_mem_MemWrite;
    wire id_mem_MemToReg;
    wire id_mem_Jump;
    wire [1:0] ForwardA;
    wire [1:0] ForwardB;

    forwarding_unit FORWARD (
        .r1(r1),
        .r2(r2),
        .rd_mem(id_mem_rd),
        .RegWrite_mem(id_mem_RegWrite),
        .rd_wb(wb_rd),
        .RegWrite_wb(wb_RegWrite),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

    reg [31:0] forwarded_data1;
    reg [31:0] forwarded_data2;

    always @(*) begin

        case (ForwardA)

            2'b00:
                forwarded_data1 = register_data1;
            2'b01:
                forwarded_data1 = wb_data;
            2'b10:
                forwarded_data1 = id_mem_alu_result;
            default:
                forwarded_data1 = register_data1;
        endcase


        case (ForwardB)

            2'b00:
                forwarded_data2 = register_data2;
            2'b01:
                forwarded_data2 = wb_data;
            2'b10:
                forwarded_data2 = id_mem_alu_result;
            default:
                forwarded_data2 = register_data2;
        endcase
    end

    wire [31:0] alu_input_b;
    wire [31:0] alu_result;
    wire alu_zero;

    assign alu_input_b = ALUSrc ? immediate : forwarded_data2;

    alu ALU (
        .A(forwarded_data1),
        .B(alu_input_b),
        .ALUControl(ALUControl),
        .Result(alu_result),
        .Zero(alu_zero)
    );

    wire branch_taken;
    wire [31:0] branch_target;

    branch_unit BRANCH (
        .pc(if_id_pc),
        .immediate(immediate),
        .BEQ(Branch),
        .BNE(BranchNE),
        .Jump(Jump),
        .zero(alu_zero),
        .branch_taken(branch_taken),
        .target_address(branch_target),
        .next_pc(next_pc)
    );

    assign flush = branch_taken || Jump;

    hazard_unit HAZARD (
        .r1(r1),
        .r2(r2),
        .rd_mem(id_mem_rd),
        .MemRead_mem(id_mem_MemRead),
        .UsesR1(UsesR1),
        .UsesR2(UsesR2),
        .stall(stall)
    );
    
    id_mem_register ID_MEM (
        .clk(clk),
        .reset(reset),
        .flush(stall),
        .pc_in(if_id_pc),
        .pc_plus4_in(if_id_pc_plus4),
        .alu_result_in(alu_result),
        .r2_data_in(forwarded_data2),
        .rd_in(rd),
        .RegWrite_in(RegWrite),
        .MemRead_in(MemRead),
        .MemWrite_in(MemWrite),
        .MemToReg_in(MemToReg),
        .Jump_in(Jump),
        .pc_out(id_mem_pc),
        .pc_plus4_out(id_mem_pc_plus4),
        .alu_result_out(id_mem_alu_result),
        .r2_data_out(id_mem_r2_data),
        .rd_out(id_mem_rd),
        .RegWrite_out(id_mem_RegWrite),
        .MemRead_out(id_mem_MemRead),
        .MemWrite_out(id_mem_MemWrite),
        .MemToReg_out(id_mem_MemToReg),
        .Jump_out(id_mem_Jump)
    );

    wire [31:0] memory_read_data;

    data_memory DMEM (
        .clk(clk),
        .reset(reset),
        .address(id_mem_alu_result),
        .write_data(id_mem_r2_data),
        .read_data(memory_read_data),
        .MemRead(id_mem_MemRead),
        .MemWrite(id_mem_MemWrite)
    );

    assign wb_data = id_mem_Jump ? id_mem_pc_plus4 : (id_mem_MemToReg ? memory_read_data : id_mem_alu_result);
    assign wb_rd = id_mem_rd;
    assign wb_RegWrite = id_mem_RegWrite;
endmodule