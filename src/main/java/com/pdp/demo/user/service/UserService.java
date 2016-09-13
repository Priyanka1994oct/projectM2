package com.pdp.demo.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pdp.demo.user.dao.UserDao;
import com.pdp.demo.user.model.User;

@Service
@Transactional(readOnly=false)
public class UserService {

	@Autowired
	private UserDao  userDao;
	
	public void saveService(User user){
		userDao.saveUser(user);
	}
}
