//FHEADER-------------------------------------------
//FILE NAME: sample_points_uv.v
// DEPARTMENT : pku
//Author: zzlt
//EMAIL: zzlt2000@pku.edu.cn
//---------------------------------------------------
//RELEASE HISTORY:
//VERSION DATE AUTHOR DESCRIPTION
//v0.1 23/02/20 初始配置
//v0.2 23/03/05 端口以及时序修改
//---------------------------------------------------
//rays上均匀取样点，默认存在gt_depth
//---------------------------------------------------
// PARAM NAME RANGE : DESCRIPTION : DEFAULT : UNITS



module sample_points_uni (
    input   wire    clk;                                                                    //时钟
    input   wire    rst_n;                                                                  //复位信号
    input   wire    i_max_valid;                                                            //输入合法信号
    input   signed  wire    [NTOTAL_BITS-1:0]  gt_depth;                                    //groundtruth depth；
    input   signed  wire    [3*NTOTAL_BITS-1:0]  rays_o;                                    //单个rays_o坐标
    input   signed  wire    [3*NTOTAL_BITS-1:0]  rays_d;                                    //单个rays_d向量
    output  signed  wire    [NTOTAL_BITS-1:0]  pts     [3*N_samples-1:0] ;                  //sample points
);

reg     valid_1;
reg     valid_2;
wire    valid_pulse;


reg     signed  [NTOTAL_BITS-1:0] far;                                              //最远边界
reg     signed  [NTOTAL_BITS-1:0] near;                                             //最近边界
reg     signed  [NTOTAL_BITS-1:0] diff = far - near;                                //最近与最远的差值


//输入准备信号
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        valid_1 <=0;
        valid_2 <=0;
    end
    else begin
        valid_1 <= i_max_valid;
        valid_2 <= valid_1;
    end
end

assign valid_pulse = valid 1&(~valid 2);










endmodule