use supermarket_db; 

select *
	from tr_orderdetails; 
    
-- maximum quantity sold in one transaction 
select OrderID, Quantity 
	from tr_orderdetails
order by Quantity desc;

select Quantity, count(distinct OrderID) frequecy
	from tr_orderdetails as o
    group by Quantity;
-- which products are sold with maximum quantity 

select ProductName, Quantity, ProductCategory, OrderDate
from tr_orderdetails o 
	inner join tr_products p on 
	o.ProductID = p.ProductID
    where o.Quantity >= 3; 
-- checking if there is any corelation b/w product and quantity
-- suppose which product are sold most frequencty during march 2015 to june 2015

select ProductCategory, count(OrderID)
	from tr_orderdetails o
INNER JOIN tr_products p
 ON o.ProductID = p.ProductID
 GROUP BY p.ProductCategory; 
 -- ## we conclude that most of the orders are regarding Furnitures then Maintainance and so on 
 
 -- product category that has maximum products 
 select ProductCategory, count(distinct ProductName) as Count
	from tr_products  p 
group by ProductCategory
order by 2 desc;

-- Furnishing has the maximum range of products 
-- Top 5 property ID that did maximum sales in quantity 

select o.ProductID, ProductName, sum(Quantity) as total_Sell
	from tr_orderdetails o
inner join tr_products p on 
o.ProductID = p.ProductID
group by o.ProductID
order by total_sell desc
limit 5
;

select  PropertyID, sum(Quantity) as total_Sell
	from tr_orderdetails 
group by PropertyID
order by total_sell desc
limit 5
;
## Find the top 5 products that did the Maximum sales
select 
p.ProductName, sum(o.Quantity) as total_quantity
from tr_orderdetails as o 
left join tr_products as p 
on o.ProductID = p.ProductID
group by p.ProductID
order by total_quantity desc
limit 5;

## Now we find the top 5 product names with maximum sales
## sales = price * quantity 
select 
p.ProductName, (sum(o.Quantity) * p.price) as total_sales, sum(Quantity) as total_quantity, p.Price
from tr_orderdetails as o 
left join tr_products as p 
on o.ProductID = p.ProductID
group by   p.ProductName
order by total_sales desc;

##Top 5 cities with the maximum sales
select 
pi.PropertyCity, sum(o.Quantity * p.price) as total_sales
from tr_orderdetails as o 
left join tr_products as p 
on o.ProductID = p.ProductID
left join tr_propertyinfo as pi on o.PropertyID = pi.`Prop ID`
group by   pi.PropertyCity
order by total_sales desc
limit 5;

# we see that kansas has the highest sales 
## Find the top 5 products in each of the cities 
# we now find top 5 products sold in kansas city 

select 
pi.PropertyCity
p,ProductName, sum(o.Quantity * p.price) as total_sales
from tr_orderdetails as o 
left join tr_products as p 
on o.ProductID = p.ProductID
left join tr_propertyinfo as pi on o.PropertyID = pi.`Prop ID`
where pi.PropertyCity = 'Portland'
group by   pi.PropertyCity, p.ProductName
order by total_sales desc
limit 5;






 

 


 