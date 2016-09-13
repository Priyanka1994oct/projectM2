<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>  
<% 

	String path = request.getContextPath();
	Calendar cal = Calendar.getInstance();
	Date date=new Date();	
	int month=date.getMonth();
	int year=date.getYear();
	int dat=date.getDate();
	year=year+1900;
	SimpleDateFormat format = new SimpleDateFormat("MM/dd/YYYY");
	Calendar c = Calendar.getInstance();    
	c.set(year,month,1); 
	c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
	String toDate=format.format(c.getTime());
	String fromDate=(month+1)+"/"+01+"/"+year;

%>
<!DOCTYPE html>
<html lang="en" data-ng-app="myApp">
<head>
  <title>Estimates</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
   	<meta name="description" content="By parashar Devashish">
    
    <!--  BOOTSRAP CSS -->
    <link rel ="styleSheet" href="<%=path%>/resources/css/main.css">
  	<link rel ="styleSheet" href ="<%=path%>/resources/css/bootstrap.css">
 	<link rel='stylesheet prefetch' href="<%=path%>/resources/fonts/font-awesome.min.css">
 	<link rel='stylesheet' href="<%=path%>/resources/css/bootstrap-datepicker.css"  >
 	<link rel ="styleSheet" href="<%=path%>/resources/css/bootstrap-datetimepicker.css" type="text/css">
 	
 	 <!--  JQUERY -->
 	 <script src="<%=path%>/resources/jquery/jquery-1.12.4.js"></script>
 	 <script src="<%=path%>/resources/jquery/jquery-ui.js"></script>
 	  <script src="<%=path%>/resources/jquery/jquery.datetimepicker.js "></script>
 	 
 	 
 	<!--  BOOTSRAP JAVASCRIPT -->
 	<script src="<%=path%>/resources/js/bootstrap.js"></script>
 	<script src="<%=path %>/resources/js/moment-with-locales.js"></script>
 	<script src="<%=path%>/resources/js/bootstrap-datepicker.js"></script>
 	<script src="<%=path%>/resources/js/bootstrap-datetimepicker.js"></script>
 	  
 	 
<!--  ANGULAR -->
 	<script src="<%=path%>/resources/angular-1.5.8/angular.js"></script>
 	<script src="<%=path%>/resources/angular-1.5.8/angular-route.js"></script>
 	<script src="<%=path%>/resources/js/ui-bootstrap-tpls-2.0.1.js"></script>


<script type ="text/javascript">



var app=angular.module('myApp', []);


app.factory('estimateFactory', ['$http', function ($http) {
	 var urlBase="<%=path%>";
	return {
/* 	addUser: function(fname,lname,email, password){
		var promise = $http({
 			method:'GET',
 			url:urlBase + '/addUser?fname=' +fname+'&lname='+lname+'&email='+email+'&password='+password})
 			.success(function (data, status, headers, config) {
			      return data;
			 })
			    .error(function (data, status, headers, config) {
			      return {"status": false};
			    });
			  
			  return promise;	
}, */

		addUser: function(dataObject){
			
		
			var promise = $http({
	 			method:'POST',
	 			url:urlBase + '/addUser',
	 			data:dataObject })
	 			.success(function (data, status, headers, config) {
				      return data;
				 })
				    .error(function (data, status, headers, config) {
				      return {"status": false};
				    });
				  
				  return promise;	
	},

	 findAll :function(){
		 alert("hello");
		 	var promise = $http({
				 			method:'GET',
				 			url:urlBase+"/findAllUsers"})
				 			 .success(function (data, status, headers, config) {
				 				 alert(data);
				 				 return data;
							    })
							    .error(function (data, status, headers, config) {
							    	alert(status);
							    	return {"status": false};
							    });
							  return promise;	
	 }
	
	 }

}]);


app.controller('MyCtrl', function($scope, $http,estimateFactory) {
	 var urlBase="<%=path%>";
	 $scope.users='';
	 $scope.save=function(){
		 var dataObject= {
					fname:$scope.fname,
					lname:$scope.lname,
					email:$scope.email,
					password:$scope.password
					};
			estimateFactory.addUser(dataObject).then(function(promise){
			});
			
			$scope.fname='';
			$scope.lname='';
			$scope.email='';
			$scope.password='';
			
			 
		};
		$scope.users=[];
		 $scope.findAllUsers=function(){
			alert("hi");
				estimateFactory.findAll().then(function(promise){
					$scope.users=promise.data;	
					alert(JSON.stringify(promise.data));
				});
				
				
			};


});
</script>
</head>
<body data-ng-controller="MyCtrl" ng-init="findAllUsers()">
 <data-ng-include src="'components/header.jsp'"></data-ng-include>
    <div class="container">
		<div class="row">
			<div class="col-sm-10" style="margin-top:100px ">
			
			
	
	
	<div class="form-group">
      <label for="usr">First Name:</label>
      <input type="text" class="form-control" id="usr"  ng-model="fname">
    </div>
     <div class="form-group">
      <label for="usr">Last Name:</label>
      <input type="text" class="form-control" id="usr" ng-model="lname">
    </div>
     <div class="form-group">
      <label for="usr">Email:</label>
      <input type="text" class="form-control" id="usr" ng-model="email">
    </div>
     <div class="form-group">
      <label for="usr">Password:</label>
      <input type="text" class="form-control" id="usr" ng-model="password">
    </div> <div class="form-group">
    <button ng-click="save()" class="btn-panel-big">Add New Task</button>
    </div>
	</form>
			
			
			
			
				
			</div>
		</div>

<div class ="col-sm-10">

<table class ="table table-bordered">
<tr>
<td>First Name</td>
<td>Last Name</td>
<td>Email</td>
<td>Password</td>
</tr>

<tr  data-ng-repeat="user in users ">
<td>{{user.fname}}</td>
<td>{{user.lname}}</td>
<td>{{user.email}}</td>
<td>{{user.password}</td>
</tr>
</table>

</div>



<button ng-click="findAllUsers()"> clik me </button>


	</div> <!-- /container -->
<data-ng-include src="'components/footer.jsp'"></data-ng-include>
