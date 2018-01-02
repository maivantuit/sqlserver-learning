use Cop1_PhieuNopTien
go
---Full outer join: trả lại kết quả 2 bảng gộp lại với nhau, bảng này không có dữ liệu giống nhau thì trả về null, rất hiếm sử dụng
--điều kiên: "on"
select * from KhachHang, GiaoDich
where KhachHang.MaTK=GiaoDich.MaTK
--kq: 5 bản ghi
select * from KhachHang full outer join GiaoDich
on KhachHang.MaTK=GiaoDich.MaTK
--kq: 8 bản ghi
---Cross join: là tổ hợp mỗi record của bảng A với all record của bảng B
--điều kiện là where, không phải "on" như inner join và full outer join.
select * from KhachHang cross join GiaoDich--kq: 30 bản ghi, giống select * from KhachHang, GiaoDich

select * from KhachHang cross join GiaoDich
where KhachHang.MaTK=GiaoDich.MaTK--kq: 5 bản ghi