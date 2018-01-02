use Cop1_PhieuNopTien
go
---Truy vấn lồng, tách câu truy vấn thành các câu truy vấn đơn giản.
---Các ví dụ dưới chỉ là mô phỏng còn thực tế thì có bài tập khác để tư duy.
--Sử dụng trong in, trong điều kiện
select * from GiaoDich
where MaTK='TK002'
and MaTK in(select MaTK from KhachHang)
--Truy vấn lòng trong from, nhưng phải có định danh as, để sau sử dụng lại.
select * from KhachHang,(select * from NhanVien) as NV
--
select * from GiaoDich as GD
where SoTien>(
	select COUNT(*) from KhachHang
	where MaTK=GD.MaTK
)
--Sắp xếp tăng dần số tiền của khách hàng có mã TK001 đã chuyển khoản đi.
select * from GiaoDich
order by (select SoTien from GiaoDich
where MaTK='TK001' and LoaiGD='C' )  ASC--DESC--ASC
