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


`define     NINT_BITS 12
`define     NFRAC_BITS 4
`define     NTOTAL_BITS 16





module get_rays (
    input   wire    clk;
    input   signed  [NTOTAL_BITS-1:0] f [1:0];             //1/fx  1/fy 
    input   signed  [NTOTAL_BITS-1:0] c [1:0];             //cx cy
    input   signed  [NTOTAL_BITS-1:0] L_ij[1:0];           //取样坐标
    input   signed  [NTOTAL_BITS-1:0] c2w [11:0] ;         //c2w
    output  signed  [NTOTAL_BITS-1:0] rays_o [2:0];        //rays_o
    output  signed  [NTOTAL_BITS-1:0] rays_d [2:0];        //rays_d
//  input   wire    valid_in;                                                               //输入合法信号
//  input   wire    valid_pulse;                                                            //输入合法脉冲
);
    



assign rays_o =c2w;


function [NTOTAL_BITS-1:0] mul;
	input [NTOTAL_BITS-1:0] a, b;
    reg [2*NTOTAL_BITS-1:0] product;
	begin
		product = $signed(a) * $signed(b);
        mul=product[NTOTAL_BITS+NFRAC_BITS-1:NFRAC_BITS];
	end
endfunction


endmodule