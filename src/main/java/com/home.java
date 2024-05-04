package com;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/home")
public class home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public home() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String destination=request.getParameter("dest");
		int table=Integer.parseInt(request.getParameter("tableno"));
		if(destination.equals("View Menu"))
		{
			response.sendRedirect("index.jsp?tableno="+table);
		}
		if(destination.equals("View Orders"))
		{
			response.sendRedirect("vieworder.jsp?tableno="+table);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String destination=request.getParameter("dest");
		if(destination.equals("Scan QR to order food"))
		{
			response.sendRedirect("mainmenu.jsp?tableno=1");
		}
		if(destination.equals("Table Reservation"))
		{
			response.sendRedirect("tablereservation.jsp");
		}
		
	}

}
