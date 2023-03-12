//每次握手后传入顺序的一个点的raw信息
//weight 比较完后前级发出复位信号，并发出下一级color有效脉冲
//默认存在occupancy


module to_color (
    input   wire    clk;                                                                    //时钟
    input   wire    rst_n;                                                                  //复位信号
//  input   wire    valid_in;                                                               //输入合法信号
    input   wire    valid_pulse;                                                            //输入合法脉冲
    input   signed  wire    [4*NTOTAL_BITS-1:0]   raw;                                      //raw 信息
    input   signed  wire    [NTOTAL_BITS-1:0]     z_vals;                                   //取样位置
    output  signed  wire    [NTOTAL_BITS-1:0]     depth;                                    //深度信息
    output  signed  wire    [3*NTOTAL_BITS-1:0]   color ;                                   //颜色信息
    output  signed  wire    [NTOTAL_BITS-1:0]     weight;                                   //weight信息
);      

/*
reg     valid_1;
reg     valid_2;       
wire    valid_pulse;
*/


reg   signed    [NTOTAL_BITS-1:0]   z_vals_r;     //取样位置
reg   signed    [NTOTAL_BITS-1:0]   raw_r  [3:0]; //rgbσ信息

reg   signed    [NTOTAL_BITS-1:0]   weight_r;     //当前权值
reg   signed    [NTOTAL_BITS-1:0]   color_r;      //当前color
reg   signed    [NTOTAL_BITS-1:0]   depth_r;      //当前深度
reg   signed    [NTOTAL_BITS-1:0]   pi_alpha;     //累乘
wire  signed    [NTOTAL_BITS-1:0]   tmp;          //当前权重  

/*
//接收数据
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        valid_1 <=1'b0;
        valid_2 <=1'b0;
    end
    else begin
        valid_1 <= valid_in;
        valid_2 <= valid_1;
    end
end

assign valid_pulse= valid 1&(~valid 2);
*/

//load data

always@(posedge valid_pulse or negedge rst_n)begin
    if(~rst_n) begin

        z_vals_r <= NTOTAL_BITS'b0;
        raw_r[0] <= NTOTAL_BITS'b0;
        raw_r[1] <= NTOTAL_BITS'b0;
        raw_r[2] <= NTOTAL_BITS'b0;
        raw_r[3] <= NTOTAL_BITS'b0;
    end
    else begin
        z_vals_r <= z_vals;

        raw_r[0] <= raw[1*NTOTAL_BITS-1:0]
        raw_r[1] <= raw[2*NTOTAL_BITS-1:1*NTOTAL_BITS]
        raw_r[2] <= raw[3*NTOTAL_BITS-1:2*NTOTAL_BITS]
        raw_r[3] <= raw[4*NTOTAL_BITS-1:3*NTOTAL_BITS]

    end

end


always@ (z_vals or negedge rst_n) begin
    if(~rst_n) begin
        pi_alpha   <= NTOTAL_BITS'b1;
        weight_r   <= NTOTAL_BITS'b0;
        depth_r    <= NTOTAL_BITS'b0;
        color_r[0] <= NTOTAL_BITS'b0;
        color_r[1] <= NTOTAL_BITS'b0;
        color_r[2] <= NTOTAL_BITS'b0;
    end
    else begin
        pi_alpha   <= mul(((NTOTAL_BITS'b1<<<NFRAC_BITS)-sigmoid(raw_r[3])), pi_alpha);
        weight_r   <= tmp;
        depth_r    <= tmp*z_vals_r+depth_r;
        color_r[0] <= color_r[0] + raw_r[0] *tmp;
        color_r[1] <= color_r[1] + raw_r[1] *tmp;    
        color_r[2] <= color_r[2] + raw_r[2] *tmp;   
    end

end

assign tmp = sigmoid(raw_r[3])*pi_alpha;
assign weight = weight_r;
assign depth = depth_r;
assign color[1*NTOTAL_BITS-1:0*NTOTAL_BITS]=color_r[0];
assign color[2*NTOTAL_BITS-1:1*NTOTAL_BITS]=color_r[1];
assign color[3*NTOTAL_BITS-1:2*NTOTAL_BITS]=color_r[2];


function [NTOTAL_BITS-1:0] mul;
	input [NTOTAL_BITS-1:0] a, b;
    reg [2*NTOTAL_BITS-1:0] product;
	begin
		product = $signed(a) * $signed(b);
        mul=product[NTOTAL_BITS+NFRAC_BITS-1:NFRAC_BITS];
	end
endfunction

//计算weight sigmoid函数用1/2+x/4拟合，实际操作中还要×10
function [NTOTAL_BITS-1:0] sigmoid;
	input [NTOTAL_BITS-1:0] a;
	begin
        sigmoid=mul(a,(NTOTAL_BITS'h0028<<(NFRAC_BITS-4)));
	end
endfunction




endmodule