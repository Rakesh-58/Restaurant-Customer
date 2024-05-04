<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu</title>
    <link rel="stylesheet" href="css/mainmenu.css">
</head>
<body>
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


    <article class="main2">
        <form action="home" method="get">
        <input type="hidden" name="tableno" value="<%= table %>">
            <div class="main">
                <div class="pad">
                    <input type="submit" name="dest" value="View Orders">
                </div>
                <div class="pad">
                    <input type="submit" name="dest" value="View Menu">
                </div>        
            </div>
        </form>
    </article>
</body>
