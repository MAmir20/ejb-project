package tn.enis.controller;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tn.enis.entity.Client;
import tn.enis.service.ClientService;

/**
 * Servlet implementation class ShopController
 */
@WebServlet("/ClientController")
public class ClientController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private ClientService clientService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("Add".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");
			String nom = request.getParameter("nom");
			String prenom = request.getParameter("prenom");

			Client client = new Client(cin, nom, prenom);
			clientService.save(client);
		} else if ("Delete".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");
			clientService.delete(cin);
		} else if ("search".equals(request.getParameter("action"))) {
			String search = request.getParameter("search");
			request.setAttribute("clients", clientService.findAllByNomClient(search));
			request.getRequestDispatcher("clients.jsp").forward(request, response);
			return;
		}

		request.setAttribute("clients", clientService.findAll());
		request.getRequestDispatcher("clients.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
