
/*------------------------------------
Filename: alu_t.v
Function: 测试alu模块的逻辑功能的测试用例
------------------------------------*/
`timescale 1ns/1ns
`define half_period 5
module alu_t(y);
    //alu位宽定义
    parameter N = 8;
    
    //输出端口定义
    output signed [N : 0] y;
    
    //寄存器及连线定义
    reg ena, clk;
    reg [1 : 0] opcode;
    reg signed [N - 1 : 0] data1, data2;
    
    //产生测试信号
    initial
    begin
        $dumpfile("aly_t.vcd");
        $dumpvars(0,alu_t);
        $display("my alu test");
        //设置电路初始状态
        #10 clk = 0; ena = 0; opcode = 2'b00;
            data1 = 8'd0; data2 = 8'd0;
        #10 ena = 1;
        
        //第一组测试
        #10 data1 = 8'd8; data2 = 8'd6; //y = 8 + 5 = 14
        #20 opcode = 2'b01; // y = 8 - 6 = 2
        #20 opcode = 2'b10; // 8 > 6 y = 1
        
        //第二组测试
        #10 data1 = 8'd127; data2 = 8'd127; opcode = 2'b00; //y = 127 + 127 = 254
        #20 opcode = 2'b01; //y = 127 - 127 = 0
        #20 opcode = 2'b10; // 127 == 127 y = 0
        
        //第三组测试
        #10 data1 = -8'd128; data2 = -8'd128; opcode = 2'b00; //y = -128 + -128 = -256
        #20 opcode = 2'b01; //y = -128 - (-128) = 0
        #20 opcode = 2'b10; // -128 == -128 y = 0
        
        //第四组测试
        #10 data1 = -8'd53; data2 = 8'd52; opcode = 2'b00; //y = -53 + 52 = -1
        #20 opcode = 2'b01; //y = -53 - 52 = -105
        #20 opcode = 2'b10; //-53 < 52 y = 2
        
        #100 $finish;
    end
    
    //产生时钟
    always #`half_period clk = ~clk;
    
    //实例化
    alu m0(.ena(ena), .clk(clk), .opcode(opcode), .data1(data1), .data2(data2), .y(y));
endmodule