package com.thinkgem.jeesite.modules.erp.entity;

import java.io.Serializable;
import java.util.List;

public class AccoutInquiryPageBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private List<AccountInquiryDetail> list;

	public List<AccountInquiryDetail> getList() {
		return list;
	}

	public void setList(List<AccountInquiryDetail> list) {
		this.list = list;
	}
	
}
