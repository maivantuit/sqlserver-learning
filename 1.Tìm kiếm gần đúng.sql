use Cop1_PhieuNopTien
go
---Tìm kiếm gần đúng
--%: đại diện cho 1 cụm kí tự
-- 
select * from KhachHang
--Tìm kiếm tên khách hàng bắt đầu bằng chữ N
select * from KhachHang
where HoTen like 'N%'--kq: ra 1 list bắt đầu bằng chữ 'N', vd: Nguyễn Văn A
--Tìm kiếm tên khách hàng kết thúc bằng chữ Tú
select * from KhachHang
where HoTen like '%Tú'--kq: ra Mai Văn Tú
--Tìm kiếm tên khách hàng là Mai Văn Tú
select * from KhachHang
where HoTen like N'Mai Văn Tú'--kq: ra Mai Văn Tú
select * from KhachHang
where HoTen = N'Mai Văn Tú'
--Tìm khách hàng có mã khách hàng = 'KH002', 2 cách vẫn ra.
select * from KhachHang
where MaKH like 'KH002'
select * from KhachHang
where MaKH = 'KH002'





