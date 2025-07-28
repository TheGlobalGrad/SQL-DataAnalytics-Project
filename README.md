# 🍕 Pizza Sales Data Analysis using SQL

This project involves performing **exploratory data analysis** on a fictional pizza chain's database using SQL. The dataset captures detailed information about pizza orders, types, pricing, and customer preferences. The goal was to derive meaningful business insights and improve decision-making based on data-driven findings.

## 📁 Project Structure

* **Database Name**: `pizzahut`
* **Main Tables**:

  * `orders`: Records order ID, date, and time.
  * `orders_details`: Tracks pizza quantities and links to specific orders.
  * `pizzas`: Contains pizza size, price, and type.
  * `pizza_types`: Contains name and category of pizzas.

## 🔍 Key SQL Queries & Insights

1. **Total Number of Orders**
   Counted all orders placed to gauge overall demand.

2. **Total Revenue Calculation**
   Summed up quantity × price to compute total sales.

3. **Highest Priced Pizza**
   Identified the most expensive pizza in the menu.
   
4. **Most Common Pizza Size**
   Analyzed the size with the highest number of orders.

5. **Top 5 Most Ordered Pizza Types**
   Based on quantity sold.

6. **Total Quantity by Category**
   Measured which pizza categories (e.g., Classic, Veggie, etc.) sell the most.

7. **Hourly Order Distribution**
   Found peak hours by analyzing order times.

8. **Category-wise Pizza Count**
   Counted how many pizzas exist per category.

9. **Average Pizzas Ordered Per Day**
   Used nested queries to calculate daily averages.

10. **Top 3 Revenue-Generating Pizzas**
    Found pizzas generating the highest revenue.

11. **Category Revenue Contribution (%)**
    Calculated each category's share in total sales.

12. **Cumulative Revenue Over Time**
    Analyzed growth using window functions.

13. **Top 3 Pizzas by Revenue per Category**
    Combined ranking functions and grouping to get top performers in each category.

## 🛠️ Skills Used

* SQL Joins (INNER JOIN)
* Aggregation (SUM, COUNT, AVG)
* Grouping and Filtering
* Subqueries and Nested SELECTs
* Window Functions (RANK, SUM OVER)
* Formatting using `ROUND`

## 📊 Tools & Technologies

* **SQL (MySQL-compatible)**
* **DBMS**: MySQL / Any compatible SQL engine
* **Data Source**: Simulated relational data for pizza orders

## 📈 Business Impact

Through this analysis, business stakeholders can:

* Identify best-selling and most profitable pizzas
* Optimize inventory based on peak hours
* Understand customer preferences by size and category
* Track sales performance over time

## ✅ Future Enhancements

* Visualize key findings using Python/Power BI/Tableau
* Create dashboards for real-time sales monitoring
* Introduce customer feedback or delivery data for deeper insights

