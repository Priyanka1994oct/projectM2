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
app.filter('utcToLocal', Filter);


app.filter('offset', function() {
	  return function(input, start) {
	    start = parseInt(start, 10);
	    if(start>0){
	    	return input.slice(start);
	    }else{
	    	return input;
	    }
	  };
});


app.factory('estimateFactory', ['$http', function ($http) {
	 var urlBase="<%=path%>";
	 return {
			
	 getEstimateReportByDateRange :function(fromDate,toDate){
		 	var promise = $http({
				 			method:'GET',
				 			url:urlBase+'/estimatePendingReportByCriteria?fromDate='+fromDate+'&toDate='+toDate})
				 			.success(function (data, status, headers, config) {
							      return data;
							 })
							    .error(function (data, status, headers, config) {
							      return {"status": false};
							    });
							  
							  return promise;	
	 },
	 	 getEstimateReportByYearAndMonth :function(year,month){
		 	var promise = $http({
				 			method:'GET',
				 			url:urlBase+'/estimatePendingReportByCriteria?month='+month+'&year='+year})
				 			 .success(function (data, status, headers, config) {
							      return data;
							    })
							    .error(function (data, status, headers, config) {
							      return {"status": false};
							    });
							  
							  return promise;	
	 }
	
	 }

}]);


app.controller('MyCtrl', function($scope, $http,estimateFactory,$filter) {
	$scope.propertyName = -'estimate_date';
	$scope.currentPage = 0;
	$scope.size=100;
	$('#loadingimg').show();
	$('#tableContent').hide();
	
	
	$scope.year=<%=year%>;
	$scope.month=<%=month+1%>;
	$scope.estimateList='';
	
	$scope.totalLaborSum =0;
	$scope.totalPartSum=0;
	$scope.totalServiceTaxSum=0;
	$scope.totalDisSum=0;
	$scope.totalSum=0;
	
	estimateFactory.getEstimateReportByYearAndMonth($scope.year,  $scope.month).then(function(response){
		$scope.estimateList=response.data;
		$('#loadingimg').hide();
		$('#tableContent').show();
		
	
		
		 angular.forEach($scope.estimateList, function(value, key){
		      $scope.totalLaborSum+=value.labor_charge;
		      $scope.totalPartSum+=value.part_charge;
		      $scope.totalServiceTaxSum+=value.service_tax;
		  	  $scope.totalDisSum+=value.discount;
		      $scope.totalSum+=value.total;
		   });
		
	});
	

	$scope.getReportByMonthly= function(month){
		$scope.propertyName = -'estimate_date';
		$('#loadingimg').show();
		$('#tableContent').hide();
		$scope.currentPage = 0;
		$scope.month=month;
		$scope.totalLaborSum =0;
		$scope.totalPartSum=0;
		$scope.totalServiceTaxSum=0;
		$scope.totalDisSum=0;
		$scope.totalSum=0;
		estimateFactory.getEstimateReportByYearAndMonth($scope.year,$scope.month+1).then(function(promise){
			$scope.estimateList=promise.data;
			$('#loadingimg').hide();
			$('#tableContent').show();
			 angular.forEach($scope.estimateList, function(value, key){
			      $scope.totalLaborSum+=value.labor_charge;
			      $scope.totalPartSum+=value.part_charge;
			      $scope.totalServiceTaxSum+=value.service_tax;
			  	  $scope.totalDisSum+=value.discount;
			      $scope.totalSum+=value.total;
			   });
		});
		$("ul").each(function(){
			$(this).find('li').removeClass('active');
		});
		$("li#horizmonth"+(month)).addClass('active');
};

$scope.onYearChange=function(){
	$scope.propertyName = -'estimate_date';
	$('#loadingimg').show();
	$('#tableContent').hide();
	$scope.currentPage = 0;
				$scope.totalLaborSum =0;
				$scope.totalPartSum=0;
				$scope.totalServiceTaxSum=0;
				$scope.totalDisSum=0;
				$scope.totalSum=0;
	estimateFactory.getEstimateReportByYearAndMonth($scope.year,$scope.month+1).then(function(promise){
		 $scope.estimateList=promise.data;
			$('#loadingimg').hide();
			$('#tableContent').show();
		 angular.forEach($scope.estimateList, function(value, key){
		      $scope.totalLaborSum+=value.labor_charge;
		      $scope.totalPartSum+=value.part_charge;
		      $scope.totalServiceTaxSum+=value.service_tax;
		  	  $scope.totalDisSum+=value.discount;
		      $scope.totalSum+=value.total;
		   });
	});
};




$scope.geReportByDateRange= function(){
	$scope.propertyName = -'estimate_date';
	$scope.fromDate = $('#fromDate').val();
	$scope.toDate = $('#toDate').val();
	
	$('#loadingimg').show();
	$('#tableContent').hide();
	
		$scope.totalLaborSum =0;
		$scope.totalPartSum=0;
		$scope.totalServiceTaxSum=0;
		$scope.totalDisSum=0;
		$scope.totalSum=0;
		
		estimateFactory.getEstimateReportByDateRange($scope.fromDate,$scope.toDate).then(function(promise){
			$scope.estimateList=promise.data;
			$('#loadingimg').hide();
			$('#tableContent').show();
			 angular.forEach($scope.estimateList, function(value, key){
			      $scope.totalLaborSum+=value.labor_charge;
			      $scope.totalPartSum+=value.part_charge;
			      $scope.totalServiceTaxSum+=value.service_tax;
			  	  $scope.totalDisSum+=value.discount;
			      $scope.totalSum+=value.total;
			   });
		});
	
};//end of dateRange

			
			$scope.reverse = true;
			$scope.friends = $scope.estimateList;
			
			$scope.sortBy = function(propertyName) {
				
			  $scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
			  $scope.propertyName = propertyName;
			};
			
			
			$scope.itemsPerPage = $scope.size;
			$scope.currentPage = 0;
			
			

		
		$scope.range = function() {
			var rangeSize;
			if($scope.estimateList.length < $scope.itemsPerPage){
				rangeSize = 1;
			}
			else if($scope.estimateList.length > $scope.itemsPerPage*5){
				rangeSize = 5;
			}
			else if($scope.estimateList.length > $scope.itemsPerPage*10){
				rangeSize=10;
			}
			else{
				rangeSize=2;
			}
		    //var rangeSize = 2;
		    var ret = [];
		    var start;
		
		    start = $scope.currentPage;
		    if ( start > $scope.pageCount()-rangeSize ) {
		      start = $scope.pageCount()-rangeSize+1;
		    }
			if(start<0){
				start=0;
			}
		    for (var i=start; i<start+rangeSize; i++) {
		      ret.push(i);
		    }
		    return ret;
		};
		
		$scope.prevPage = function() {
		if ($scope.currentPage > 0) {
		  $scope.currentPage--;
		}
		};
		
		$scope.prevPageDisabled = function() {
		return $scope.currentPage === 0 ? "disabled" : "";
		};
		
		$scope.pageCount = function() {
		return Math.ceil($scope.estimateList.length/$scope.itemsPerPage)-1;
		};
		
		$scope.nextPage = function() {
		if ($scope.currentPage < $scope.pageCount()) {
		  $scope.currentPage++;
		}
		};
		
		$scope.nextPageDisabled = function() {
		return $scope.currentPage === $scope.pageCount() ? "disabled" : "";
		};
		
		$scope.setPage = function(n) {
		$scope.currentPage = n;
		};
		
		});

function Filter($filter) {
    return function (utcDateString, format) {
        // return if input date is null or undefined
        if (!utcDateString) {
            return;
        }

        // append 'Z' to the date string to indicate UTC time if the timezone isn't already specified
        if (utcDateString.indexOf('Z') === -1 && utcDateString.indexOf('+') === -1) {
            utcDateString += 'Z';
        }

        // convert and format date using the built in angularjs date filter
        return $filter('date')(utcDateString, format);
    };
}

</script>
</head>
<body data-ng-controller="MyCtrl" >
 <data-ng-include src="'components/header.jsp'"></data-ng-include>
    <div class="container">
     <!-- Main component for a primary marketing message or call to action -->
		<div class="row">
			<div class="col-sm-10" >
				<ul class="nav nav-tabs" >
					<li class="active"><a data-toggle="tab" href="#monthly">Monthly</a></li>
					<li><a data-toggle="tab" href="#menu1">Date Range</a></li>
				</ul>

				<div class="tab-content">
					<div id="monthly" class="tab-pane fade in active" style="margin-top: 20px" >
						<table>
							<tr>
								<td><label style="font-size: 15px; margin-right: 5px">Year</label></td>
								<td style="margin-left: 2px">
									<select ng-model="year" class="form-control" id="sel1" data-ng-change="onYearChange()">
										<%for (int i = year - 5; i < year + 5; i++) {%>
										<option><%=i%></option>
										<%}%>
									</select>
								</td>
								<td style="margin-left: 20px; float: left">	
									<div>
										
										
				<ul class="nav nav-pills horizon ">
			        <li  id="horizmonth0"   data-ng-click="getReportByMonthly(0)"><a href="#">Jan</a></li>
			        <li  id="horizmonth1"   data-ng-click="getReportByMonthly(1)"><a href="#">Feb</a></li>
			        <li  id="horizmonth2"   data-ng-click="getReportByMonthly(2)"><a href="#">Mar</a></li>
			        <li  id="horizmonth3"   data-ng-click="getReportByMonthly(3)"><a href="#">Apr</a></li>
			        <li  id="horizmonth4"   data-ng-click="getReportByMonthly(4)"><a href="#">May</a></li>
			        <li  id="horizmonth5"   data-ng-click="getReportByMonthly(5)"><a href="#">Jun</a></li>
			        <li  id="horizmonth6"   data-ng-click="getReportByMonthly(6)"><a href="#">Jul</a></li>
			        <li  id="horizmonth7"   data-ng-click="getReportByMonthly(7)"><a href="#">Aug</a></li>
			        <li  id="horizmonth8"   data-ng-click="getReportByMonthly(8)"><a href="#">Sep</a></li>
			        <li  id="horizmonth9"   data-ng-click="getReportByMonthly(9)"><a href="#">Oct</a></li>
			        <li  id="horizmonth10"  data-ng-click="getReportByMonthly(10)"><a href="#">Nov</a></li>
			        <li  id="horizmonth11"  data-ng-click="getReportByMonthly(11)"><a href="#">Dec</a></li>
			    </ul>
										
						</div>
					</td>
				</tr>
			</table>
		</div>
					
					
<div id="menu1" class="tab-pane fade" style="margin-top: 20px">
   <div style="margin-top: 15px;display: inline-flex;">
						<span style="margin-left: 2px;font-size: 13.5px;color: #000;height: 24px;padding: 5px;font-weight: bold;" >From Date</span>
						<div class='input-group date' id="fromDateSpan" style="width: 156px;"> 
							<input type="text" class="form-control"  name="fromDate" style="width: 120px;margin-left: 0px;padding-left: 4px;" id="fromDate"  ng-modal="fromDate"  />
							<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						</div>
						<span style="margin-left: 20px;font-size: 13.5px;color: #000;height: 24px;padding: 5px;font-weight: bold;">To Date</span>
						<div class='input-group date' id="toDateSpan" style="width: 156px;">
							<input type="text"  name="toDate" class="form-control " id="toDate" style="width:120px;margin-left: 0px;padding-left: 4px;"  ng-modal="toDate"  />
							<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						</div>
						<span><input type="button"  ng-click="geReportByDateRange()" style="margin-left: 48px;" class="btn btn-primary" value="Search" /></span>
					</div>	
 </div>
	
				
					
					
				</div>
			</div>
		</div>

<div class="col-sm-10"  style="margin-top: 20px">
 		<div class="input-group">
            	<input class="form-control" ng-model="searchText" placeholder="Search" type="search" ng-change="search()" /> 
            	<span class="input-group-addon"><span class="glyphicon glyphicon-search"></span></span>
        </div>
        <div class="loading-spiner" id="loadingimg"  text-align: center;display: none;">
			<img src="<%=path%>/resources/image/spinner.gif" style="margin-top:-16px;position:absolute;">
	  	</div>
<div id ="tableContent">
	 <table  class="table table-striped table-bordered" ng-if ="estimateList.length>0" >
    <thead >
      <tr>
		       <th ng-click="sortBy('estimate_dateStr')" ><span style="font-size: 15px; text-align: right; width: 5px;!important;">Date</span></th>
		       <th ng-click="sortBy('estimate_id')"><span style="font-size: 15px; text-align: right; width: 5px;">Estimate# </span></th>
		       <th ng-click="sortBy('name')"><span style="font-size: 15px; text-align: left; width: 10px;">Customer </span></th>
		       <th ng-click="sortBy('labor_charge')"><span style="font-size: 15px; text-align: right; width: 5px;">Labour </span></th>
		       <th ng-click="sortBy('part_charge')"><span style="font-size: 15px; text-align: right; width: 5px;">Part </span></th>
		       <th ng-click="sortBy('service_tax')"><span style="font-size: 15px; text-align: right; width: 5px;">Service Tax </span></th>
		       <th ng-click="sortBy('discount')"> <span style="font-size: 15px; text-align: right; width: 5px;">Discount </span></th>
		       <th ng-click="sortBy('total')" ><span style="font-size: 15px; text-align: right; width: 5px;">Total </span></th>
      </tr>
    </thead>
    <tbody   >
    
      <tr  ng-repeat="estimate in estimateList | offset: currentPage*itemsPerPage | limitTo: itemsPerPage | orderBy:propertyName:reverse">
        	 <td>{{estimate.estimate_date|date:'MMM dd,yyyy' }}</td>
        	 <td><span style="text-align: right">{{estimate.estimate_id}}</span></td>
        	 <td><span style="text-align: right">{{estimate.name}}</span></td>
        	 <td><span style="text-align: right">{{estimate.labor_charge | number :'2'}}</span></td>
        	 <td><span style="text-align: right">{{estimate.part_charge | number :'2'}}</span></td>
        	 <td><span style="text-align: right">{{estimate.service_tax | number :'2'}}</span></td>
        	 <td><span style="text-align: right">{{estimate.discount | number :'2'}}</span></td>
        	 <td><span style="text-align: right">{{estimate.total | number :'2'}}</span></td>
      </tr>
  <tr >
  		<td colspan="3">Total</td>
  		 <td>{{totalLaborSum}}</td>
        <td>{{totalPartSum}}</td>
        <td>{{totalServiceTaxSum}}</td>
         <td>{{totalDisSum}}</td>
        <td>{{totalSum}}</td>
        
  </tr>
  
  	<tr id="paginationRow" ng-if="estimateList!=null"  >
  	
	 <td colspan="15">
	 <span><input type ="text" ng-model="size" class="form-group" value="{{size}}"></span>
			<div  style="text-align: center;">
				<ul class="pagination pagination-lg">
					<li ng-class="prevPageDisabled()"> <a href ng-click="prevPage()">« Prev</a></li>
					<li ng-repeat="n in range()" ng-class="{active: n == currentPage}" ng-click="setPage(n)"><a href="#" {{count=n+1}}>{{n+1}}</a></li>
					<li ng-class="nextPageDisabled()"> <a href ng-click="nextPage()">Next »</a> </li> 
				 </ul>
	 	 </div>
	</td>
	 </tr>
    </tbody>
  </table>
</div>
</div>
<div class="col-sm-10" style="margin-top: 20px" id ="norecordfound">
<div ng-if ="estimateList.length==0" style ="text-align: left; font-size: 17px; color: RED;">NO RECORDS FOUND </div>
</div>

	</div> <!-- /container -->
<data-ng-include src="'components/footer.jsp'"></data-ng-include>
<script type="text/javascript">
	
	$(function () {
		  $('#toDateSpan').datetimepicker({
	        	format: 'MM/DD/YYYY',
	        	defaultDate: '<%=toDate%>'
	        });
	        
	        $('#fromDateSpan').datetimepicker({
	        	format: 'MM/DD/YYYY',
	        	defaultDate: '<%=fromDate%>'
	        });
		
	
		
        
    });
	
	
	

</script>
   
