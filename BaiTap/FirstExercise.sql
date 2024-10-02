--BT1: Gi?i pt ax2 + bx + c = 0
declare @a int ,@b int,@c int , @d int
set @a = 1
set @b = -4
set @c = 4
set @d = POWER(@b,2)-(4*@a*@c)
print @d
if(@d<0) print'ptvn'
else if(@d = 0) print'x1 = x2 = '+ convert(varchar,-(@b)/(2*@a))
else print'x1 = '+ convert(varchar,(-(@b)+sqrt(@d))/(2*@a))+', x2 = '+ convert(varchar,(-(@b)-sqrt(@d))/(2*@a))
--BT2: Tính t?ng các s? ch?n, các s? l? nh? h?n n.
declare @n int ,@sumc int,@suml int
set @n = 5
set @sumc = 0
set @suml = 0
while (@n > 0)
	begin
		if(@n%2=0) set @sumc = @sumc + @n
		else set @suml = @suml + @n
		set @n = @n - 1
	end
print N'Sum ch?n = '+ convert(varchar, @sumc)
print N'Sum l? = '+ convert(varchar, @suml)
--BT3: Tính S = sqrt(x + Sqrt(x+....+sqrt(x))) (n d?u c?n, n,x >0)
declare @n int ,@x int,@s float
set @n = 10
set @x = 10
set @s = 0
while(@n > 0)
	begin
		set @s = SQRT(@x + @s)
		set @n = @n - 1
	end
print N'T?ng = ' + convert(varchar,@s)
