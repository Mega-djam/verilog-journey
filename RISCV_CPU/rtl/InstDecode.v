module id_mem_register (
    input wire clk,
    input wire reset,
    input wire flush,
    input wire [31:0] pc_in,
    input wire [31:0] pc_plus4_in,
    input wire [31:0] alu_result_in,
    input wire [31:0] r2_data_in,
    input wire [4:0] rd_in,
    input wire RegWrite_in,
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire MemToReg_in,
    input wire Jump_in,

    output reg [31:0] pc_out,
    output reg [31:0] pc_plus4_out,
    output reg [31:0] alu_result_out,
    output reg [31:0] r2_data_out,
    output reg [4:0] rd_out,
    output reg RegWrite_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg Jump_out
);

    always @(posedge clk) begin

        if (reset) begin

            pc_out <= 32'b0;
            pc_plus4_out <= 32'b0;
            alu_result_out <= 32'b0;
            r2_data_out <= 32'b0;
            rd_out <= 5'b0;
            RegWrite_out <= 1'b0;
            MemRead_out <= 1'b0;
            MemWrite_out <= 1'b0;
            MemToReg_out <= 1'b0;
            Jump_out <= 1'b0;
        end

        else if (flush) begin

            pc_out <= 32'b0;
            pc_plus4_out <= 32'b0;
            alu_result_out <= 32'b0;
            r2_data_out <= 32'b0;
            rd_out <= 5'b0;
            RegWrite_out <= 1'b0;
            MemRead_out <= 1'b0;
            MemWrite_out <= 1'b0;
            MemToReg_out <= 1'b0;
            Jump_out <= 1'b0;
        end

        else begin

            pc_out <= pc_in;
            pc_plus4_out <= pc_plus4_in;
            alu_result_out <= alu_result_in;
            r2_data_out <= r2_data_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemToReg_out <= MemToReg_in;
            Jump_out <= Jump_in;
        end
    end
endmodule