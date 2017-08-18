package com.thinkgem.jeesite.modules.erp.entity.total;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商采购退货原因分析实体
 * 
 * @author Haitao
 *
 */
public class AccountMaterialPurchaseReturnReason extends DataEntity<AccountMaterialPurchaseReturnReason> {

	private static final long serialVersionUID = 1L;
	private String materialcode;		// 物资编码 
	private String materialname;		// 物资名称
	private String size;		// 规格型号 物资型号
	private Integer quantity;		// 退货数量
	private String batch;		// 批次  退货批次
	
	private Integer purnum;		// 进货数量
	private Integer unitPrice;		// 单价
	
	
	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;

	// 查询开始时间
	private Date beginDate;
	// 查询结束时间
	private Date endDate;

	
	public Integer getPurnum() {
		return purnum;
	}

	public void setPurnum(Integer purnum) {
		this.purnum = purnum;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
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

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

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

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	
}
