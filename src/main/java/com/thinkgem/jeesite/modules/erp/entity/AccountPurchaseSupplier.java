/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 订货供应商Entity
 * 
 * @author admin
 * @version 2017-07-26
 */
public class AccountPurchaseSupplier extends DataEntity<AccountPurchaseSupplier> {

	private static final long serialVersionUID = 1L;
	private AccountPurchase parent; // parent_id
	private String supplier;// 供应商名称
	private Date deadline; // 付款期限
	private String payway; // 付款方式

	private String deadlines;// 付款期限字符串

	private String payways;// 付款方式字符串

	public String getPayways() {
		return payways;
	}

	public void setPayways(String payways) {
		this.payways = payways;
	}

	public String getDeadlines() {
		return deadlines;
	}

	public void setDeadlines(String deadlines) {
		this.deadlines = deadlines;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public AccountPurchaseSupplier() {
		super();
	}

	public AccountPurchaseSupplier(String id) {
		super(id);
	}

	public AccountPurchase getParent() {
		return parent;
	}

	public void setParent(AccountPurchase parent) {
		this.parent = parent;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDeadline() {
		return deadline;
	}

	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}

	@Length(min = 0, max = 11, message = "付款方式长度必须介于 0 和 11 之间")
	public String getPayway() {
		return payway;
	}

	public void setPayway(String payway) {
		this.payway = payway;
	}

}