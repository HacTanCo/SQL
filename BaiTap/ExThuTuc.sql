--a. Viết thủ tục dùng để hiển thị các thông tin gồm oID, oDate, oPrice của tất cả các hóa đơn
--trong bảng Order, danh sách phải sắp xếp theo thứ tự ngày tháng, hóa đơn mới hơn nằm
--trên như hình sau:
create proc sp_Order_SelectALL
as
	begin
		select *
		from "Order"
		order by oDate desc
	end
sp_Order_SelectALL
--b. Viết thủ tục dùng để hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản
--phẩm được mua bởi các khách đó như sau:
create proc sp_Customer_ThongKe_NguoiMuaHang
as
	begin
		select "Order".cID,cName,pName
		from Customer join "Order" on Customer.cID="Order".cID
					  join OrderDetail on "Order".oID=OrderDetail.oID
					  join Product on OrderDetail.pID=Product.pID
	end
sp_Customer_ThongKe_NguoiMuaHang
--c. Viết thủ tục dùng để hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
--như sau:
create proc sp_Customer_ThongKe_NguoiKhongMuaHang
as
	begin
		select cID,cName
		from Customer
		where cID not in(
							select cID 
							from "Order"
						  )
		--c2
		/*select Customer.cID,cName
		from Customer left join "Order" on Customer.cID="Order".cID
		where "Order".cID is NULL*/
	end
sp_Customer_ThongKe_NguoiKhongMuaHang
--d. Viết thủ tục dùng để hiển thị các mặt hàng chưa được mua lần nào
create proc sp_Product_ThongKe_HangChuaTungBan
as
	begin
		select Product.pID,pName
		from Product left join OrderDetail on Product.pID=OrderDetail.pID
		where OrderDetail.pID is null

		--c2
		/*select pID,pName
		from Product
		where pID not in (
							select pID
							from OrderDetail
							)*/
	end
sp_Product_ThongKe_HangChuaTungBan
--e. Viết thủ tục với tham số truyền vào là tháng, năm. Thủ tục dùng để hiển thị các hóa đơn
--được lập và số tiền bán được trong tháng, năm truyền vào.
create proc sp_Order_ThongKe_TienBanDuoc_MonthAndYear
	@month int,@year int
as
	begin
		select "Order".oID,sum(odQTY*pPrice) as SoTienBanDuoc
		from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
					  join Product on OrderDetail.pID=Product.pID
		where month(odate) = @month and year(odate) = @year
		group by "Order".oID

		/*select sum(odQTY*pPrice) as SoTienBanDuoc
		from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
					  join Product on OrderDetail.pID=Product.pID*/
	end
	
sp_Order_ThongKe_TienBanDuoc_MonthAndYear 3,2006
--f. Viết thủ tục với tham số truyền vào là năm. Thủ tục dùng để hiển thị doanh thu của mỗi
--tháng trong năm truyền vào
create proc sp_Order_ThongKe_DoanhThu_MonthInYear
	@year int
as
	begin
		select MONTH(oDate) as month,sum(odQTY*pPrice) as DoanhThu
		from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
					  join Product on OrderDetail.pID=Product.pID
		where YEAR(odate) = @year
		group by MONTH(oDate)
	end
sp_Order_ThongKe_DoanhThu_MonthInYear 2006
--g. Viết thủ tục dùng để thêm mới một sản phẩm. Thủ tục có các tham số là các thông tin của
--sản phẩm và một tham số @ketqua sẽ trả về chuỗi rỗng nếu thêm mới sản phẩm thành
--công, ngược lại tham số này trả về chuỗi cho biết lý do không thêm mới được.
create proc sp_Product_AddProduct
	@pid int,@pname varchar(50),@pprice int,@kq nvarchar(255) output
as
	/*begin try
		insert into Product(pID,pName,pPrice)
		values (@pid,@pname,@pprice)
		set @kq = ''
	end try
	begin catch
		SET @kq = 'Error when you add procduct: ' + ERROR_MESSAGE()
	end catch*/
	if (exists(select * from Product where pID = @pid) )
		set @kq = N'Mã Product đã tồn tại'
	else
	begin
			insert into Product
			values (@pid, @pname, @pprice)
			if(@@ERROR<>0)
				set @kq = N'Lỗi không thể cập nhật'
			else 
				set	@kq = N''
		end
declare @kq nvarchar(255)
execute sp_Product_AddProduct 6,DontCry,99999999,@kq output
select @kq as 'Kết quả'

select * from Product
delete from Product
where pID = 6
--h. Viết thủ tục dùng để cập nhật một sản phẩm. Thủ tục có các tham số là các thông tin của
--sản phẩm và một tham số @ketqua sẽ trả về chuỗi rỗng nếu Cập nhật sản phẩm thành
--công, ngược lại tham số này trả về chuỗi cho biết lý do không cập nhật được.
create proc sp_Product_UpdateProduct
    @pid int,@pname varchar(50), @pprice int, @kq nvarchar(255) OUTPUT
as
	if(not exists (select * from Product where pID = @pid))
		set @kq = 'Mã Product không tồn tại'
	else
	begin
		update Product
		set pName=@pname,pPrice=@pprice
		where pID = @pid
		if @@ERROR <> 0 
			set @kq = 'Lỗi cập nhật dữ liệu'
		else
			set @kq = ''
	end
declare @kq nvarchar(255)
execute sp_Product_UpdateProduct 5,'Bep Dien',2,@kq output
select @kq as 'Kết Quả'
--i. Viết thủ tục dùng để xóa một sản phẩm. Thủ tục có các tham số là mã của sản phẩm và
--một tham số @ketqua sẽ trả về chuỗi rỗng nếu xóa sản phẩm thành công, ngược lại tham
--số này trả về chuỗi cho biết lý do không xóa sản phẩm được.
alter proc sp_Product_DeleteProduct
	@pid int,@kq nvarchar(255) output
as
	if(not exists (select * from Product where pID = @pid))
		set @kq = 'Mã Product không tồn tại'
	else
	begin
		delete from Product
		where pID = @pid
		if @@ERROR <> 0
			set @kq = 'Lỗi cập nhật dữ liệu' 
		else
			set @kq = ''
	end
declare @kq nvarchar(255) 
execute sp_Product_DeleteProduct 6,@kq output
select @kq as 'Kết quả'

--j. Viết thủ tục dùng để hiển thị các khách hàng đã đến mua bao nhiêu lần.


create proc sp_Customer_ThongKe_SoLanMuaOfCustomer
as
	begin
		select Customer.cID,cName,count("Order".cID) as N'Số lần mua'
		from Customer left join "Order" on Customer.cID="Order".cID
		group by  Customer.cID,cName
	end
sp_Customer_ThongKe_SoLanMuaOfCustomer
--k. Viết thủ tục dùng để hiển thị chi tiết của từng hóa đơn như sau :
create proc sp_Order_ThongKe_HoaDon
as
	begin
		select "Order".oID,oDate,odQTY,pName,pPrice
		from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
					 join Product on OrderDetail.pID=Product.pID
	end
sp_Order_ThongKe_HoaDon
--l. Viết thủ tục dùng để hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một
--hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá
--bán của từng loại được tính = odQTY*pPrice) như sau:
create proc sp_Order_ThongKe_GiaBan
as
	begin
		select "Order".oID,oDate,sum(odQTY*pPrice) as Total
		from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
					 join Product on OrderDetail.pID=Product.pID
		group by "Order".oID,oDate
	end
sp_Order_ThongKe_GiaBan
--m. Viết thủ tục dùng để hiển thị tên và giá của các sản phẩm có giá cao nhất như sau:
create proc sp_Product_Select_MaxPrice
as
	begin 
		select pID,pName,pPrice
		from Product
		where pPrice = (select max(pPrice) from Product)
	end
sp_Product_Select_MaxPrice
--n. Viết thủ tục với tham số truyền vào là số tiền. Thủ tục dùng để hiển thị những hóa đơn có
--tổng thành tiền trên số tiền truyền vào.
alter proc sp_Order_ThongKe_TienLonHonMoney
	@money int
as
	begin
		select "Order".oID,sum(odQTY*pPrice) as Total
		from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
					 join Product on OrderDetail.pID=Product.pID
		group by "Order".oID
		having sum(odQTY*pPrice) > @money
	end
sp_Order_ThongKe_TienLonHonMoney 33
--o. Viết thủ tục dùng để hiển thị những hóa đơn có tổng thành tiền là cao nhất.
create proc sp_Order_ThongKe_ThanhTienCaoNhat
as
	begin
		select "Order".oID,sum(odQTY*pPrice) as Total
		from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
					 join Product on OrderDetail.pID=Product.pID
		group by "Order".oID
		having sum(odQTY*pPrice) >= all (
											select sum(odQTY*pPrice) as Total
											from "Order" join OrderDetail on "Order".oID=OrderDetail.oID
														 join Product on OrderDetail.pID=Product.pID
											group by "Order".oID
										)
	end
sp_Order_ThongKe_ThanhTienCaoNhat
--p. Viết thủ tục dùng để hiển thị ra các khách hàng tới mua hàng với số lần họ đã tới mua
--hàng. Nếu khách hàng nào chưa mua hàng lần nào thì số lần họ tới mua là 0.
create proc sp_Customer_ThongKe_SolanMuaHangofCustomer
as
	begin
		select Customer.cID,cName,cAge,count("order".cID) as N'Số lần mua hàng'
		from Customer left join "Order" on Customer.cID="Order".cID
		group by Customer.cID,cName,cAge
	end
sp_Customer_ThongKe_SolanMuaHangofCustomer
--q. Viết thủ tục với tham số truyền vào là @nam. Thủ tục dùng để thống kê mỗi tháng trong
--năm truyền vào có tổng doanh thu là bao nhiêu. (Nếu tháng nào không hoạt động thì ghi
--tổng doanh thu là 0).
create proc sp_Order_ThongKe_DoanhThuMoiThangTrongNam
	@year int
as
	begin
		declare @Thang table(
			Thang int
		)
		declare @a int
		set @a = 1
		while (@a < 13)
			begin
				insert into @Thang
				values (@a)
				set @a += 1
			end
		select a1.Thang,isnull(a2.Total,0) as Total
		from @Thang as a1 left join (	
										select month(oDate) as Month, sum(odQTY*pPrice) as Total
										from "Order" left join OrderDetail on OrderDetail.oID = "Order".oID
													left join Product on Product.pID = OrderDetail.pID
										where year(oDate) = @year
										group by month(oDate)
									)   as a2 on a1.Thang=a2.Month
	end
sp_Order_ThongKe_DoanhThuMoiThangTrongNam 2006	

select * from "Order"
select * from OrderDetail
select * from Product
select * from Customer