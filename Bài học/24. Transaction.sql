use Cop1_PhieuNopTien	
go
----Transaction:
select * from NhanVien
--TH 1: bắt đầu 1 tranc kết thúc rolb thì lệnh xóa đó được quay lại và báo đã xóa được, nhưng dữ liệu được phục hồi
begin	transaction
delete NhanVien	where MaNV='NV010'
-- chuỗi thao loằn ngoằng phức tạp
rollback
--=>
--TH 2: Xóa được.
begin	transaction
delete NhanVien	where MaNV='NV010'
-- chuỗi thao loằn ngoằng phức tạp
commit --- Chấp nhận transaction
--=>
--TH 3: Xóa được
declare @trans varchar(20)
select @trans='Trans1'
begin	transaction @trans
delete NhanVien	where MaNV='NV010'
-- chuỗi thao loằn ngoằng phức tạp
commit transaction @trans--- Chấp nhận transaction
--TH 4: Tạo mốc transaction để quay lại
begin transaction
save transaction trans1
delete NhanVien where MaNV='NV008'
commit

begin transaction
save transaction trans2
delete NhanVien where MaNV='NV007'

rollback transaction trans1