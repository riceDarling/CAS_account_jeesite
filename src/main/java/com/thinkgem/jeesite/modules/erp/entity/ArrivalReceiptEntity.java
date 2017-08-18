package com.thinkgem.jeesite.modules.erp.entity;

import java.io.Serializable;
import java.util.List;

public class ArrivalReceiptEntity implements Serializable{

private static final long serialVersionUID = -8268420789991066700L;
	
	
	private List<AccountArrival> list;

	public List<AccountArrival> getList() {
		return list;
	}

	public void setList(List<AccountArrival> list) {
		this.list = list;
	}
}
