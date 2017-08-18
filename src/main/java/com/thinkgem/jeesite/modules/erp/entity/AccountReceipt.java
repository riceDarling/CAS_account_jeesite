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
 * 发票Entity
 * 
 * @author 南鹏杰
 * @version 2017-06-26
 */
public class AccountReceipt extends DataEntity<AccountReceipt> {

	private static final long serialVersionUID = 1L;
	private String receiptnum; // 发票号码
	private String ordernum; // 单据编号(17位编码区分普票和专票)
	private String supplier; // 供应商名称
	private Date billingdate; // 开票日期
	private String materialname; // 物资名称
	private String size; // 规格型号
	private Double pricefee; // 含税单价 自动生成（保留两位）
	private Double pricenotfee; // 不含税单价 自动生成（保留两位）
	private String quantity; // 数量
	private Double moneyfee; // 含税金额
	private Double moneynotfee; // 不含税金额
	private Double taxrte; // 税率
	private Double tax; // 税款
	private Integer category; // 发票类别
	private String maker; // maker
	private String arrivalnum; // 到货单号
	private String suppliernum;// 供应商编号

	public String getSuppliernum() {
		return suppliernum;
	}

	public void setSuppliernum(String suppliernum) {
		this.suppliernum = suppliernum;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public AccountReceipt() {
		super();
	}

	public AccountReceipt(String id) {
		super(id);
	}

	@Length(min = 1, max = 32, message = "发票号码长度必须介于 1 和 32 之间")
	public String getReceiptnum() {
		return receiptnum;
	}

	public void setReceiptnum(String receiptnum) {
		this.receiptnum = receiptnum;
	}

	@Length(min = 1, max = 35, message = "单据编号(17位编码区分普票和专票)长度必须介于 1 和 35 之间")
	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	@Length(min = 1, max = 37, message = "供应商名称长度必须介于 1 和 37 之间")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message = "开票日期不能为空")
	public Date getBillingdate() {
		return billingdate;
	}

	public void setBillingdate(Date billingdate) {
		this.billingdate = billingdate;
	}

	@Length(min = 1, max = 37, message = "物资名称长度必须介于 1 和 37 之间")
	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}

	@Length(min = 1, max = 37, message = "规格型号长度必须介于 1 和 37 之间")
	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	@NotNull(message = "含税单价	自动生成（保留两位）不能为空")
	public Double getPricefee() {
		return pricefee;
	}

	public void setPricefee(Double pricefee) {
		this.pricefee = pricefee;
	}

	@NotNull(message = "不含税单价 自动生成（保留两位）不能为空")
	public Double getPricenotfee() {
		return pricenotfee;
	}

	public void setPricenotfee(Double pricenotfee) {
		this.pricenotfee = pricenotfee;
	}

	@Length(min = 1, max = 11, message = "数量长度必须介于 1 和 11 之间")
	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	@NotNull(message = "含税金额不能为空")
	public Double getMoneyfee() {
		return moneyfee;
	}

	public void setMoneyfee(Double moneyfee) {
		this.moneyfee = moneyfee;
	}

	@NotNull(message = "不含税金额不能为空")
	public Double getMoneynotfee() {
		return moneynotfee;
	}

	public void setMoneynotfee(Double moneynotfee) {
		this.moneynotfee = moneynotfee;
	}

	@NotNull(message = "税率不能为空")
	public Double getTaxrte() {
		return taxrte;
	}

	public void setTaxrte(Double taxrte) {
		this.taxrte = taxrte;
	}

	@NotNull(message = "税款不能为空")
	public Double getTax() {
		return tax;
	}

	public void setTax(Double tax) {
		this.tax = tax;
	}

	@NotNull(message = "发票类别不能为空")
	public Integer getCategory() {
		return category;
	}

	public void setCategory(Integer category) {
		this.category = category;
	}

	@Length(min = 1, max = 32, message = "maker长度必须介于 1 和 32 之间")
	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	@Length(min = 1, max = 37, message = "到货单号长度必须介于 1 和 37 之间")
	public String getArrivalnum() {
		return arrivalnum;
	}

	public void setArrivalnum(String arrivalnum) {
		this.arrivalnum = arrivalnum;
	}

}