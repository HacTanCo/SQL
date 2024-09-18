--a. ??a ra danh s�ch c�c ??u s�ch c� trong th? vi?n. M?i ??u s�ch c� nh?ng th�ng tin (T�ns�ch, T�c gi?, Nh� xu?t b?n). Danh s�ch ???c s?p x?p theo t�n s�ch.
select tensach,tentg,tennhaxb
from Sach left join SangTac on Sach.masach=SangTac.masach
		  left join TacGia on  SangTac.matg=TacGia.matg
		  join NhaXuatBan on Sach.manhaxb=NhaXuatBan.manhaxb
order by tensach 
--b. L?y ra t?t c? c�c quy?n s�ch c� t�n c� ch?a t? l� �Th? gi?i�.
select tensach from Sach
where tensach like N'%Th? gi?i%'
--c. Hi?n th? c�c quy?n s�ch ???c xu?t b?n t?i H� N?i.
select tensach
from Sach join NhaXuatBan on Sach.manhaxb = NhaXuatBan.manhaxb
where diachi like N'H� N?i'
--d. L?y ra danh s�ch c�c ??c gi? c� m??n s�ch m� ch?a tr?.
select DocGia.sothe,hoten,diachi,dienthoai
from DocGia join Muon on DocGia.sothe = Muon.sothe
where ngaytra is null
--e. L?y ra c�c ??c gi? t?i m??n s�ch trong th�ng 4/2008.
select DocGia.sothe,hoten,diachi,ngaymuon
from DocGia join Muon on DocGia.sothe = Muon.sothe
where DAY(ngaymuon)=4 and YEAR(ngaymuon)=2008
--f. L?y ra c�c quy?n s�ch c?a t�c gi? TG001.
select tensach
from Sach left join SangTac on Sach.masach=SangTac.masach
		  left join TacGia on  SangTac.matg=TacGia.matg
where TacGia.matg = 'TG001'
--g. L?y ra c�c t�c gi? c� tu?i d??i 35 v� gi?i t�nh l� n?.
select tentg,gioitinh
from TacGia
where YEAR(GETDATE()) - YEAR(namsinh) < 35  and gioitinh = 0
--h. Hi?n th? c�c ??c gi? t?i m??n s�ch v?i c�c th�ng tin: m� ??c gi?, t�n ??c gi?, ??a ch?,
--s? ?i?n tho?i, m� s�ch, t�n s�ch, Nh� xu?t b?n, t�c gi?. Danh s�ch ???c s?p x?p theo t�n
--??c gi?.
select DocGia.sothe,hoten,DocGia.diachi,DocGia.dienthoai,Sach.masach,tensach,tennhaxb,tentg
from DocGia join Muon on DocGia.sothe=Muon.sothe
			join Sach on Muon.masach=Sach.masach
			join NhaXuatBan on Sach.manhaxb=NhaXuatBan.manhaxb
			join SangTac on Sach.masach=SangTac.masach
			join TacGia on SangTac.matg=TacGia.matg
order by hoten
--i. Hi?n th? c�c t�c gi? c� h? l� Nguy?n.
select tentg
from TacGia
where tentg like N'%Nguy?n%'
--j. Hi?n th? 2 t�c gi? ??u ti�n. Danh s�ch g?m c� m� t�c gi?, t�n t�c gi?, ng�y sinh. Danh
--s�ch ???c s?p x?p t?ng d?n theo t�n v� gi?m d?n theo ng�y sinh.

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

