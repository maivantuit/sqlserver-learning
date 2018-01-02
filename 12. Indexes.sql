use Cop1_PhieuNopTien
go
---Indexes:
--Giả sử có 10 triệu record (bản ghi cột hoặc hàng), tìm 1 mã MaKH có tồn tại trong bảng hay không
--thì cách tìm kiếm ra mất time, đơ phần mềm. Cách khắc phục là indexes, nhưng thêm dữ liệu đưa vào chậm hơn.
--cho phép trùng nhau:
create index IndexName on KhachHang
create index IndexName on KhachHang(MaKH)
--không cho phép trùng nhau:
create unique index IndexNameUnique on KhachHang(MaKH)
--Ví dụ: có 10 tr record của bảng KhachHang tìm kiếm để kiểm tra.
select * from KhachHang
where MaKH='KH001' 