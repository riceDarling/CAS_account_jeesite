/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 订货单Entity
 * 
 * @author admin
 * @version 2017-07-26
 */
public class AccountPurchaseDetail extends DataEntity<AccountPurchaseDetail> {

	private static final long serialVersionUID = 1L;
	private AccountPurchase parent; // 主表id 父类
	private String suppliercode; // 供应商编号
	private String materialcode; // 物资编号
	private String packway; // 包装方式
	private String transport; // 运输方式
	private String freightfee; // 运费金额
	private String unitprice; // 单价
	private String quantity; // 数量
	private Date receivedate; // 预计到货日期
	private String totlemoney; // 总价

	private String packways;// 包装方式字符串
	private String transports;// 运输方式字符串

	private String receivedates;// 预计到货日期字符串

	public String getPackways() {
		return packways;
	}

	public void setPackways(String packways) {
		this.packways = packways;
	}

	public String getTransports() {
		return transports;
	}

	public void setTransports(String transports) {
		this.transports = transports;
	}

	public String getReceivedates() {
		return receivedates;
	}

	public void setReceivedates(String receivedates) {
		this.receivedates = receivedates;
	}

	public AccountPurchaseDetail() {
		super();
	}

	public AccountPurchaseDetail(String id) {
		super(id);
	}

	public AccountPurchaseDetail(AccountPurchase parent) {
		this.parent = parent;
	}

	@JsonBackReference
	@NotNull(message = "主表id不能为空")
	public AccountPurchase getParent() {
		return parent;
	}

	public void setParent(AccountPurchase parent) {
		this.parent = parent;
	}

	@Length(min = 1, max = 35, message = "供应商编号长度必须介于 1 和 35 之间")
	public String getSuppliercode() {
		return suppliercode;
	}

	public void setSuppliercode(String suppliercode) {
		this.suppliercode = suppliercode;
	}

	@Length(min = 1, max = 35, message = "物资编号长度必须介于 1 和 35 之间")
	public String getMaterialcode() {
		return materialcode;
	}

	public void setMaterialcode(String materialcode) {
		this.materialcode = materialcode;
	}

	@Length(min = 0, max = 3, message = "包装方式长度必须介于 0 和 3 之间")
	public String getPackway() {
		return packway;
	}

	public void setPackway(String packway) {
		this.packway = packway;
	}

	@Length(min = 0, max = 3, message = "运输方式长度必须介于 0 和 3 之间")
	public String getTransport() {
		return transport;
	}

	public void setTransport(String transport) {
		this.transport = transport;
	}

	public String getFreightfee() {
		return freightfee;
	}

	public void setFreightfee(String freightfee) {
		this.freightfee = freightfee;
	}

	public String getUnitprice() {
		return unitprice;
	}

	public void setUnitprice(String unitprice) {
		this.unitprice = unitprice;
	}

	@Length(min = 1, max = 11, message = "数量长度必须介于 1 和 11 之间")
	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReceivedate() {
		return receivedate;
	}

	public void setReceivedate(Date receivedate) {
		this.receivedate = receivedate;
	}

	public String getTotlemoney() {
		return totlemoney;
	}

	public void setTotlemoney(String totlemoney) {
		this.totlemoney = totlemoney;
	}

}