package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Objects;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/index")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public index() {
		super();
    }
	static ArrayList<Cart> cart=new ArrayList<Cart>();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		int table=Integer.parseInt(request.getParameter("tableno"));
		System.out.println(table);
		for(Cart i:cart)
		{
			i.makeOrder(table);
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<script type=\"text/javascript\">");
		out.println("alert('Your Order has been placed');");
		out.println(String.format("window.location.href = 'mainmenu.jsp?tableno=%d';",table));
		out.println("</script>");
		//response.sendRedirect("mainmenu.jsp?tableno="+table);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		if(!cart.isEmpty())
			cart.clear();
		Enumeration<String> enumeration = request.getParameterNames();
		while(enumeration.hasMoreElements()){
			String parameterName = enumeration.nextElement();
			if(Objects.equals(parameterName, "tableno"))
				continue;
			int quantity=Integer.parseInt(request.getParameter(parameterName));
			if(quantity==0)
				continue;
			Cart temp=new Cart(Integer.parseInt(parameterName),quantity);
			temp.addMenuDetails();
			cart.add(temp);
		}
		int i=Integer.parseInt(request.getParameter("tableno"));
		if(cart.isEmpty()){
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('No items selected');");
			out.println(String.format("window.location.href = 'index.jsp?tableno=%d';",i));
			out.println("</script>");
		}
		else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("viewcart.jsp" + "?tableno=" + i);
			dispatcher.forward(request, response);
		}
	}

}
