use Cop1_PhieuNopTien
go
---Select into: dùng để tạo 1 mới backup, đây không phải bảng tạm, bảng mới hoàn toàn.
--Tạo ra bảng BangA, sao chép hết dữ liệu trong bảng KhachHang sang bảng BangA vừa tạo
--bảng này có các record tương ứng như bảng KhachHang
select * into BangA from KhachHang
--Xóa BangA, để làm tiếp.
 drop table BangA
--Tạo ra bảng mới là BangB, sao chép dữ liệu gồm trường HoTen được lấy từ bảng KhachHang sang bảng BangB vừa tạo
select HoTen into BangB from KhachHang
select * from  BangB--kq:
--Tạo ra bảng mới là BangC, sao chép dữ liệu gồm trường HoTen được lấy từ bảng KhachHang sang bảng BangB vừa tạo, với điều kiện là HoTen khách hàng đó tên là Mai Văn Tú
select HoTen into BangC from KhachHang where HoTen like N'Mai Văn Tú'
select * from  BangC--kq: 1 bảng BangC có 1 trường là HoTen: Mai Văn Tú
--Tạo ra 1 bảng BangD Backup, gồm mã khách hàng, tên khách hàng, ngày giờ, giao dịch với số tiền là bao nhiêu.Dữ liệu được lấy từ 2 bảng KhachHang và GiaoDich
select KH.MaTK,KH.HoTen,NgayGio,LoaiGD,SoTien into BangD
from KhachHang as KH, GiaoDich
where KH.MaTK=GiaoDich.MaTK
--kiểm tra bảng Backup- BangD
select * from BangD
