module forwarding_unit (
    input wire [4:0] r1,
    input wire [4:0] r2,
    input wire [4:0] rd_mem,
    input wire RegWrite_mem,
    input wire [4:0] rd_wb,
    input wire RegWrite_wb,

    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);
    always @(*) begin

        // register file values
        ForwardA = 2'b00;
        ForwardB = 2'b00;

        if (RegWrite_mem && (rd_mem != 5'b00000) && (rd_mem == r1)) 
        begin
            ForwardA = 2'b10;   // forward ALU result to r1
        end
        if (RegWrite_mem && (rd_mem != 5'b00000) && (rd_mem == r2)) begin
            ForwardB = 2'b10;   // forward ALU result to r2
        end

        if (RegWrite_wb && (rd_wb != 5'b00000) && (rd_wb == r1) && !(RegWrite_mem && (rd_mem != 5'b00000) && (rd_mem == r1))) begin
            ForwardA = 2'b01;  // forward write-back result to r1
        end

        if (RegWrite_wb && (rd_wb != 5'b00000) &&  (rd_wb == r2) && !(RegWrite_mem && (rd_mem != 5'b00000) && (rd_mem == r2))) begin
            ForwardB = 2'b01;  // forward write-back result to r2
        end
    end
endmodule