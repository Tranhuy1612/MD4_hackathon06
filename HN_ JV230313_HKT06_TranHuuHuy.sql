create database quanlisinhvien_hackathon06;
use quanlisinhvien_hackathon06;

create table  khoa(
Makhoa varchar(20) primary key ,
tenkhoa varchar(255)
);
create table dmnganh(
Manganh int auto_increment primary key,
tennganh varchar(255),
makhoa varchar(20),
foreign key (makhoa) references khoa(makhoa)
);
create table sinhvien(
masv int auto_increment primary key,
hoten varchar(255),
malop varchar(20),
foreign key (malop) references dmlop(malop),
gioitinh tinyint(1),
ngaysinh date,
diachi varchar(255)
);
create table diemhp(
id int auto_increment primary key ,
masv int ,
mahp int ,
foreign key (masv) references sinhvien(masv),
foreign key (mahp) references dmhocphan(mahp),
diemhp float
);
create table dmlop(
malop varchar(20) primary key,
tenlop varchar(255) ,
manganh int ,
foreign key (manganh) references dmnganh(manganh),
khoahoc int ,
hedt varchar(255),
namnhaphoc int
);
create table dmhocphan(
mahp int primary key ,
tenhp varchar(255),
sodvht int ,
manganh int,
foreign key (manganh) references dmnganh (manganh),
hocky int
);

insert into khoa (Makhoa,tenkhoa) values
('cntt','Công Nghệ Thông Tin'),
('Kt','Kế Toán'),
('Sp','Sư Phạm');

insert into dmnganh(Manganh,tennganh,makhoa) values 
(140902,'Sư Phạm Toán Tin','Sp'),
(480202,'Tin Học Ứng Dụng','CNTT');

insert into dmlop(malop,tenlop,manganh,khoahoc,hedt,namnhaphoc) values 
('Ct11','Cao Đẳng Tin Học',480202,11,'TC','2013'),
('Ct12','Cao Đẳng Tin Học',480202,12,'CD','2013'),
('Ct13','Cao Đẳng Tin Học',480202,13,'TC','2014');

insert into dmhocphan(mahp,tenhp,sodvht,manganh,hocky)values
(1,'Toán cao cấp A1',4,480202,1),
(2,'Tiếng anh 1',3,480202,1),
(3,'Vật lí đại cương',4,480202,1),
(4,'Tiếng anh 2',7,480202,1),
(5,'TIếng anh 1',3,140902,2),
(6,'Xác suất thống kê',4,480202,2);

insert into sinhvien(masv,hoten,malop,gioitinh,ngaysinh,diachi) values 
(1,'Phan Thanh','Ct12',0, '1990-09-12','Tuy Phước'),
(2,'Nguyễn Thị Cẩm ','Ct12',1, '1994-01-12','Quy Nhơn'),
(3,'Võ Thị Hà','Ct12',1, '1995-07-02','An Nhơn'),
(4,'Trần Hoài Nam','Ct12',0, '1994-04-05','Tây Sơn'),
(5,'Trần Văn Hoàng','Ct13',0, '1995-08-04','VĨnh Thạnh'),
(6,'Đặng Thị Thảo','Ct13',1, '1995-06-12','Quy Nhơn'),
(7,'Lê Thị Sen','Ct13',1, '1994-08-12','Phù Mỹ'),
(8,'Nguyễn Văn Huy','Ct11',0, '1995-06-04','Tuy Phước'),
(9,'Trần THị Hoa','Ct11',1, '1994-08-09','Hoài Nhơn');

insert into diemhp(masv,mahp,diemhp)values
(2,2,5.9),
(2,3,4.5),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4),
(7,1,6.2);

-- 1. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP
--  của những sinh viên có điểm HP >= 5     (5đ)
select s.masv,s.hoten,s.malop,d.diemhp,d.mahp
 from sinhvien s join diemhp d on d.masv = s.masv  where diemhp >=5;

--  2.Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP 
--  được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. (5đ)
select s.masv,s.hoten,s.malop,d.diemhp,d.mahp
 from sinhvien s join diemhp d on d.masv = s.masv
 order by s.malop ,s.hoten asc ;
 
--  3.Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy 
--  của những sinh viên có DiemHP từ 5 --> 7 ở học kỳ I. (5đ)
select sv.masv ,sv.hoten ,sv.malop ,dh.diemhp ,hp.hocky 
from sinhvien sv
join diemhp dh on sv.masv = dh.masv
join dmhocphan hp on dh.mahp = hp.mahp
where dh.diemhp >= 5 and dh.diemhp <= 7 and hp.hocky = 1;
    
--     4.Hiển thị danh sách sinh viên gồm MaSV, HoTen, 
--     MaLop, TenLop, MaKhoa của Khoa có mã CNTT (5đ)
select sv.masv,sv.hoten ,sv.malop ,lop.tenlop ,kh.makhoa
from sinhvien sv
join dmlop lop on sv.malop = lop.malop
join dmnganh nganh on lop.manganh = nganh.manganh
join khoa kh on nganh.makhoa = kh.Makhoa
where kh.Makhoa = 'CNTT';

-- 5.Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): (5đ)
select dl.malop, dl.tenlop , count(sv.masv) as SiSo
from dmlop  dl
 join sinhvien  sv on dl.malop = sv.malop
group by dl.malop;

-- 6.Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ,
--  biết công thức tính DiemTBC như sau:
select hp.hocky,sv.masv ,SUM(dh.diemhp * hp.sodvht) / SUM(hp.sodvht) AS DiemTBC
from sinhvien sv
join diemhp dh on sv.masv = dh.masv
join dmhocphan hp on dh.mahp = hp.mahp
group by sv.masv, hp.hocky;


-- 7.Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select lop.malop ,lop.tenlop ,
    SUM(case when sv.gioitinh = 0 then 1 else 0 end)  SoLuongNam,
    SUM(case when  sv.gioitinh = 1 then 1 else 0 end) SoLuongNu
from dmlop lop
left join sinhvien sv on lop.malop = sv.malop
group by lop.malop, lop.tenlop;

-- 8.Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
select sv.masv ,SUM(dh.diemhp * hp.sodvht) / SUM(hp.sodvht) AS DiemTBC
from sinhvien sv
join diemhp dh on sv.masv = dh.masv
join dmhocphan hp on dh.mahp = hp.mahp
where hp.hocky = 1
group by sv.masv;

-- 9.Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên
select sv.masv MaSV,sv.hoten HoTen,COUNT(*) SoLuong
from sinhvien sv
join diemhp dh on sv.masv = dh.masv
where dh.diemhp < 5
group by sv.masv;

-- 10.Đếm số sinh viên có điểm HP <5 của mỗi học phần
select dh.mahp MaHP,COUNT(*)  SL_SV_Thiếu
from diemhp dh
join dmhocphan hp on dh.mahp = hp.mahp
where dh.diemhp < 5
group by dh.mahp, hp.tenhp;

-- 11.Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên
select sv.masv MaSV,sv.hoten HoTen,SUM(hp.sodvht) Tongdvht
from sinhvien sv
join diemhp dh on sv.masv = dh.masv
join dmhocphan hp on dh.mahp = hp.mahp
where dh.diemhp < 5
group by sv.masv;

-- 12.Cho biết MaLop, TenLop có tổng số sinh viên >2.
select dl.malop, dl.tenlop ,count(sv.masv) as SiSo
from dmlop dl
left join sinhvien  sv on dl.malop = sv.malop
group by dl.malop, dl.tenlop
having count(sv.masv) > 2;

-- 13.	Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5. (10đ)
select sv.masv,sv.hoten , count(dhp.mahp) as soluong
from sinhvien  sv
join diemhp dhp on sv.masv = dhp.masv
where dhp.diemhp < 5
group by sv.masv, sv.hoten
having count(dhp.mahp) >= 2;

-- 14.	Cho biết HoTen sinh viên học ít nhất 3 học phần mã 1,2,3 (10đ)
select sv.hoten , count(distinct dhp.mahp) as soluong
from sinhvien  sv
join diemhp  dhp on sv.masv = dhp.masv
where dhp.mahp in (1, 2, 3)
group by sv.masv, sv.hoten
having count(distinct dhp.mahp) >= 3;



 


