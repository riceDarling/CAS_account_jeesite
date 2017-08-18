/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 付款单Entity
 * @author 南鹏杰
 * @version 2017-06-26
 */
public class AccountPayment extends DataEntity<AccountPayment> {
	
	private static final long serialVersionUID = 1L;
	private String ordernum;		// 单据编号
	private String suppliercode;		// 供应商编号
	private String supplier;		// 供应商名称
	private String payamount;		// 付款金额
	private Integer payway;		// 付款方式(电汇/银承/商承/现金/网银)
	private String paycode;		// 付款编码
	private String paybank;		// 付款银行
	private String paybanknum;		// 付款银行账号
	private Integer paycategory;		// 付款类别
	private String contract;		// 合同
	private String receiptnum;		// 发票编号

	private String paydate;		// 付款日期
	private String maker;		// 制单人

	private String title;  //标题
	private String receiptAddress;  //发票图片地址
	
	private String payways;//付款方式字符串
	
	public String getPayways() {
		return payways;
	}
	public void setPayways(String payways) {
		this.payways = payways;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTitle() {
		return title;
	}
	
	public void setReceiptAddress(String receiptAddress) {
		this.receiptAddress = receiptAddress;
	}
	public String getReceiptAddress() {
		return receiptAddress;
	}
	
	
	public void setReceiptnum(String receiptnum) {
		this.receiptnum = receiptnum;
	}
	
	public String getReceiptnum() {
		return receiptnum;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public AccountPayment() {
		super();
	}

	public AccountPayment(String id){
		super(id);
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	
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
	
	public String getPayamount() {
		return payamount;
	}

	public void setPayamount(String payamount) {
		this.payamount = payamount;
	}
	
	public Integer getPayway() {
		return payway;
	}

	public void setPayway(Integer payway) {
		this.payway = payway;
	}
	
	public String getPaycode() {
		return paycode;
	}

	public void setPaycode(String paycode) {
		this.paycode = paycode;
	}
	
	public String getPaybank() {
		return paybank;
	}

	public void setPaybank(String paybank) {
		this.paybank = paybank;
	}
	
	public String getPaybanknum() {
		return paybanknum;
	}

	public void setPaybanknum(String paybanknum) {
		this.paybanknum = paybanknum;
	}
	
	public Integer getPaycategory() {
		return paycategory;
	}

	public void setPaycategory(Integer paycategory) {
		this.paycategory = paycategory;
	}
	
	public String getContract() {
		return contract;
	}

	public void setContract(String contract) {
		this.contract = contract;
	}
	
	public String getPaydate() {
		return paydate;
	}
	public void setPaydate(String paydate) {
		this.paydate = paydate;
	}
	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}
	
	
}