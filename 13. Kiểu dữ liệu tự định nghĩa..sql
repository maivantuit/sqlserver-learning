use Cop1_PhieuNopTien
go
---Kiểu dữ liệu tự định nghĩa: Tạo ra để sử dụng lại, dễ thay đổi.
--Cách tạo:
--exec sp_addtype 'Tên kiểu dữ liệu tự định nghĩa' ,'Kiểu dữ liệu thực tế', ['Not null']
exec sp_addtype 'KieuName', 'nvarchar(100)','Not null'--sp_addtype: thủ tục tạo kiểu dữ liệu tự định nghĩa.
create table TestTpye(
	name KieuName,
	adress nvarchar(100)
)
--Xóa kiểu dữ liệu:nếu đã định nghĩa như trên xóa không được
exec sp_droptype 'KieuName'--sp_droptype: thủ tục xóa kiểu dữ liệu tự định nghĩa.
--Nếu muốn xóa thì phải xóa bảng đó đi.
drop table TestTpye
--thì xóa kiểu dữ liệu tự định nghĩa được
exec sp_droptype 'KieuName'
---Nếu tạo kiểu dữ liệu mà chưa định nghĩa trong table thì xóa được không cần xóa bảng rồi xóa kiểu dữ liệu này
--tạo:
exec sp_addtype 'KieuAdress', 'nvarchar(100)','Not null'
--xóa:
exec sp_droptype 'KieuAdress'
