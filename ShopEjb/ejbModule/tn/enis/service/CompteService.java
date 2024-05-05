package tn.enis.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import tn.enis.dao.CompteDao;
import tn.enis.entity.Compte;

/**
 * Session Bean implementation class ShopService
 */
@Stateless
@LocalBean
public class CompteService {
	@EJB
	CompteDao compteDao;

	public void save(Compte compte) {
		compteDao.save(compte);
	}

	public Compte findById(Long rib) {
		return compteDao.findById(rib);
	}
	public void delete(Compte compte) {
		compteDao.delete(compte);
	}
	public void delete(Long rib) {
		compteDao.delete(findById(rib));
	}

	public void update(Compte compte) {
		compteDao.update(compte);
	}

	public List<Compte> findAll() {
		return compteDao.findAll();
	}

	public List<Compte> findByCin(String cin) {
		return compteDao.findByCin(cin);
	}
}
