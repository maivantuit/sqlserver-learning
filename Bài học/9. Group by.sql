use Cop1_PhieuNopTien
go
---Group by:
select * from GiaoDich,KhachHang
select COUNT(*) from KhachHang,GiaoDich
where  KhachHang.MaTK=GiaoDich.MaTK
group by HoTen,LoaiGD

