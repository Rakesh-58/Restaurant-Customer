<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful</title>
    <link rel="stylesheet" href="css/final.css">
</head>
<body>
    <article class="logo">
        <div class="img-container-logo">
            <img src="images/logo.png" class="img-size">
        </div>
        <h2> BR Restaurant</h2>
    </article>
    <%
        String s=request.getParameter("res");
        String print;
        if(s.equals("true"))
            print="Reservation Successful!";
        else
            print="Sorry! the tables have been booked already";
    %>
    <div class=content>
        <div class="wrapper-1">
          <div class="wrapper-2">
            <h2><%= print %></h2>
             <form action="tableres" method="post">
            <input type="submit" value="Go Home" class="go-home">
            </form>
          </div>
      </div>
      </div>
</body>
</html>