//FHEADER-------------------------------------------
//FILE NAME: c2w.v
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
//CNT_INIT [40,60] Counter Initial vaule, 60
//---------------------------------------------------


//behavioral floating-point multiplication
    
    
    
    
module fix_add(
    input   wire    signed [31:0] a;
    input   wire    signed [31:0] b;
    output  reg     signed [31:0] sum;
    );

always @(a, b) 
begin
    sum = a + b;
end
    
endmodule
