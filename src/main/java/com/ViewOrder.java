package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.nimbus.State;


@WebServlet("/vieworder")
public class ViewOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public ViewOrder() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int table=Integer.parseInt(request.getParameter("tableno"));
        try {
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery(String.format("select item_name,quantity,rate from restaurant.order where table_no=%d and is_prepared=1 and is_cancelled=0", table));
            Payment pay = new Payment();
            while (r.next()) {
                pay.bill.add(new Order(r.getString(1), r.getInt(2), r.getDouble(3)));
            }
            if(pay.bill.isEmpty())
            {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('No orders!');");
                out.println(String.format("window.location.href = 'mainmenu.jsp?tableno=%d';",table));
                out.println("</script>");
            }
            else{
                pay.calculateTotal();
                pay.calculateTax();
                pay.calculateNetAmount();
                response.sendRedirect(String.format("makepayment.jsp?tableno=%d&total=%f&tax=%f&net=%f", table, pay.total, pay.tax, pay.netAmount));

            }
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int table=Integer.parseInt(request.getParameter("tableno"));
            Connection c= DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "root");
            Statement s=c.createStatement();
            s.executeUpdate("delete from restaurant.order where table_no="+table);
            response.sendRedirect("final.jsp");
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }
}
