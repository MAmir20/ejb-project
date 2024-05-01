package tn.enis.service;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateful;

import tn.enis.dto.ProductDto;

/**
 * Session Bean implementation class ShopService
 */
@Stateful
@LocalBean
public class ShopService {
	
	private List<ProductDto> products = new ArrayList<ProductDto>(); //retourne la liste des Products achetés
	private double total;
	
	public void add(ProductDto product) { //ajout au caddie
		products.add(product);
	}
	public List<ProductDto> listProducts(){
		return products;
	}
	public boolean delete(String name) { //supprime le Product à la position index du caddie
		return products.remove(new ProductDto(name,0,0));
	}	
	
}
