-- DATA EXPLORATION
-- COUNT OF ROWS
select count(*) from zepto;

-- SAMPLE DATA
select * from zepto limit 10;

-- NULL VALUES
select * from zepto where Category is null or
name is null or
mrp is null or
discountPercent is null or
availableQuantity is null or
discountedSellingPrice is null or
weightInGms is null or
outOfStock is null or
quantity is null;

-- DIFFERENT PRODUCT CATEGORY
select distinct Category from zepto order by Category;

-- PRODUCTS IN STOCK VS OUT OF STOCK
select outOfStock,count(pro_id) from zepto group by outOfStock;

-- PRODUCT NAMES PRESENT MULTIPLE TIMES
select name,count(pro_id) as 'number of products'from zepto
group by name having count(pro_id)
order by count(pro_id) desc;

-- DATA CLEANING
-- PRODUCT WITH PRICE = 0
select * from zepto where mrp=0 and discountedSellingPrice =0;
SET sql_safe_updates=0;
delete from zepto where mrp=0 and discountedSellingPrice =0;

-- CONVERT PAISE INTO RUPEES
update zepto set mrp=mrp/100.0, discountedSellingPrice=discountedSellingPrice/100.0;
select mrp,discountedSellingPrice from zepto;

-- FIND THE TOP 10 BEST VALUES PRODUCTS BASED ON THE DISCOUNT PERCENTAGE
select name,discountPercent from zepto order by discountPercent limit 10;

-- WHAT ARE THE PRODUCTS WITH HIGH MRP BUT OUT OF STOCK
select name,mrp from zepto where outOfStock ='TRUE' and mrp>300 order by mrp desc;

-- CALCULATE ESTIMATED REVENUE FOR EACH CATEGORY
select Category,sum(discountedSellingPrice*availableQuantity)as tot_rev from zepto group by Category order by tot_rev;

-- FIND ALL PRODUCTS WHERE MRP IS GREATER THAN 500 AND DISCOUNT IS LESS THAN 10%
select name ,mrp,discountPercent from zepto where mrp>500 and discountPercent<10 order by mrp desc;

-- IDENTIFY THE TOP 5 CATEGORY OFFERING THE HIGHEST AVERAGE DISCOUNT PERCENTAGE
select Category,avg(discountPercent) as avg_dis_per from zepto group by Category order by avg_dis_per desc limit 5;

-- FIND THE PRICE PER GRAM FOR PRODUCTS ABOVE 100G AND SORT BY BEST VALUE
select distinct name,weightInGms,discountedSellingPrice,discountedSellingPrice/weightInGms as price_per_gm from zepto where weightIngms>100
order by price_per_gm;

-- GROUP THE PRODUCTS INTO CATEGORIES LIKE LOW, MEDIUM, BULK
select distinct name ,weightInGms,
case when weightInGms<1000 then 'low'
when weightInGms<5000 then 'medium'
else 'bulk'
end as weight_category from zepto;

-- WHAT IS THE TOTAL INVENTORY WEIGHT PER CATEGORY
select category,sum(weightInGms*availableQuantity)as total_weight from zepto
group by Category order by total_weight;