--câu 1:
select Ho,Ten
from  CongDan
where Ten= 'Hoa' and NoiSinh='Hue'
--câu 2:
select *
from CongDan
where (NgheNghiep='Ky Su' and NoiSinh='Quang Tri') or (NgheNghiep='Sinh Vien' and NoiSinh='Hue')
--câu 3:
select distinct NoiSinh
from CongDan
--câu 4:
select *
from CongDan
where CmndID like '0002%'
--câu 5:
select HokhauID,Tinh_TP,Quan_Huyen,Phuong_Xa,Ho,Ten
from HoKhau join CongDan on HoKhau.ChuHoID=CongDan.CmndID
where Tinh_TP='Da Nang'
--câu 6:
select CmndID,Ho,Ten,HokhauID,Tinh_TP,Quan_Huyen
from HoKhau right join CongDan on HoKhau.ChuHoID=CongDan.CmndID
--câu 7:
select *
from HoKhau
order by ChuHoID desc
--câu 8:
select *
from CongDan
where CmndID in( select CmndID
					from LichSuLuuTru
					where year(ThoiGanBatDauLT)=2016
				)
				and CmndID not in( select CmndID
							from LichSuLuuTru
							where year(ThoiGanBatDauLT)=2014
							)	
--câu 9:
select count(LichSuLuuTru.CmndID) as solandangkylichsuluutrucuacongdan
from CongDan inner join LichSuLuuTru on CongDan.CmndID=LichSuLuuTru.CmndID
where QuanHeVoiChuHo='Khach Tro' and year(ThoiGanBatDauLT)=2016
--câu 10:
select CongDan.CmndID,Ho,Ten,count(LichSuLuuTru.CmndID) as solandangkylichsuluutrucuacongdan
from CongDan inner join LichSuLuuTru on CongDan.CmndID=LichSuLuuTru.CmndID
where  ThoiGanBatDauLT>='2014-01-01' and ThoiGanBatDauLT<='2016-12-31'
group by CongDan.CmndID,Ho,Ten
having count(LichSuLuuTru.CmndID) >= all(select count(LichSuLuuTru.CmndID)
										from CongDan inner join LichSuLuuTru on CongDan.CmndID=LichSuLuuTru.CmndID
										where  ThoiGanBatDauLT>='2014-01-01' and ThoiGanBatDauLT<='2016-12-31'
										group by CongDan.CmndID,Ho,Ten
										)