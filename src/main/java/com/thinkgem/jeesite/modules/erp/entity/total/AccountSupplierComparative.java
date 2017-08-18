package com.thinkgem.jeesite.modules.erp.entity.total;


import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商物资对比分析
 * 
 * @author 南鹏杰
 *
 */
public class AccountSupplierComparative extends DataEntity<AccountSupplierComparative> {

	private static final long serialVersionUID = 1L;
	
	private String materialcode;		// 物资编码
	private String materialname;		// 物资名称
	private String size;		// 规格型号
	private String quantity;		// 数量
	private String totalmoney;		// 总金额（含税）
	private String freightfee;		// 运费金额
	private String unitprice;		// 单价(自动计算（保留两位）
	
	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;

	// 查询开始时间
	private String beginDate;
	// 查询结束时间
	private String endDate;
	
	public String getMaterialcode() {
		return materialcode;
	}
	public void setMaterialcode(String materialcode) {
		this.materialcode = materialcode;
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
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(String totalmoney) {
		this.totalmoney = totalmoney;
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
	
	
	

}
