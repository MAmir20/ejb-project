package tn.enis.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import tn.enis.dao.ClientDao;
import tn.enis.entity.Client;

/**
 * Session Bean implementation class ShopService
 */
@Stateless
@LocalBean
public class ClientService {
	@EJB
	ClientDao clientDao;

	public void save(Client client) {
		clientDao.save(client);
	}

	public Client findById(String cin) {
		return clientDao.findById(cin);
	}
	public void delete(Client client) {
		clientDao.delete(client);
	}
	public void delete(String cin) {
		delete(findById(cin));
	}

	public void update(Client client) {
		clientDao.update(client);
	}

	public List<Client> findAll() {
		return clientDao.findAll();
	}

	public List<Client> findAllByNomClient(String nom) {
		return clientDao.findAllByNomClient(nom);
	}
}
