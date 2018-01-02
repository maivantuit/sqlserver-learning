use Cop1_PhieuNopTien
go
---inner join(hay join).
select * from KhachHang inner join GiaoDich
on KhachHang.MaTK=GiaoDich.MaTK--kq: 5 bản ghi
--khi đảo lại GiaoDich với KhachHang, không bị thay đổi bản ghi
select * from GiaoDich inner join KhachHang
on KhachHang.MaTK=GiaoDich.MaTK--kq: 5 bản ghi
---left join: bản bên phải nhập vào bên trái, record nào bảng phải không có thì để null, record bảng trái thì không điền vào.
select * from KhachHang left join GiaoDich
on KhachHang.MaTK=GiaoDich.MaTK--kq: 8 bản ghi, chứa null
--khi đảo lại GiaoDich với KhachHang,  bị thay đổi bản ghi
select * from GiaoDich left join KhachHang
on KhachHang.MaTK=GiaoDich.MaTK--kq: 5 bản ghi, chứa null
---right join: bản bên phải nhập vào bên trái, record nào bảng phải không có thì để null, record bảng trái thì không điền vào.
select * from KhachHang right join GiaoDich
on KhachHang.MaTK=GiaoDich.MaTK--kq: 5 bản ghi, chứa null
--khi đảo lại GiaoDich với KhachHang, bị thay đổi bản ghi
select * from GiaoDich right join KhachHang
on KhachHang.MaTK=GiaoDich.MaTK--kq: 8 bản ghi, chứa null