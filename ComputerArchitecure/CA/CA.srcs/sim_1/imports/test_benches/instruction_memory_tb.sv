module instruction_memory_tb;

  reg  [31:0] A;  // Địa chỉ
  reg         rst;  // Tín hiệu reset
  wire [31:0] RD;  // Dữ liệu đầu ra từ bộ nhớ

  // Khởi tạo mô-đun instruction_memory
  instruction_memory im (
      .A  (A),
      .rst(rst),
      .RD (RD)
  );

  // Khối khởi tạo cho testbench
  initial begin
    // Khởi tạo tín hiệu
    rst = 1'b1;  // Đặt reset ban đầu
    A   = 32'b0;  // Địa chỉ bắt đầu từ 0

    // Thực hiện reset
    #5 rst = 1'b0;  // Sau 5 thời gian đơn vị, bỏ reset

    // Đọc lệnh từ bộ nhớ và kiểm tra
    #10 A = 32'd0;  // Đọc từ địa chỉ 0 (lệnh sw)
    #10 A = 32'd1;  // Đọc từ địa chỉ 4 (lệnh lw)

    // Kết thúc mô phỏng sau một thời gian
    #20 $finish;
  end

  // Khối giám sát kết quả
  initial begin
    $monitor("At time %t, A = %h, RD = %h, rst = %b", $time, A, RD, rst);
  end

endmodule
