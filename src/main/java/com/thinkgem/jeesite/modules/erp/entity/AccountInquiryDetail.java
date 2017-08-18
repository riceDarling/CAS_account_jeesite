/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 询价单子表Entity
 * @author yang
 * @version 2017-07-13
 */
public class AccountInquiryDetail extends DataEntity<AccountInquiryDetail> {
	
	private static final long serialVersionUID = 1L;
	private String inquirydetailnum;		// 询价单号
	private String ordernum;		// 单据编号
	private Date validdate;		// 询价有效期限
	private String supplier;		// 供应商名称
	private String materialname;		// 物资名称
	private String size;		// 规格型号
	private String unit;		// 计量单位
	private String unitprice;		// 单价(自动计算（保留两位）
	private String requisition;		// 申请单号
	private String maker;		// 制单人
	
	private String brand;  //商标
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	private String suppliercode;  //供应商编号
	public String getSuppliercode() {
		return suppliercode;
	}
	public void setSuppliercode(String suppliercode) {
		this.suppliercode = suppliercode;
	}
	
	private Date inquiryTime;  //询价时间
	public Date getInquiryTime() {
		return inquiryTime;
	}
	public void setInquiryTime(Date inquiryTime) {
		this.inquiryTime = inquiryTime;
	}
	
	private String materialcode;  //物资编号
	public void setMaterialcode(String materialcode) {
		this.materialcode = materialcode;
	}
	public String getMaterialcode() {
		return materialcode;
	}
	
	public AccountInquiryDetail() {
		super();
	}

	public AccountInquiryDetail(String id){
		super(id);
	}

	@Length(min=1, max=37, message="询价单号长度必须介于 1 和 37 之间")
	public String getInquirydetailnum() {
		return inquirydetailnum;
	}

	public void setInquirydetailnum(String inquirydetailnum) {
		this.inquirydetailnum = inquirydetailnum;
	}
	
	@Length(min=1, max=17, message="单据编号长度必须介于 1 和 17 之间")
	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="询价有效期限不能为空")
	public Date getValiddate() {
		return validdate;
	}

	public void setValiddate(Date validdate) {
		this.validdate = validdate;
	}
	
	@Length(min=1, max=35, message="供应商名称长度必须介于 1 和 35 之间")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=1, max=35, message="物资名称长度必须介于 1 和 35 之间")
	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}
	
	@Length(min=1, max=35, message="规格型号长度必须介于 1 和 35 之间")
	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	
	@Length(min=1, max=35, message="计量单位长度必须介于 1 和 35 之间")
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
	
	@Length(min=0, max=255, message="申请单号长度必须介于 0 和 255 之间")
	public String getRequisition() {
		return requisition;
	}

	public void setRequisition(String requisition) {
		this.requisition = requisition;
	}
	
	@Length(min=1, max=35, message="制单人长度必须介于 1 和 35 之间")
	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}
	@Override
	public String toString() {
		return "AccountInquiryDetail [inquirydetailnum=" + inquirydetailnum + ", ordernum=" + ordernum + ", validdate="
				+ validdate + ", supplier=" + supplier + ", materialname=" + materialname + ", size=" + size + ", unit="
				+ unit + ", unitprice=" + unitprice + ", requisition=" + requisition + ", maker=" + maker + ", brand="
				+ brand + ", suppliercode=" + suppliercode + ", inquiryTime=" + inquiryTime + ", materialcode="
				+ materialcode + "]";
	}

}