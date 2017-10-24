--1". Создать пользователя Ivan с пароелм 1qaZ2wsX
--Execute sp_addlogin 'Ivan', 'ivan' -- создаем пользователя БД
	
--2". Дать пользователю Иван права суперадмина
--Execute sp_addsrvrolemember 'Ivan', 'sysadmin' -- надание пользователю прав

--3***. Разработать Базу Данных домашнего отчета о покупках.
--Учесть:
--Добавление в базу данных информации о покупках которые были сделаны (наименование, количество (граммы, литры, штуки, пачки и т.д.), стоимость за купленый товар)
--разделение товаров на пром.товары, продукты питания, услуги.
--дать возможность пользователю самостоятельно добавлять теги покупкам (например: "распродажа", "на петровке")

	--CREATE TABLE Category(
	--id int IDENTITY PRIMARY KEY,
	--c_name varchar(50)
	--)
	
	--CREATE TABLE Orders(
	--id int IDENTITY PRIMARY KEY,
	--goods_name varchar(50),
	--qty float,
	--volumesId int, -- об'єм
	--categoryId int,
	--tegsId int,
	--dataOrder DateTime,
	--summa money
	--)
	
	--CREATE TABLE Tegs(
	--id int IDENTITY PRIMARY KEY,
	--t_name varchar(50)
	--)
	--CREATE TABLE Volums(
	--id int IDENTITY PRIMARY KEY,
	--vol_name varchar(10)
	--)
	
	--CREATE TABLE logHistDateOrder(
	--id int IDENTITY PRIMARY KEY,
	--orderId int,
	--dateOrd DateTime,
	--summa money
	--)
	
	--INSERT INTO Category(c_name) VALUES('IndustGoods')
	--INSERT INTO Category(c_name) VALUES('FoodGoods')
	--INSERT INTO Category(c_name) VALUES('Service')
	
	--INSERT INTO Volums(vol_name) VALUES('liters')
	--INSERT INTO Volums(vol_name) VALUES('pieces')
	--INSERT INTO Volums(vol_name) VALUES('kg')

	
	--INSERT INTO Tegs(t_name) VALUES ('sale')
	--INSERT INTO Tegs(t_name) VALUES ('on Petrovka')
	--INSERT INTO Tegs(t_name) VALUES ('on Poznayki')
	
	--INSERT INTO Orders(goods_name, qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Milk', 1, 2, 2, NULL, '2017-10-22', 20.1) 
	--INSERT INTO Orders(goods_name, qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Bгееd', 2, 2, 2, 2, '2017-10-22', 63.0) 
	--INSERT INTO Orders(goods_name, qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Bгееd', 2, 2, 2, 2, '2017-23-10', 65.0)
	--INSERT INTO Orders(goods_name,  qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Shirt', 1, 2, 1, 1, '2017-10-20', 250.0) 
	--INSERT INTO Orders(goods_name,  qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('boots', 1, 2, 1, 1, '2017-10-23', 350.0) 
	--INSERT INTO Orders(goods_name,  qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Aple', 2, 3, 2, 3, '2017-10-23', 26.0)
	--INSERT INTO Orders(goods_name, qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Milk', 1, 2, 2, NULL, '2017-10-24', 22.15)
	--INSERT INTO Orders(goods_name,  qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Сookies', 2, 3, 2, 1, '2017-09-23', 30.50) 
	--INSERT INTO Orders(goods_name,  qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Creem', 2, 2, 2, 3, '2017-09-15', 41.0)
	--INSERT INTO Orders(goods_name, qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Apple2', 1, 3, 2, 3, '2017-08-08', 15.15)
	--INSERT INTO Orders(goods_name, qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Apple3', 1, 3, 2, 3, '2017-12-08', 17.10)

	--INSERT INTO Orders(goods_name,  qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Boots', 1, 2, 1, 1, '2017-10-17', 750.0) 
	--INSERT INTO Orders(goods_name,  qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Bater', 2, 2, 2, 3, '2017-10-18', 60.0)
	--INSERT INTO Orders(goods_name, qty, volumesId, categoryId, tegsId, dataOrder, summa ) VALUES ('Water', 6, 1, 2, NULL, '2017-10-18', 180.00)

	
--4. Запросы:
--4.1") Выбрать все операции, которые были помечены тегами "'sale'"
	--SELECT *
	--FROM Orders
	--JOIN Tegs
	--ON Tegs.id = Orders.tegsId 
	--WHERE Tegs.t_name = 'sale'
--4.2") Выбрать все услуги, за которые было заплачено в этом году(с 1 января текущего года до сейчас) 
	 --SELECT c_name, goods_name, summa
	 --FROM Orders, Category
	 --WHERE Category.id = Orders.categoryId AND
		--   Year(dataOrder) = Year(CURRENT_TIMESTAMP)
--4.3") Выбрать все товары, с ценой больше 10 денежных едениц за 1 килограмм
	--SELECT goods_name, qty, summa, dataOrder
	--FROM Orders, Volums
	--WHERE Volums.id = Orders.volumesId AND
	--	  ( summa/qty ) > 10  AND vol_name = 'kg'
--4.4*) Выбрать все промтовары, которых за последний месяц было куплено больше 10 едениц
	 --SELECT c_name, goods_name, summa
	 --FROM Orders, Category
	 --WHERE Category.id = Orders.categoryId  AND
		--   c_name = 'IndustGoods' AND
		--   qty > 10
--4.5**) Выбрать все товары из категории продукты питания, цена которых изменялась в пределах 10% 
--       (разница между минимальныой и максимальной ценой)

--------------------------------------------------------------------------------
--SELECT tmp.*
--FROM ( SELECT  goods_name AS g_name, (MAX(summa /qty ) / MIN(summa /qty ) - 1) * 100 AS priceDiffPercent
--	   FROM Orders
--	   JOIN Category
--	   ON Category.id = Orders.categoryId 
--	   WHERE c_name = 'FoodGoods' 
--	   GROUP BY Orders.goods_name) as tmp
--WHERE priceDiffPercent < 10 


------SELECT tmp.g_name, MAX(tmp.price) as  maxPrice
------FROM (	SELECT  goods_name AS g_name, (summa /qty ) AS price--, MIN(summa /qty) AS priceMin 
------			FROM Orders, Category
------			WHERE Category.id = Orders.categoryId  AND
------			  c_name = 'FoodGoods' ) AS  tmp
------GROUP BY g_name

--5. Процедуры:
--5.1") Процедура принимает товар и дату. Выводит на экран отчет о всех операциях с этим товаром с введенной даты

	--CREATE PROC procOrdersDate
	--	@nameGoods varchar(50),
	--	@date DateTime
	--AS
	--	SELECT *
	--	FROM Orders
	--	WHERE goods_name = @nameGoods AND
	--		  dataOrder = @date
	--EXEC procOrdersDate 'Milk','2017-22-10'

--5.2") Процедура принимает тег покупки, дату начала поисков и дату конца поисков. Найти все покупки с указаным тегом в диапазоне указаных дат.
	--ALTER PROC procOrdersTag
	--	@teg varchar(50),
	--	@dateBegin DateTime,
	--	@dateUntil DateTime
	--AS
	--	SELECT *
	--	FROM Orders, Tegs
	--	WHERE  Tegs.id = Orders.tegsId AND
	--		   t_name = @teg AND
	--		   dataOrder > @dateBegin AND dataOrder < @dateUntil

	--EXEC procOrdersTag 'sale', '2017-19-10', '2017-24-10'

--5.3**) Процедура принимает группу товаров, выводит на екран отчет в виде столбцов: год и месяц, количество денег потраченное в этом месяце
--CREATE PROC procCategGoods
--	@category varchar(50)
--AS
--	DECLARE @catId int = (SELECT id FROM Category WHERE c_name = @category)	
--	--DECLARE @sel1 TABLE(Year int, Month int, Summa int)
--	--INSERT INTO @sel1
	
--	SELECT Year, Month, SUM(Summa) AS 'Amount Cost'
--	FROM ( SELECT YEAR(dataOrder) AS 'Year', MONTH(dataOrder) AS 'Month' , summa as 'Summa'--, SUM(summa) as amountCost
--		   FROM Orders
--		   WHERE categoryId = @catId) AS tmp 
--	GROUP BY Year, Month	
 
--EXEC procCategGoods 'FoodGoods'
	
--6. Тригеры:
--6.1*) Сделать тригер, который автоматически после каждой покупки дописывает в отдельную таблицу количество потраченных денег 
-- (подсчёт суммы денег которая потрачена на покупки)

	--CREATE TRIGGER insertGodds_tg 
	--ON Orders
 --   FOR INSERT
 --   AS
	--	INSERT INTO logHistDateOrder(dateOrd, orderId, summa) 
	--	SELECT  inserted.dataOrder, inserted.id, inserted.summa
	--	FROM inserted
		
--7. Отложеная задача
--7.1**) Сделать отложеный скрипт (обязательно сделать скриптом!!!)
-- В 10 утра каждого понедельника выполнять процедуру подсчета количества денег, которые были потрачены за прошлую неделю (с понедельника по воскресение) 
-- и записывать эту информацию в отдельную таблицу отчетов. В отчете также указать номер недели в году.
	
	--CREATE TABLE CostReportWeek(
	--id int IDENTITY PRIMARY KEY,
	--weekId int,
	--amountExpens MONEY
	--)
	--DROP TABLE CostReportWeek
	

	--USE msdb ;
	--EXEC dbo.sp_add_job
	--	@job_name = N'Week Sales Data costs' ;
	--GO
	--EXEC sp_add_jobstep
	--	@job_name = N'Week Sales Data costs',
	--	@step_name = N'Save data base cost a week',
	--	@subsystem = N'TSQL',
	--	@command = N'	DECLARE @weekId int =  DATEPART(ww, CURRENT_TIMESTAMP) - 1
	--					DECLARE @startDate datetime = CURRENT_TIMESTAMP - 7
	--					DECLARE @endDate datetime = CURRENT_TIMESTAMP - 1

	--					DECLARE @amountExpens MONEY = (SELECT SUM(summa) 
	--												  FROM Orders 
	--												  WHERE dataOrder >= @startDate AND dataOrder <= @endDate)
	                            
	--					INSERT INTO CostReportWeek( weekId, amountExpens) VALUES (@weekId, @amountExpens)
	--				  GO', 
	--	@retry_attempts = 5,
	--	@retry_interval = 1 ;
	--GO
	--EXEC dbo.sp_add_schedule
	--	@schedule_name = N'SaveCost bd',
	--	@freq_type = 8,
	--	@active_start_time = 100000 ;
	--USE msdb ;
	--GO
	--  ======== привязка
	--EXEC sp_attach_schedule
	--   @job_name = N'Week Sales Data costs',
	--   @schedule_name = N'SaveCost bd';
	--GO
	-- ------  Додавання на сервер
	--EXEC dbo.sp_add_jobserver
	--	@job_name = N'Week Sales Data costs';
	--GO


--" - 0.5 бала
--* - 1 бал