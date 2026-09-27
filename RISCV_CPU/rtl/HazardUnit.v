module hazard_unit (
    input wire [4:0] r1,
    input wire [4:0] r2,
    input wire [4:0] rd_mem,
    input wire MemRead_mem,
    input wire UsesR1,
    input wire UsesR2,

    output reg stall
);

    always @(*) begin

        stall = 1'b0;   //no stall

        if (MemRead_mem &&  (rd_mem != 5'b00000) && ((UsesR1 && (rd_mem == r1)) || (UsesR2 && (rd_mem == r2)) )) begin
            stall = 1'b1;
        end
    end
endmodule