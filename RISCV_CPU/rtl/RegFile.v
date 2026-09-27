module register_file (
    input wire clk,
    input wire reset,
    input wire [4:0] r1,
    input wire [4:0] r2,
    input wire RegWrite,
    input wire [4:0] rd,
    input wire [31:0] write_data,

    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);
    // 32 registers (each 32 bits)
    reg [31:0] registers [0:31];
    integer i;

    assign read_data1 = (r1 == 5'd0) ? 32'b0 : registers[r1];    // read port 1

    assign read_data2 = (r2 == 5'd0) ? 32'b0 : registers[r2];    // read port 2

    //Write Port
    always @(posedge clk) begin

        if (reset) begin
            // reset reg to 0
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else begin
            // write only when RegWrite is enabled
            if (RegWrite && (rd != 5'd0)) begin
                registers[rd] <= write_data;
            end
            // assign r0=0
            registers[0] <= 32'b0;
        end
    end
endmodule