package com.pdp.demo.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.pdp.demo.user.dao.UserDao;
import com.pdp.demo.user.model.User;
import com.pdp.demo.user.service.UserService;

@RestController
public class UserRestController {

	@Autowired
	private UserService userService;
	@Autowired
	private UserDao userDao;
	
/*@RequestMapping(value ="/addUser", method =RequestMethod.GET)
public User createUser(HttpServletRequest request){
	
	String fname=(String) request.getParameter("fname");
	String lname=(String) request.getParameter("lname");
	String email=(String) request.getParameter("email");
	String password=(String) request.getParameter("password");
	User user = new User();
	user.setFname(fname);
	user.setLname(lname);
	user.setEmail(email);
	user.setPassowrd(password);
	userService.saveService(user);
	
	return user;
}*/
	@RequestMapping(value ="/addUser", method =RequestMethod.POST)
	public  ResponseEntity<User> createUser(@RequestBody User user){
		System.out.println(user.getFname());
		userService.saveService(user);
		return new ResponseEntity<User>(user, HttpStatus.OK);		
		
	}
	
@RequestMapping("/findAllUsers")
public ResponseEntity<List<User>> findAll(){
	return new ResponseEntity<List<User>>(userDao.findAllUer(), HttpStatus.FOUND);
}

}
