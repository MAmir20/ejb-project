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
	
	private List<ProductDto> products = new ArrayList<ProductDto>();
	private double total;
	
	public void add(ProductDto product) {
		products.add(product);
	}
	public List<ProductDto> listProducts(){
		return products;
	}
	public boolean delete(String name) {
		return products.remove(new ProductDto(name,0,0));
	}	
	
}
