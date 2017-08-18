package com.thinkgem.jeesite.modules.erp.entity.total;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商退货频率分析实体(供应商)
 * 
 * @author G8670
 *
 */
public class AccountRejectTotalRejectRateSuppliers extends DataEntity<AccountRejectTotalRejectRateSuppliers> {

	private static final long serialVersionUID = 1L;

	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;
	// 退货次数
	private Integer receiptcount;
	// 采购次数
	private Integer purchasecount;

	// 物资编码
	private String materialcode;
	// 物资名称
	private String materialname;
	// 物资型号
	private String materialsize;
	// 查询开始时间
	private Date beginDate;
	// 查询结束时间
	private Date endDate;

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

	public Integer getReceiptcount() {
		return receiptcount;
	}

	public void setReceiptcount(Integer receiptcount) {
		this.receiptcount = receiptcount;
	}

	public Integer getPurchasecount() {
		return purchasecount;
	}

	public void setPurchasecount(Integer purchasecount) {
		this.purchasecount = purchasecount;
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

	public String getMaterialsize() {
		return materialsize;
	}

	public void setMaterialsize(String materialsize) {
		this.materialsize = materialsize;
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

}
