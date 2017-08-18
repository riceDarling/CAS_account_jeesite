package com.thinkgem.jeesite.modules.erp.entity;

import java.io.Serializable;
import java.util.List;

public class RequisitionEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8268420789991066700L;
	
	
	private List<AccountRequisitionDetail> list;

	public List<AccountRequisitionDetail> getList() {
		return list;
	}

	public void setList(List<AccountRequisitionDetail> list) {
		this.list = list;
	}

	
}
