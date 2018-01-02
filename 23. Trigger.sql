use Cop1_PhieuNopTien	
go
---Trigger: 
--Tự động thực hiện khi có thay tác cập nhật dữ liệu,để bắt được sự kiện cập nhật dữ liệu
--Một trigger được định nghĩa trên mổ bảng nhưng các xử lý trong trigger có thể sử dụng nhiều bảng khác.
--Khi bị thay đổi thì các dữ liệu mà bảng đó tham chiếu đều bị thay đổi.(ví dụ: trong lớp 40 người. cập nhật thêm 1 sinh viên vào bảng sinh viên thì số lượng trong bảng lớp phải tăng lên 1)-
--Dùng trigger để tạo ra các công việc tự động thay vì phải làm thủ công bằng tay như kiểu tra dữ liệu, đồng bộ hóa dữ liệu, đảm bảo cho mối quan hệ giữa các bảng,...
---2 Bảng tạm: chỉ tồn tại trong thời gian trigger đang xữ lý.
--Inserted: chứa những (dữ liệu) trường đã(sẽ được) insert | update vào bảng
--Deleted:chứa những (dữ liệu) trường đã(sẽ được) bị xóa khỏi bảng (ví dụ xóa sinh viên thì không thể xóa vĩnh viễn mà vào data khác )
--(Update=delete dòng chứa giá trị cũ + insert dòng chưa giá trị mới)
--Lưu ý: if update (column_list): dùng để kiểm tra sự thay đổi trên column_list.
--Cú pháp:
/*
	create trigger Tentrigger on TenBang<table | view> for<for | after | instead of> <Sự kiện: insert,update,delete>
	as
	begin
	--Đầu vào: tạo các biến đầu, gây ra cho 1 kq của nghiệm vụ.
	--Làm trên bảng nào thêm biến khóa
		-- Thêm tigger được phép truy xuất
		-- 2 table có cấu trúc như table
		-- inserted: hình ảnh mới sau cập nhật
		-- Deleted: hình ảnh cũ trước cập nhật
		--Kq: nghiệp vụ ở đây
	end
	
*/
---For | after:
-- trigger được gọi thực hiện khi thao tá insert,update,delete tương ứng đã được thực hiện thành công.
-- Các dòng mới được thêm đồng thời chưa trong dữ liệu và bảng inserted
-- Các dòng bị xóa chỉ nằm trong bảng deleted
-- Roll transaction: Có thể lý quay lui các thao tác  đã thực hiện thao tác

--- Instead of:
-- trigger được gọi thay cho thao tác insert, update, delete tương ứng:
-- các dòng mới được thêm chỉ chứa trong bảng inserted
-- Các dòng bị định chỉ xóa nằm đồng thời trong bảng deleted và bảng dữ liệu
-- trigger instead of thường dùng để xử lý cập nhật khùng nhìn (view).

--Sử dụng: alter để thay đổi trigger
--Mỗi lần thay đổi nó vào trigger, làm tốc độ truy vấn chậm đi.

---Ví dụ 1:
create trigger TG_InsertNhanVien on NhanVien for Insert--,update ,delete
as
begin
	--rollback tran
	print 'Trigger'
end
insert into NhanVien values('NV011',N'Hoàng Quốc Bảo','05/09/1997','50000000',N'Nam')-- kq: là trigger trên chạy cùng lệnh chèn này: =>lệnh insert  tự động được gọi trong trigger
select * from NhanVien
---Ví dụ 2:
create trigger TG_InsertNhanVien2 on NhanVien for Insert--,update ,delete
as
begin
	rollback transaction
	print 'Trigger2'
end
insert into NhanVien values('NV011',N'Hoàng Quốc Bảo','05/09/1997','50000000',N'Nam')
--kq: bị lỗi k insert được: phiên làm việc đã kết thúc, xữ lý bị hủy bỏ bởi rolllback tran.
select * from NhanVien
drop trigger TG_InsertNhanVien
---Ví dụ 3: Bắt sự kiện không cho phép xóa thông tin của nhân viên có tuổi nhỏ hơn 1
alter trigger NotdelThan25 on NhanVien for delete
as
begin
	declare @dem int =0
	select @dem =Count(*) from deleted
	where year(getdate())-year(deleted.NgaySinh)<1
	if(@dem>0)
	begin
		print N'Không được xóa người nhỏ 1 tuổi'
		rollback tran
	end
end
--Chèn 1 nhân viên có tuổi 1.
insert into NhanVien values('NV012',N'Mầm non','08/06/2017','300000',N'Nữ')
--Thử xóa:
delete NhanVien where MaNV='NV012'--kq:Không được xóa người nhỏ 1 tuổi error:The transaction ended in the trigger. The batch has been aborted.


---Ví dụ 4: 
---Lược đồ cơ sở dữ liệu:
--SinhVien(MaSV,TenSV,NgaySinh,MaLop)
--Lop(MaLop,TenLop)
--MonHoc(MaMH,TenMH)
--KetQua(MaSV,MaMH,LanThi,Diem)


create table SinhVien(
	MaSV char(10) primary key,
	TenSV nvarchar(30),
	NgaySinh date,
	MaLop char(10) foreign key references Lop(MaLop)
)
select * from SinhVien
insert into SinhVien values('SV1',N'Mai Văn Tú','03/30/1995','L1')
insert into SinhVien values('SV2',N'Nguyễn Văn A','03/30/1995','L1')
insert into SinhVien values('SV3',N'Nguyễn Văn B','03/30/1995','L1')
insert into SinhVien values('SV4',N'Nguyễn Văn C','03/30/1995','L1')
create table Lop(
	MaLop char(10) primary key,
	TenLop varchar(10)
)

insert into Lop values('L1',N'15T4')
insert into Lop values('L2',N'15T1')
insert into Lop values('L3',N'15T3')
insert into Lop values('L4',N'15T2')
update Lop set SoLuong='0' where MaLop='L4'
select * from Lop
create table MonHoc(
	MaMH char(10) primary key,
	TenMH nvarchar(30)
)
create table KetQua(
	MaSV char(10) foreign key references SinhVien(MaSV),
	MaMH char(10)foreign key references MonHoc(MaMH),
	constraint PK_KetQua primary key (MaSV,MaMH),
	LanThi int,
	Diem float
)
select * from SinhVien
select * from Lop

---Viết trigger khi chèn 1 sinh viên vào lớp nhất định thì lớp đó tăng lên 1 người
alter trigger tg_SinhVien_insert on SinhVien after insert
as
begin
	declare @malop char(10)
	set @malop = (select MaLop from inserted)
	declare @dem int
	set @dem =(select count(*) from SinhVien where MaLop=@malop)
	update Lop set SoLuong = @dem where MaLop=@malop
end
insert into SinhVien values('SV12',N'Trần Minh Hùng 4','04/10/1997','L1')
delete SinhVien where MaSV='SV10'
drop trigger tg_SinhVien_insert
---Viết trigger khi xóa 1 sinh viên vào lớp nhất định thì lớp đó giảm lên 1 người
create trigger tg_SinhVien_delete on SinhVien for delete
as
begin
	declare @malop char(10) --biến bảng thay đổi sau
	declare @dem int  --biến để đếm
	-- đối với biến bảng cần cập nhật sự kiện thì @masv không cần khai báo.
	set @malop = (select MaLop from deleted)
	set @dem = (select count(*) from SinhVien where MaLop=@malop)  -- đếm sinh viên với đk MaLop = @malop.
	update Lop set SoLuong =@dem where MaLop=@malop
end
--nếu xóa 2 sv 1 lần thì vẫn cập nhật đúng số sinh viên của lớp.
delete SinhVien where MaSV='SV3'
delete SinhVien where MaSV='SV7'
---Viết trigger khi update dữ liệu  sinh viên thì lớp đó không bị giảm số lượng
create trigger tg_SinhVien_update on SinhVien for update
as
begin
	declare @malop char(10) --biến bảng thay đổi sau
	declare @dem int  --biến để đếm
	-- đối với biến bảng cần cập nhật sự kiện thì @masv không cần khai báo.
	set @malop = (select MaLop from deleted)
	set @dem = (select count(*) from SinhVien where MaLop=@malop)  -- đếm sinh viên với đk MaLop = @malop.
	update Lop set SoLuong =@dem where MaLop=@malop
end
update SinhVien set TenSV=N'Hồng Bảo Ngân' where MaSV='SV4'
select * from SinhVien
select * from Lop