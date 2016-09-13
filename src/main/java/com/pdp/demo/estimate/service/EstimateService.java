package com.pdp.demo.estimate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pdp.demo.estimate.dao.EstimateDao;
import com.pdp.demo.estimate.model.Estimate;

@Service
public class EstimateService {

	
	@Autowired
	private EstimateDao estimateDao;
	
	public List<Estimate> getEstimate(){
		return estimateDao.getEstimateReport();
	}
}
