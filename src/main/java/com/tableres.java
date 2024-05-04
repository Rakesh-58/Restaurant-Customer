package com;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/tableres")
public class tableres extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public tableres() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String time=request.getParameter("time");
            int noOfTables= (int) Math.ceil((double) Integer.parseInt(request.getParameter("persons")) /4);
            Class.forName("com.mysql.jdbc.Driver");
            Connection c= DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
            Statement s=c.createStatement();
            ResultSet r=s.executeQuery("select free_tables from restaurant.tablelist where time='"+time+"'");
            r.next();
            if(r.getInt(1)<noOfTables || r.getInt(1)<=0)
            {
                response.sendRedirect("reservation.jsp?res=false");
            }
            else
            {
                int f=r.getInt(1)-noOfTables;
                Customer customer=new Customer(request.getParameter("name"),request.getParameter("phone"),time);
                s.executeUpdate(String.format("insert into restaurant.table_reservation values('%s','%s','%s')",customer.getName(),customer.getPhone(),customer.getTime()));
                s.executeUpdate(String.format("update restaurant.tablelist set free_tables=%d where time='%s'",f,time));
                response.sendRedirect("reservation.jsp?res=true");
            }
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
        response.sendRedirect("home.jsp");
    }
}
