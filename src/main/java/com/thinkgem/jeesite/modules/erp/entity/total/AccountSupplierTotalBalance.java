package com.thinkgem.jeesite.modules.erp.entity.total;


import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商余额统计
 * 
 * @author 南鹏杰
 *
 */
public class AccountSupplierTotalBalance extends DataEntity<AccountSupplierTotalBalance> {

	private static final long serialVersionUID = 1L;

	private String suppliernum;		// 供应商编号
	private String supplier;		// 供应商名称
	private Double beginmoney;		// 期初余额
	private String payamount;		// 付款金额
	private Double moneyfee;		// 发票含税金额
	
	// 查询开始时间
	private String beginDate;
	// 查询结束时间
	private String endDate;
		
	public String getSuppliernum() {
		return suppliernum;
	}
	public void setSuppliernum(String suppliernum) {
		this.suppliernum = suppliernum;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	public Double getBeginmoney() {
		return beginmoney;
	}
	public void setBeginmoney(Double beginmoney) {
		this.beginmoney = beginmoney;
	}
	public String getPayamount() {
		return payamount;
	}
	public void setPayamount(String payamount) {
		this.payamount = payamount;
	}
	public Double getMoneyfee() {
		return moneyfee;
	}
	public void setMoneyfee(Double moneyfee) {
		this.moneyfee = moneyfee;
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
