﻿--select	MAHANG,TENHANG,SOLUONG,GIAHANG,SOLUONG*GIAHANG As THANHTIEN
--from MATHANG

--SELECT (GIABAN*SOLUONG)-(GIABAN*SOLUONG*MUCGIAMGIA/100) AS'THANHTIEN'
--FROM CHITIETDATHANG

-- CÂU LỆNH CASE.. WHEN.. END
-- CÚ PHÁP:
/* CASE
  WHEN <BIỂU THỨC ddk1> THEN <CÂU LỆNH 1>
  ELSE <CÂU LỆNH 2>
END*/

/* EX:
SELECT MASV,HODEM+' '+TEN AS HOTEN,
	CASE 
		WHEN GIOITINH=0 THEN N'NỮ'
		ELSE 'NAM'
	END AS GIOITINH
FROM SINHVIEN
*/

-- TỪ KHÓA : DISTINCT :LOẠI BỎ CÁC KẾT QUẢ DỮ LIỆU TRÙNG NHAU
/*SELECT MANHANVIEN,HO+' '+TEN AS HOVATEN,LUONGCOBAN,PHUCAP,
CASE
	WHEN PHUCAP IS NULL THEN LUONGCOBAN
	ELSE LUONGCOBAN+PHUCAP
	END AS LUONG
FROM NHANVIEN*/

-- Giới hạn kết quả hiển thị : TOP, PERCENT
/*select top 5  MAHANG,TENHANG,GIAHANG
from MATHANG
order by GIAHANG desc*/


--from: inner join/join
--cấu trúc:
--FROM
--<tên bảng 1> inner oin/join <tên bảng 2>
--ON 
--<tên bảng 1>.<tên cột chung> = <tên bảng 2>.<tên cột chung>
--VD: 
from
nhacungcap join mathang on 
nhacungcap.macongty = mathang.macongty


--vd5.6 trong bài tập: Cho biết mỗi mặt hàng trong công ty do ai cung cấp.
--Hiển thị: mahang,tenhang,manhacungcap,

SELECT NHACUNGCAP.MACONGTY,TENCONGTY,TENGIAODICH,MAHANG,TENHANG
from MATHANG JOIN NHACUNGCAP ON MATHANG.MACONGTY=NHACUNGCAP.MACONGTY

SELECT LOAIHANG.MALOAIHANG,TENLOAIHANG,NHACUNGCAP.TENCONGTY
from MATHANG JOIN NHACUNGCAP ON MATHANG.MACONGTY=NHACUNGCAP.MACONGTY
			 JOIN LOAIHANG ON MATHANG.MALOAIHANG=LOAIHANG.MALOAIHANG

--ví dụ cho biết mã nhân viên,họ tên ,ngày sinh của các nhân viên đã đặt hàng các mặt hàng
--hiển thị: mã nhân viên , họ tên, ngày sinh, mahang,tenhang
--trên bảng: nhanvien,mathang
select NHANVIEN.MANHANVIEN, HO+' '+TEN AS HOVATEN, NGAYSINH,MATHANG.MAHANG,TENHANG
from NHANVIEN JOIN DONDATHANG ON NHANVIEN.MANHANVIEN=DONDATHANG.MANHANVIEN
			  JOIN CHITIETDATHANG ON CHITIETDATHANG.SOHOADON=DONDATHANG.SOHOADON
			  JOIN MATHANG ON MATHANG.MAHANG=CHITIETDATHANG.MAHANG

--WHERE
--CÁC PHÉP TOÁN LOGIC: AND, OR
--CÁC PHÉP TOÁN SO SÁNH: >=; <=; <>(KHÁC);
--KHI SO SÁNH VỚI VỚI 1 CHUỖI CÓ DẤU: ĐẶT TRONG ' '
--LƯU Ý KHI SO SÁNH VỚI CHUỖI TIẾNG VIỆT:
--VÍ DỤ: HODEM= N'TRAN THI PHUONG';
--KÝ TỰ ĐẠI DIỆN: % SỬ DỤNG TỪ KHÓA LIKE
--VÍ DỤ:CHO BIẾT CÁC NHÂN VIÊN CÓ HỌ NGUYỄN
--WHERE HODEM LIKE N'NGUYỄN%'

--VÍ DỤ: CHO BIẾT CÁC MẶT HÀNG BÁN RA CÓ SỐ LƯỢNG >50 VÀ GIÁ HÀNG <1000
--HIỂN THỊ :MAHANG, TENHANG, SOLUONG, GIAHANG
--ĐIỀU KIỆN: SOLUONG>50 AND GIAHANG<<10000

SELECT MAHANG,TENHANG,SOLUONG,GIAHANG
FROM MATHANG
WHERE SOLUONG>50 AND GIAHANG<10000

--VÍ DỤ:LOẠI HÀNG THỰC PHẨM DO CÔNG TY NÀO CUNG CẤP VÀ ĐỊA CHỈ CÔNG TY
--HIỂN THỊ: TENLOAIHANG ,MACONGTY, TENCONGY, DIACHI
--BẢNG: LOAIHANG,NHACUNGCAP,MATHANG
--ĐIỀU KIỆN: TÊN LOẠI HÀNG

SELECT TENLOAIHANG,NHACUNGCAP.MACONGTY,DIACHI,TENCONGTY
FROM LOAIHANG JOIN MATHANG ON LOAIHANG.MALOAIHANG=MATHANG.MALOAIHANG
			  JOIN NHACUNGCAP ON NHACUNGCAP.MACONGTY=MATHANG.MACONGTY
WHERE TENLOAIHANG= N'Thực phẩm'

--SẮP XẾP: ORDER BY
--CẤU TRÚC: ORDER BY <TÊN CỘT CẦN SẮP XẾP> ASC HOẶC DESC
--TRONG ĐÓ:
--ASC: TĂNG DẦN
--DESC:GIẢM DẦN
--LƯU Ý: KHI SẮP XẾP TRÊN NHIỀU CỘT, VIẾT 1 LẦN TỪ KHÓA ORDER BY, CÁC CỘT SẮP XẾP CÁCH NHAU BỞI DẤU PHẨY.
--CẤU TRÚC : SELECT
--			FROM
--			WHERE
--			ORDER BY
--VD1:
SELECT MAHANG,TENHANG,SOLUONG,GIAHANG
FROM MATHANG
ORDER BY SOLUONG DESC, GIAHANG ASC

--VD2:
SELECT *
FROM NHANVIEN
ORDER BY HO ASC,TEN ASC

--NHÓM HÀNG THỐNG KÊ:
--SUM,COUNT,AVG,MIN,MAX

--LƯU Ý:
--NHÓM HÀNG THỐNG KẾ NẰM TRONG SELECT
--KHI SỬ DỤNG NHÓM HÀNG THỐNG KÊ: GROUP BY
--  + TRONG GROUP BY , CÁC CỘT CÓ TRONG SELECT THÌ PHẢI CÓ TRONG GROUP BY TRỪ NHÓM HÀM THỐNG KÊ

--CẤU TRÚC: SELECT
--			FROM
--			WHERE
--			ORDER BY
--			GROUP BY

--VD1:
SELECT TENHANG,SUM(SOLUONG) AS TONGSOLUONG
FROM MATHANG
GROUP BY MAHANG,TENHANG

--TỪ KHÓA: HAVING
--ĐIỀU KIỆN TRÊN NHÓM HÀNG THỐNG KÊ
--CẤU TRÚC: SELECT
--			FROM
--			WHERE
--			ORDER BY
--			GROUP BY
--			HAVING


--CẤU  TRÚC LỒNG NHAU:
--CẤU TRÚC 1: IN/ NOT IN: TỪNG / CHƯA TỪNG
--SELECT
--FROM
--WHERE <CỘT SO SÁNH> IN/NOT IN (SELECT 
--							   FROM 
--							   WHERE)
--

--VÍ DỤ:
SELECT *
FROM SINHVIEN
WHERE DTB IN(3.2, 3.6, 4.00)
			( SELECT DTB
			FROM SINHVIEN
			WHERE DTB >= 3.2 AND DTB <=4.00
			)

--VÍ DỤ 1: CHO BIẾT NHỮNG NHÀ CUNG CẤP CHƯA TỪNG ĐĂNG KÝ CUNG CẤP (DÙNG NOT IN)
SELECT MANHACC,TENNHACC
FROM NHACUNGCAP
WHERE MANHACC NOT IN ( SELECT DISTINCT MANHACC
						FROM DANGKYCUNGCAP

						)
--VÍ DỤ 2: CHO BIẾT NHỮNG NHÀ CUNG CẤP ĐÃ TỪNG ĐĂNG KÝ CUNG CẤP (DÙNG  IN)
SELECT MANHACC,TENNHACC
FROM NHACUNGCAP
WHERE MANHACC  IN ( SELECT DISTINCT MANHACC
						FROM DANGKYCUNGCAP

						)
--5.18
SELECT MANHANVIEN,HO,TEN
FROM NHANVIEN 
WHERE MANHANVIEN NOT IN (SELECT MANHANVIEN
						FROM DONDATHANG
						)

--5.19
SELECT *
FROM NHANVIEN
WHERE LUONGCOBAN = (SELECT MAX(LUONGCOBAN) AS LUONGCAONHAT
					FROM NHANVIEN)


/*Cấu trúc lồng nhau : nhiều nhất / ít nhất (nhóm hàng thống kê)
select
from
where
group by
having <hàm thống kê>= all (select	
						from
						where
						group by)*/

--ví dụ cho biết mặt hàng nào có tổng số lượng bán ra nhiều nhất và số lượng bán ra đó là bao nhiêu
--b1: tính tổng số lượng của mỗi mặt hàng bán ra

--cách 1
select MATHANG.MAHANG,TENHANG,sum(CHITIETDATHANG.SOLUONG) as tongsohangbanra
from MATHANG join CHITIETDATHANG on MATHANG.MAHANG=CHITIETDATHANG.MAHANG
group by TENHANG,MATHANG.MAHANG

having sum(CHITIETDATHANG.SOLUONG) =(select top 1 sum(CHITIETDATHANG.SOLUONG) as tongsohangbanra
									from MATHANG join CHITIETDATHANG on MATHANG.MAHANG=CHITIETDATHANG.MAHANG
									group by TENHANG,MATHANG.MAHANG
									order by sum(CHITIETDATHANG.SOLUONG) desc
										)

--cách 2
select MATHANG.MAHANG,TENHANG,sum(CHITIETDATHANG.SOLUONG) as tongsohangbanra
from MATHANG join CHITIETDATHANG on MATHANG.MAHANG=CHITIETDATHANG.MAHANG
group by TENHANG,MATHANG.MAHANG
having sum(CHITIETDATHANG.SOLUONG) >= all (select sum(CHITIETDATHANG.SOLUONG) as tongsohangbanra
										from MATHANG join CHITIETDATHANG on MATHANG.MAHANG=CHITIETDATHANG.MAHANG
										group by TENHANG,MATHANG.MAHANG
										)
--tìm cái lớn nhất thôi
select top 1 sum(CHITIETDATHANG.SOLUONG) as tongsohangbanra
from MATHANG join CHITIETDATHANG on MATHANG.MAHANG=CHITIETDATHANG.MAHANG
group by TENHANG,MATHANG.MAHANG
order by sum(CHITIETDATHANG.SOLUONG) desc



/* cấu trúc update:
	update
	set
	from
	where

	vd:
	update nhatkyphong
	set tienphong=songay*case when loaiphong='A' then 100
							  when loaiphong='B' then 70
							  else 50
						end*/
/* cấu trúc delete:
delete tenbang
from danhsachbang
where dieukien*/

--5. 33 Cập nhật lại giá trị trường NGAYCHUYENHANG của những bản ghi có
--NGAYCHUYENHANG chưa xác định (NULL) trong bảng DONDATHANG
--bằng với giá trị của trường NGAYDATHANG.
update DONDATHANG
set NGAYCHUYENHANG = NGAYDATHANG
where NGAYCHUYENHANG is null
