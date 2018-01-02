use Cop1_PhieuNopTien
go
---Cursor:
--Khi có nhu cầu duyệt từng record của bảng, với mỗi record có kết quả xứ lý riêng thì dùng cursor
--Declare <Tên con trỏ> cursor for <câu select> --Khởi tạo con trỏ dựa trên câu truy vấn gì
--Open <Tên con trỏ> -- mở con trỏ ra sử dụng
--FETCH NEXT FROM <tên con trỏ > INTO <Danh sách các biến tương ứng kết quả truy vấn> --Đưa con trỏ nào vào biến nào để lấy ra sử dụng
--While @@FETCH_STATUS =0
--begin
--câu lệnh thực hiện
--FETCH NEXT lại lần nữa
--FETCH NEXT FROM <Tên con trỏ > INTO <Danh sách các biến tương ứng kết quả truy vấn>
--end
--Close <Tên con trỏ>
--DEALLOCATE <Tên con trỏ> -- Hủy vùng nhớ xin cấp phát đi.

--Con trỏ trong sql như con trỏ cấp phát động trong C cấu trúc và giải thuật, dùng để thay đổi dữ liệu từng recod 1.


---Ví dụ 1: Nếu tuổi NhanVien >= 25 tuổi thì cho lương là 25000000
--nếu tuổi NhanVien <25 cho lương là 15000000
--nếu < 20 cho lương là 9000000
--1. Tính tuổi của mỗi nhân viên: năm hiện hành - năm sinh=tuổi.
select year(getdate())-YEAR(NgaySinh) from NhanVien
--hoặc:
select year(getdate())-YEAR(NgaySinh) as Tuoi from NhanVien
--2. Lấy MaNV và Tuổi từ bảng NhanVien
select MaNV,HoTen,year(getdate())-YEAR(NgaySinh) as Tuoi from NhanVien
select *from NhanVien
--3. Lấy ra danh sách MaNV,Tuoi đưa vào con trỏ có tên là NhanVienCurcor
declare NhanVienCursor cursor for select MaNV, year(GETDATE())-year(NgaySinh) from NhanVien
open NhanVienCursor
declare @manv char(5)
declare @tuoi int	
FETCH NEXT FROM NhanVienCursor into @manv,@tuoi
while @@FETCH_STATUS=0 -- không còn phần kế tiếp nữa
begin
	if @tuoi>=25
		begin
			update NhanVien set Luong=25000000 where MaNV=@manv
		end
	else
	begin
		if @tuoi<25 and @tuoi >20
		begin
			update NhanVien set Luong = 15000000 where MaNV=@manv
		end
		else
		begin
			if @tuoi<20
			begin
				update NhanVien set Luong =9000000 where MaNV=@manv
			end
		end
	end
	FETCH NEXT FROM NhanVienCursor into @manv,@tuoi
end

close NhanVienCursor
deallocate NhanVienCursor
--Xem kết quả.
select MaNV,HoTen,year(getdate())-YEAR(NgaySinh) as Tuoi,Luong from NhanVien
---Điều rút ra: Khi sử dụng con trỏ truy vấn khá là lâu, khi cần truy vấn với mức độ phức tạp
--thì sử dụng con trỏ, còn bình thường thì sử dụng truy vấn lồng và đặt biến.
