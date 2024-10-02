--a. ??a ra danh sách các ??u sách có trong th? vi?n. M?i ??u sách có nh?ng thông tin (Tênsách, Tác gi?, Nhà xu?t b?n). Danh sách ???c s?p x?p theo tên sách.
select tensach,tentg,tennhaxb
from Sach left join SangTac on Sach.masach=SangTac.masach
		  left join TacGia on  SangTac.matg=TacGia.matg
		  join NhaXuatBan on Sach.manhaxb=NhaXuatBan.manhaxb
order by tensach 
--b. L?y ra t?t c? các quy?n sách có tên có ch?a t? là ‘Th? gi?i’.
select tensach from Sach
where tensach like N'%Th? gi?i%'
--c. Hi?n th? các quy?n sách ???c xu?t b?n t?i Hà N?i.
select tensach
from Sach join NhaXuatBan on Sach.manhaxb = NhaXuatBan.manhaxb
where diachi like N'Hà N?i'
--d. L?y ra danh sách các ??c gi? có m??n sách mà ch?a tr?.
select DocGia.sothe,hoten,diachi,dienthoai
from DocGia join Muon on DocGia.sothe = Muon.sothe
where ngaytra is null
--e. L?y ra các ??c gi? t?i m??n sách trong tháng 4/2008.
select DocGia.sothe,hoten,diachi,ngaymuon
from DocGia join Muon on DocGia.sothe = Muon.sothe
where DAY(ngaymuon)=4 and YEAR(ngaymuon)=2008
--f. L?y ra các quy?n sách c?a tác gi? TG001.
select tensach
from Sach left join SangTac on Sach.masach=SangTac.masach
		  left join TacGia on  SangTac.matg=TacGia.matg
where TacGia.matg = 'TG001'
--g. L?y ra các tác gi? có tu?i d??i 35 và gi?i tính là n?.
select tentg,gioitinh
from TacGia
where YEAR(GETDATE()) - YEAR(namsinh) < 35  and gioitinh = 0
--h. Hi?n th? các ??c gi? t?i m??n sách v?i các thông tin: mã ??c gi?, tên ??c gi?, ??a ch?,
--s? ?i?n tho?i, mã sách, tên sách, Nhà xu?t b?n, tác gi?. Danh sách ???c s?p x?p theo tên
--??c gi?.
select DocGia.sothe,hoten,DocGia.diachi,DocGia.dienthoai,Sach.masach,tensach,tennhaxb,tentg
from DocGia join Muon on DocGia.sothe=Muon.sothe
			join Sach on Muon.masach=Sach.masach
			join NhaXuatBan on Sach.manhaxb=NhaXuatBan.manhaxb
			join SangTac on Sach.masach=SangTac.masach
			join TacGia on SangTac.matg=TacGia.matg
order by hoten
--i. Hi?n th? các tác gi? có h? là Nguy?n.
select tentg
from TacGia
where tentg like N'%Nguy?n%'
--j. Hi?n th? 2 tác gi? ??u tiên. Danh sách g?m có mã tác gi?, tên tác gi?, ngày sinh. Danh
--sách ???c s?p x?p t?ng d?n theo tên và gi?m d?n theo ngày sinh.

/*select  matg,tentg,namsinh
from TacGia
where matg = 'TG001'
union 
select  matg,tentg,namsinh
from TacGia
where matg = 'TG002'

order by tentg asc,namsinh desc*/

select top 2  matg,tentg,namsinh
from TacGia
union

