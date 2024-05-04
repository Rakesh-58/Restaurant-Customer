<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu</title>
    <link rel="stylesheet" href="css/viewcart.css">
</head>
<body>
    <%@ page import="java.sql.*,java.util.Enumeration,java.util.Objects" %>
    <article class="logo">
        <div class="img-container-logo">
            <img src="images/logo.png" class="img-size">
        </div>
        <h2>BR Restaurant</h2>
    </article>
    <article class="tablenum">
                <% String table= request.getParameter("tableno"); %>
                <h6 style="padding-left: 10px;">Table Number: <%= table %></h6>
    </article>
    <section class="back">
        <div class="Cart-Container">
            <h2>Cart Summary</h2>
            <div class="cart">
                <h4>Item Name</h4>
                <h4>Quantity</h4>
                <%

                try {
                    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
                    Statement stmt = c.createStatement();
                    Enumeration<String> enumeration = request.getParameterNames();
                    while(enumeration.hasMoreElements()){
                        String parameterName = enumeration.nextElement();
                        if(Objects.equals(parameterName, "tableno"))
                        {

                            continue;
                        }
                        int quantity=Integer.parseInt(request.getParameter(parameterName));
                        if(quantity==0)
                            continue;
                    	ResultSet r=stmt.executeQuery(String.format("SELECT item_name from menu where item_id=%s",parameterName));
                        r.next();
                    	%>
                    	<h5><%= r.getString(1) %></h5>
                        <h5><%= quantity %></h5>
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
    <form action="index" method="get">
        <input type="hidden" name="tableno" value="<%= table %>">
        <div class="main">
            <input type="submit" value="Place Order" class="order">
        </div>
    </form>
</body>
