/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 合同表Entity
 * @author haitao
 * @version 2017-07-26
 */
public class AccountContract extends DataEntity<AccountContract> {
	
	private static final long serialVersionUID = 1L;
	private String contractnum;		// 合同编号
	private String title;		// 采购标题
	private String supplier;		// 供应商名称
	private String contracttitle;		// 合同名称
	private String purchasenum;		// 采购单号
	private String supplierNum;	//供应商编号
	private String caigouname;		// 乙方
	private Double money;		// 应付金额
	private String company;		// 公司
	private String status;		// 合同状态(0:未完成  1:完成)
	private String beginDate;//开始日期
	private String endDate;//结束日期
	
	public AccountContract() {
		super();
	}

	public AccountContract(String id){
		super(id);
	}

	@Length(min=1, max=37, message="合同编号长度必须介于 1 和 37 之间")
	public String getContractnum() {
		return contractnum;
	}

	public void setContractnum(String contractnum) {
		this.contractnum = contractnum;
	}
	
	@Length(min=1, max=255, message="合同名称长度必须介于 1 和 255 之间")
	public String getContracttitle() {
		return contracttitle;
	}

	public void setContracttitle(String contracttitle) {
		this.contracttitle = contracttitle;
	}
	
	@Length(min=1, max=255, message="采购单号长度必须介于 1 和 255 之间")
	public String getPurchasenum() {
		return purchasenum;
	}

	public void setPurchasenum(String purchasenum) {
		this.purchasenum = purchasenum;
	}
	
	@Length(min=0, max=64, message="乙方长度必须介于 0 和 64 之间")
	public String getCaigouname() {
		return caigouname;
	}

	public void setCaigouname(String caigouname) {
		this.caigouname = caigouname;
	}
	
	
	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	@Length(min=0, max=64, message="公司长度必须介于 0 和 64 之间")
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
	
	@Length(min=0, max=1, message="合同状态(0:未完成  1:完成)长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getSupplierNum() {
		return supplierNum;
	}

	public void setSupplierNum(String supplierNum) {
		this.supplierNum = supplierNum;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		if(beginDate!=null&&!beginDate.equals("")) {
		beginDate=beginDate+" 00:00:00";}
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		if(endDate!=null&&!endDate.equals("")) {
			endDate=endDate+" 23:59:59";}
		this.endDate = endDate;
	}
	
}