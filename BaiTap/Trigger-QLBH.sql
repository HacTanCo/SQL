create trigger trigger_Delete_CTHD_Update_Hang
on tbl_CTHD
for delete
as
	begin
		update tbl_Hang
		set tbl_Hang.SL = tbl_Hang.SL + deleted.SL
		from tbl_Hang join deleted on tbl_Hang.MaHang=deleted.MaHang
	end

delete from tbl_CTHD
where MaHD = 1 and MaHang = 3

alter trigger trigger_Update_CTHD_Update_Hang
on tbl_CTHD
for update
as
	begin
		if(UPDATE(SL))
		begin
			update tbl_Hang
			set tbl_Hang.SL = tbl_Hang.SL + deleted.SL - inserted.SL
			from tbl_Hang join inserted on tbl_Hang.MaHang=inserted.MaHang
						  join deleted on tbl_Hang.MaHang=deleted.MaHang
		end
	end
update tbl_CTHD
set SL = 4
where MaHD = 2 and MaHang =2 

update tbl_CTHD
set SL = 2
where MaHD = 2 and MaHang =2 

select * from tbl_CTHD
select * from tbl_Hang