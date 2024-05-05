package tn.enis.entity;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "t_compte")
public class Compte implements Serializable /* obligatoire selon JPA */ {

	private static final long serialVersionUID = 1L;
	@Id // PK
	@GeneratedValue(strategy = GenerationType.IDENTITY) // auto-increment
	private Long rib;
	private float solde;

	@ManyToOne
	@JoinColumn(name = "client_id")
	private Client client;
	// fetch:La manière de chargement des données
	// --> EAGER: dès qu'on charge le compte, le client sera chargé
	// --> LAZY: le client ne se charge pas avec le compte
	// depuis JPA2: default fetch
	// One (client)--> EAGER
	// Many (List<Client>)--> LAZY

	public Compte(float solde, Client client) {
		super();
		this.solde = solde;
		this.client = client;
	}

	public Compte() {
		super();
	}

	public Long getRib() {
		return rib;
	}

	public void setRib(Long rib) {
		this.rib = rib;
	}

	public float getSolde() {
		return solde;
	}

	public void setSolde(float solde) {
		this.solde = solde;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	@Override
	public int hashCode() {
		return Objects.hash(rib);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Compte other = (Compte) obj;
		return Objects.equals(rib, other.rib);
	}

}
