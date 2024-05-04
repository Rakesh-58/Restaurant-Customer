<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu</title>
    <link rel="stylesheet" href="css/vieworder.css">
</head>
<body>
    <%@ page import="java.sql.*, java.io.*" %>
    <article class="logo">
        <div class="img-container-logo">
            <img src="images/logo.png" class="img-size">
        </div>
        <h2> BR Restaurant</h2>
    </article>
    <article class="tablenum">
                    <% String table= request.getParameter("tableno"); %>
                    <h6 style="padding-left: 10px;">Table Number: <%= table %></h6>
    </article>
    <section class="back">
        <div class="Cart-Container">
            <h2>Order Summary</h2>
            <div class="cart">
                <h4>Item Name</h4>
                <h4>Quantity</h4>
                <h4>Status</h4>


                <%

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
                    Statement stmt = c.createStatement();
                    ResultSet r=stmt.executeQuery(String.format("SELECT item_name,quantity,is_prepared from restaurant.order where table_no=%s and is_cancelled=0",table));
                    while(r.next()){
                        String status;
                        if(r.getInt(3)==0)
                            status="Preparing";
                        else
                            status="Served";
                    	%>
                    	<h5><%= r.getString(1) %></h5>
                        <h5><%= r.getString(2) %></h5>
                        <h5><%= status %></h5>

                    	<%
                    }

                }
                catch (Exception e)
                {
                    System.out.println(e.getMessage());
                }
                %>
            </div>
        </div>
    </section>
    <form action="vieworder" method="get">
        <input type="hidden" name="tableno" value="<%= table %>">
        <div class="main">
            <input type="submit" value="Make Payment" class="order">
        </div>
    </form>

</body>
