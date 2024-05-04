<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu</title>
    <link rel="stylesheet" href="css/index.css">
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

    <form action="index" method="post">
        <input type="hidden" name="tableno" value="<%= table %>">
        <%
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
            Statement stmt1 = conn.createStatement();
            Statement stmt2= conn.createStatement();
            ResultSet rs1 = stmt1.executeQuery("SELECT DISTINCT category FROM menu");
            while(rs1.next()){
                String category=rs1.getString(1);
                ResultSet rs2=stmt2.executeQuery(String.format("SELECT * FROM menu WHERE category='%s'",rs1.getString(1)));
                %>
                <h2 style="text-align: center;"><%= category %></h2>
                <section class="menu">
                <%
                while (rs2.next()) {
                    String name=rs2.getString(2);
                    Double rate=Double.parseDouble(rs2.getString(5));
                    String img_url="images/"+rs2.getString(6);
                    String id=rs2.getString(1);
                    String q="Quantity";
                    %>

                    <article class="menu-item">
                        <div class="img-container">
                            <img src="<%= img_url %>" class="img-size">
                        </div>
                        <div class="details">
                            <h4><%= name %></h4>
                            <p>Rs.<%= rate %></p>
                            <button type="button" onclick="decreaseQuantity('<%= id %>')">-</button>
                            <input class="quantity" type="number" name="<%= id %>" id="<%= id+q %>" value="0" min="0" max="10" readonly>
                            <button type="button" onclick="increaseQuantity('<%= id %>')">+</button>
                        </div>
                    </article>

                    <%
            }
            %>
            </section>
            <%
            rs2.close();
            }
            // Close resources
            rs1.close();
            stmt1.close();
            conn.close();
        }
        catch(Exception e)
        {
        	e.printStackTrace();
        }
        
        
        %>
        <div class="main">
            <input type="submit" value="Add to Cart" class="order">
        </div>
    </form>

    <script>
       function increaseQuantity(itemName) {
           var quantityInput = document.getElementById(itemName + "Quantity");
           var currentQuantity = parseInt(quantityInput.value);
           if (currentQuantity < 9) {
           quantityInput.value = currentQuantity + 1;
           }
         }

         function decreaseQuantity(itemName) {
           var quantityInput = document.getElementById(itemName + "Quantity");
           var currentQuantity = parseInt(quantityInput.value);
           if (currentQuantity > 0) {
             quantityInput.value = currentQuantity - 1;
           }
         }
    </script>

</body>
</html>