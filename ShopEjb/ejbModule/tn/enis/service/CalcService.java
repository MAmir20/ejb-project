package tn.enis.service;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

/**
 * Session Bean implementation class CalcService
 */
@Stateless
@LocalBean
public class CalcService {

    /**
     * Default constructor. 
     */
    public CalcService() {
        // TODO Auto-generated constructor stub
    	
    }
    public float add(float x, float y) {
		return x + y;
	}

}
