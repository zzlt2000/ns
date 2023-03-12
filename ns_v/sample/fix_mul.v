//FHEADER-------------------------------------------
//FILE NAME: fix_mul.v
// DEPARTMENT : pku
//Author: zzlt
//EMAIL: zzlt2000@pku.edu.cn
//---------------------------------------------------
//RELEASE HISTORY:
//VERSION DATE AUTHOR DESCRIPTION
//v0.1 23/02/20 zzlt intial release
//---------------------------------------------------
//PARAMETER DESCRIPTION:
//NAME, RANGE, DESCRIPTION, DEFAULT
//a [TOTAL_BITS-1,0] 被乘数
//b [TOTAL_BITS-1,0] 被乘数
//prod [TOTAL_BITS-1,0] 整数相乘结果
//product [TOTAL_BITS-1,0] 最终结果
//---------------------------------------------------


//behavioral floating-point multiplication




module fix_mul #(parameter INT_BITS = 12, FRAC_BITS = 4 ,TOTAL_BITS=16)(
    input   wire    signed [TOTAL_BITS-1:0] a,
    input   wire    signed [TOTAL_BITS-1:0] b,
    output  wire    signed [TOTAL_BITS-1:0] product
    );
    
    reg signed [2*TOTAL_BITS-1:0] prod=0;
    
    always @(a, b) 
    begin
        prod = $signed(a) * $signed(b);
        product = prod>>FRAC_BITS;
    end
endmodule