package tn.enis.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import tn.enis.entity.Client;
import tn.enis.entity.Compte;

/**
 * Session Bean implementation class CompteDao
 */
@Singleton
@LocalBean
public class CompteDao {

	@PersistenceContext
	private EntityManager entityManager;

	public void save(Compte compte) {
		entityManager.persist(compte);
	}

	public Compte findById(Long rib) {
		return entityManager.find(Compte.class, rib);
	}

	public void delete(Compte compte) {
		entityManager.remove(entityManager.contains(compte) ? compte : entityManager.merge(compte));
	}

	public void update(Compte compte) {
		entityManager.merge(compte);
		entityManager.flush();
	}

	public List<Compte> findAll() {
		// langage = EJB-QL, != SQL;
		// EJB-QL =~ SQL orienté Objet, on utilise le nom de l'entité et non de la table
		return entityManager.createQuery("select c from Compte c", Compte.class).getResultList();
	}

	public List<Compte> findByCin(String cin) {
		return entityManager.createQuery("select c from Compte c where c.client.cin = :cin", Compte.class)
				.setParameter("cin", cin).getResultList();
	}
	
	public List<Compte> findByNomClient(String nom) {
		return entityManager
				.createQuery("select c from Compte c where c.client.nom like :nom or c.client.prenom like :prenom", Compte.class)
				.setParameter("nom", "%" + nom + "%").setParameter("prenom", "%" + nom + "%").getResultList();
	}

	/*
	 * public List<Compte> findAllByClient(String client) { // EJB-QL: on utilise le
	 * nom de l'attribut et non celui du champ de la table // requete paramétrée, le
	 * paramètre est déclaté avec ":" (:client) // puis remplacé par setParameter,
	 * // NB: setParameter filtre les injections SQL return
	 * entityManager.createQuery("select c from Compte c where c.nomClient=:client",
	 * Compte.class) .setParameter("client", client).getResultList(); }
	 */
}
