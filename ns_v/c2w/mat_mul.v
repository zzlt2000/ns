//FHEADER-------------------------------------------
//FILE NAME: matmul.v
// DEPARTMENT : pku
//Author: zzlt
//EMAIL: zzlt2000@pku.edu.cn
//---------------------------------------------------
//RELEASE HISTORY:
//VERSION DATE AUTHOR DESCRIPTION
//v0.1 23/02/20 zzlt intial release
//---------------------------------------------------


`define     NINT_BITS 12
`define     NFRAC_BITS 4
`define     NTOTAL_BITS 16


module mat_mul(
    input   signed [NTOTAL_BITS-1:0] a[2:0][2:0], 
    input   signed [NTOTAL_BITS-1:0] b[0:2][0:2], 
    output  signed [NTOTAL_BITS-1:0] result[0:2][0:2]
    );


integer i, j, k;
    
    // Instantiate the fixed-point multiplier module
generate
    for (i = 0; i < 3; i = i + 1) begin
        for (j = 0; j < 3; j = j + 1) begin
            fix_mul #(.INT_BITS(NINT_BITS), .FRAC_BITS(NTOTAL_BITS)) mult(a[i][0], b[0][j], result[i][j]);
            for (k = 1; k < 4; k = k + 1) 
            begin
                fix_add add(result[i][j], mult.product, result[i][j]);
                mult.a = a[i][k];
                mult.b = b[k][j];
            end

        end
    end
endgenerate

endmodule