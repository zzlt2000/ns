//FHEADER-------------------------------------------
//FILE NAME: sample_points_uni.v
// DEPARTMENT : pku
//Author: zzlt
//EMAIL: zzlt2000@pku.edu.cn
//---------------------------------------------------
//RELEASE HISTORY:
//VERSION DATE AUTHOR DESCRIPTION
//v0.1 23/02/20 zzlt intial release
//---------------------------------------------------



`define     N_samples 32
`define     N_surface 16
`define     NINT_BITS 12
`define     NFRAC_BITS 4
`define     NTOTAL_BITS 16


module sample_points_uni (
    input   clk;
    input   signed  wire    [NTOTAL_BITS-1:0]  far;                                         //far边界
    input   signed  wire    [NTOTAL_BITS-1:0]  near;                                        //near边界 
    input   signed  wire    [NTOTAL_BITS-1:0]  rays_o  [2:0];                               //单个rays_o坐标
    input   signed  wire    [NTOTAL_BITS-1:0]  rays_d  [2:0];                               //单个rays_d向量
    output  signed  wire    [NTOTAL_BITS-1:0]  pts     [3*N_samples-1:0];                   //sample points
);

reg     signed  [NTOTAL_BITS-1:0] diff = far - near;
reg     signed  [NTOTAL_BITS-1:0] step = (diff >> 5);                               // 对于N_sample=32情况
reg     signed  [NTOTAL_BITS-1:0] current = near;                                   // 起始位
reg     signed  [NTOTAL_BITS-1:0] sample    [N_samples-1:0];  
reg     signed  [NTOTAL_BITS-1:0] temp      [N_samples-1:0] [2:0];
    
    
// 正常均匀采样点   z_vals = near * (1.-t_vals) + far * (t_vals)

integer i;
always @(*) 
begin
    for (i = 0; i < N_samples; i = i + 1) 
    begin
        samples[i] = current;
        current = current + step;     
    end
end

integer  j, k;
generate
    for (j = 0; i < N_samples; i = i + 1) 
    begin
        for (k = 0; k < 3; k = k + 1) 
        begin
            fix_mul #(.INT_BITS(NINT_BITS), .FRAC_BITS(NFRAC_BITS),.TOTAL_BITS(NTOTAL_BITS)) mult(rays_d[k], sample[j], temp[j][k]);
            fix_add add(rays_o[k], temp[j][k], pt[j][k]);
        end
    end
endgenerate

    
    
endmodule

