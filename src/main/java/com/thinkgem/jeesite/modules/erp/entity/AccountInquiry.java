/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 询价单Entity
 * 
 * @author 宿通
 * @version 2017-06-25
 */
public class AccountInquiry extends DataEntity<AccountInquiry> {

	private static final long serialVersionUID = 1L;
	private String inquirynum; // 询价单号
	private String ordernum; // 单据编号
	private Date validdate; // 询价有效期限
	private String supplier; // 供应商名称
	private String materialname; // 物资名称
	private String size; // 规格型号
	private String unit; // 计量单位
	private String unitprice; // 单价(自动计算（保留两位）
	private String maker; // 制单人
	private String requisition; // 申请编号

	private String inquiry;// 询价人

	private String status; // 状态值
	private String beginDate;// 开始日期
	private String endDate;// 结束日期

	private String company; // 所属公司
	private String department; // 部门
	private String title; // 标题

	public String getInquiry() {
		return inquiry;
	}

	public void setInquiry(String inquiry) {
		this.inquiry = inquiry;
	}

	public String getInquirynum() {
		return inquirynum;
	}

	public void setInquirynum(String inquirynum) {
		this.inquirynum = inquirynum;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public Date getValiddate() {
		return validdate;
	}

	public void setValiddate(Date validdate) {
		this.validdate = validdate;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getUnitprice() {
		return unitprice;
	}

	public void setUnitprice(String unitprice) {
		this.unitprice = unitprice;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getRequisition() {
		return requisition;
	}

	public void setRequisition(String requisition) {
		this.requisition = requisition;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		if (beginDate != null && !beginDate.equals("")) {
			beginDate = beginDate + " 00:00:00";
		}
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		if (endDate != null && !endDate.equals("")) {
			endDate = endDate + " 23:59:59";
		}
		this.endDate = endDate;
	}

}