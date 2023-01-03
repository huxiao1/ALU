
/*----------------------------------------------------------------
Filename: alu.v
Function: 设计一个N位的ALU(实现两个N位有符号整数加 减 比较运算)
-----------------------------------------------------------------*/
module alu(ena, clk, opcode, data1, data2, y);
    //定义alu位宽
    parameter N = 8; //输入范围[-128, 127]
    
    //定义输入输出端口
    input ena, clk;
    input [1 : 0] opcode;
    input signed [N - 1 : 0] data1, data2; //输入有符号整数范围为[-128, 127] 
    output signed [N : 0] y; //输出范围有符号整数范围为[-255, 255]
    
    //内部寄存器定义
    reg signed [N : 0] y;
    
    //状态编码
    parameter ADD = 2'b00, SUB = 2'b01, COMPARE = 2'b10;
    
    //逻辑实现
    always@(posedge clk)
    begin
        if(ena)
        begin
            casex(opcode)
                ADD: y <= data1 + data2; //实现有符号整数加运算
                SUB: y <= data1 - data2; //实现有符号数减运算
                COMPARE: y <= (data1 > data2) ? 1 : ((data1 == data2) ? 0 : 2); //data1 = data2 输出0; data1 > data2 输出1; data1 < data2 输出2;
                default: y <= 0;
            endcase
        end
    end
endmodule