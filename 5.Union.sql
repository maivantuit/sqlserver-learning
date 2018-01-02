use Cop1_PhieuNopTien
go
---Union: Gom 2 bảng lại 1 record(1 bảng), cùng record.(như 2 cái lược, gắn vào nhau thành 1 record)
--kq: báo lỗi(số lượng cột không tương đồng):All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
select * from KhachHang
union 
select * from NhanVien
--kq: là 2 bảng khác biệt
select MaTK from KhachHang
select MaNV from NhanVien
--kq: 1 bảng 1 cột, 8 hàng.
select MaTK from KhachHang
union 
select MaNV from NhanVien
--kq: 1 bảng 1 cột, 2 hàng.
select MaTK from KhachHang
where MaTK='TK001'
union 
select MaNV from NhanVien
where MaNV='NV001'
