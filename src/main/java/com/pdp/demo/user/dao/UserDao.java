package com.pdp.demo.user.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.pdp.demo.user.model.User;

@Repository
public class UserDao {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	// hibernateTemplate dont use this
	
	@Autowired
	private SessionFactory factory;
	
	
	
	
	public void saveUser(User user){
		Session session = factory.openSession();
		Transaction tx =null;
		try {
			
			tx= session.beginTransaction();
			session.save(user);
			tx.commit();
			
			/*hibernateTemplate.setCheckWriteOperations(false);
			hibernateTemplate.save(user);*/
			
		} catch (Exception e) {
			System.out.println(e);
			tx.rollback();
		}finally {
			System.out.println("closig connection...");
			session.close();
		}
	}
	
	
	public List<User> findAllUer(){
	List<User> list=	(List<User>)hibernateTemplate.find("from User");
	return list;
		
	}

}
