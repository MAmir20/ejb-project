package tn.enis.controller;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tn.enis.entity.Client;
import tn.enis.entity.Compte;
import tn.enis.service.ClientService;
import tn.enis.service.CompteService;

/**
 * Servlet implementation class ShopController
 */
@WebServlet("/CompteController")
public class CompteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private ClientService clientService;

	@EJB
	private CompteService compteService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("Add".equals(request.getParameter("action"))) {
			float solde = Float.parseFloat(request.getParameter("solde"));
			String cin = request.getParameter("cin");
			Client client = clientService.findById(cin);
			Compte compte = new Compte(solde, client);
			compteService.save(compte);
		} else if ("Delete".equals(request.getParameter("action"))) {
			Long rib = Long.parseLong(request.getParameter("rib"));
			Compte compte = compteService.findById(rib);
			compteService.delete(compte);
		} else if ("Update".equals(request.getParameter("action"))) {
			Long rib = Long.parseLong(request.getParameter("rib"));
			float solde = Float.parseFloat(request.getParameter("solde"));
			Compte compte = compteService.findById(rib);
			compte.setSolde(solde);
			compteService.update(compte);
		} else if ("search".equals(request.getParameter("action"))) {
			String search = request.getParameter("search");
			request.setAttribute("clients", clientService.findAll());
			request.setAttribute("comptes", compteService.findByCin(search));
			request.getRequestDispatcher("comptes.jsp").forward(request, response);
			return;
		}

		request.setAttribute("clients", clientService.findAll());
		request.setAttribute("comptes", compteService.findAll());
		request.getRequestDispatcher("comptes.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
