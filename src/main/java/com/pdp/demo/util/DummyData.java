package com.pdp.demo.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Random;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pdp.demo.estimate.dao.EstimateDao;
import com.pdp.demo.estimate.model.Estimate;


//@Component
public class DummyData // implements InitializingBean
{

	@Autowired
	private EstimateDao dao;	
	private static final String CHAR_LIST =  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private static final int RANDOM_STRING_LENGTH = 10;
	GregorianCalendar gc = new GregorianCalendar();
	
	 public String generateRandomString(){
         
	        StringBuffer randStr = new StringBuffer();
	        for(int i=0; i<RANDOM_STRING_LENGTH; i++){
	            int number = getRandomNumber();
	            char ch = CHAR_LIST.charAt(number);
	            randStr.append(ch);
	        }
	        return randStr.toString();
	    }
	 
	 private int getRandomNumber() {
	        int randomInt = 0;
	        Random randomGenerator = new Random();
	        randomInt = randomGenerator.nextInt(CHAR_LIST.length());
	        if (randomInt - 1 == -1) {
	            return randomInt;
	        } else {
	            return randomInt - 1;
	        }
	    }
	 public static int randBetween(int start, int end) {
	        return start + (int)Math.round(Math.random() * (end - start));
	    }
		     
	public void afterPropertiesSet() throws Exception {
		for(int i=0;i<=1000;i++){
		Estimate estimate = new Estimate();
		estimate.setName(generateRandomString());
		estimate.setTotal((int)(Math.random()*9000)+1000);	
		
		        int year = randBetween(2015, 2016);
		        gc.set(gc.YEAR, year);
		        int dayOfYear = randBetween(1, gc.getActualMaximum(gc.DAY_OF_YEAR));
		        gc.set(gc.DAY_OF_YEAR, dayOfYear);
		       // System.out.println(gc.get(gc.YEAR) + "-" + (gc.get(gc.MONTH) + 1) + "-" + gc.get(gc.DAY_OF_MONTH));
				SimpleDateFormat formate = new SimpleDateFormat("MM/dd/yyyy");
				Date d=	formate.parse(gc.get(gc.MONTH)+1+"/"+gc.get(gc.DAY_OF_MONTH)+"/"+gc.get(gc.YEAR));
		
		estimate.setEstimate_date(d);
		estimate.setDiscount((int)(Math.random()*90)+10);
		//estimate.setEstimate_id(getRandomNumber());
		estimate.setLabor_charge(getRandomNumber());
		estimate.setPart_charge((int)(Math.random()*9000)+1000);
		estimate.setTotal(getRandomNumber());
		estimate.setService_tax((int)(Math.random()*9000)+1000);
		System.out.println("hello");
		
		dao.saveUser(estimate);
		
		}
	}
	
	

}
