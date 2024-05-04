<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Table Reservation</title>
    <link rel="stylesheet" href="css/tabler.css">
</head>
<body>
    <article class="logo">
        <div class="img-container-logo">
            <img src="images/logo.png" class="img-size">
        </div>
        <h2> BR Restaurant</h2>
    </article>
    <section class="back">
        <article class="container">
            <form action="tableres" method="get">
            <h2>Welcome</h2>
            <br><br>    
            <input type="text" name="name" placeholder="Name" style="width:20%;" required><br><br>
            <input type="number" name="phone" placeholder="Phone Number" style="width:20%;" min="1000000000" max="9999999999" required><br><br>
            <input type="number" name="persons" placeholder="No of Persons  (4 per table)" max="8" min="1" style="width:20%;" required><br><br>
            
            <label for="time">Choose a time:</label>
            <select name="time" id="time" required>
                <option value="12-2">12.00 PM - 2.00 PM</option>
                <option value="2-4">2.00 PM - 4.00 PM</option>
                <option value="4-6">4.00 PM - 6.00 PM</option>
                <option value="6-8">6.00 PM - 8.00 PM</option>
                <option value="8-10">8.00 PM - 10.00 PM</option>
            </select>
            <br><br>
            <input type="submit" value="Submit" style="background-color: #ffe134;">
            </form>

        </article>
    </section>
</body>
</html>
