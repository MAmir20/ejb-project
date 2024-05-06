package tn.enis.controller;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tn.enis.dto.ProductDto;
import tn.enis.service.ShopService;

/**
 * Servlet implementation class ShopController
 */
@WebServlet("/ShopController")
public class ShopController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ShopService shopService;

	public ShopController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if ("Add".equalsIgnoreCase(request.getParameter("action"))) {
			String name = request.getParameter("name");
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			int price = Integer.parseInt(request.getParameter("price"));

			ProductDto product = new ProductDto(name, quantity, price);
			shopService.add(product);
		} else if ("Delete".equalsIgnoreCase(request.getParameter("action"))) {
			String name = request.getParameter("name");
			shopService.delete(name);
		}

		request.setAttribute("products", shopService.listProducts());
		request.getRequestDispatcher("shop.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
