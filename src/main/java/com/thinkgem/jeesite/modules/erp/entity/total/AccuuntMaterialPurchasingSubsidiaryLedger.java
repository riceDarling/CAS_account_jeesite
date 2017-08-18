package com.thinkgem.jeesite.modules.erp.entity.total;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商明细账实体
 * 
 * @author Haitao
 *
 */
public class AccuuntMaterialPurchasingSubsidiaryLedger extends DataEntity<AccuuntMaterialPurchasingSubsidiaryLedger> {

	private static final long serialVersionUID = 1L;
	
	private Date billingdate;		// 开票日期
	private String receiptnum;		// 发票号码
	private Double moneyfee;		// 含税金额
	
	private String paydate;		// 付款日期
	private String ordernum;		// 单据编号(17位编码区分普票和专票)
	private Double payamount;		// 付款金额
	private Double balance; //余额
	
	
	
	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;

	// 查询开始时间
	private String beginDate;
	// 查询结束时间
	private String endDate;



	public String getSuppliercode() {
		return suppliercode;
	}

	public void setSuppliercode(String suppliercode) {
		this.suppliercode = suppliercode;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getBillingdate() {
		return billingdate;
	}

	public void setBillingdate(Date billingdate) {
		this.billingdate = billingdate;
	}

	public String getReceiptnum() {
		return receiptnum;
	}

	public void setReceiptnum(String receiptnum) {
		this.receiptnum = receiptnum;
	}

	public Double getMoneyfee() {
		return moneyfee;
	}

	public void setMoneyfee(Double moneyfee) {
		this.moneyfee = moneyfee;
	}

	

	public String getPaydate() {
		return paydate;
	}

	public void setPaydate(String paydate) {
		this.paydate = paydate;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public Double getPayamount() {
		return payamount;
	}

	public void setPayamount(Double payamount) {
		this.payamount = payamount;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	

}
