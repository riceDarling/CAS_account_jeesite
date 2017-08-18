package com.thinkgem.jeesite.modules.erp.entity.total;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商采购退货数量及金额分析实体
 * 
 * @author G8670
 *
 */
public class AccountRejectTotalCount extends DataEntity<AccountRejectTotalCount> {

	private static final long serialVersionUID = 1L;

	// 物资编码
	private String materialcode;
	// 物资名称
	private String materialname;
	// 物资型号
	private String materialsize;

	// 退货数量
	private Integer receiptsum;
	// 退货金额
	private Double receiptmoney;

	// 采购数量
	private Integer purchasesum;
	// 采购金额
	private Double purchasemoney;

	// 数量占比(每行退货数量/退货数量合计)
	private Double sumratio;
	// 金额占比(每行退货金额/退货金额合计)
	private Double moneyratio;

	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;

	// 查询开始时间
	private Date beginDate;
	// 查询结束时间
	private Date endDate;

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

	public Integer getReceiptsum() {
		return receiptsum;
	}

	public void setReceiptsum(Integer receiptsum) {
		this.receiptsum = receiptsum;
	}

	public Double getReceiptmoney() {
		return receiptmoney;
	}

	public void setReceiptmoney(Double receiptmoney) {
		this.receiptmoney = receiptmoney;
	}

	public Integer getPurchasesum() {
		return purchasesum;
	}

	public void setPurchasesum(Integer purchasesum) {
		this.purchasesum = purchasesum;
	}

	public Double getPurchasemoney() {
		return purchasemoney;
	}

	public void setPurchasemoney(Double purchasemoney) {
		this.purchasemoney = purchasemoney;
	}

	public Double getSumratio() {
		return sumratio;
	}

	public void setSumratio(Double sumratio) {
		this.sumratio = sumratio;
	}

	public Double getMoneyratio() {
		return moneyratio;
	}

	public void setMoneyratio(Double moneyratio) {
		this.moneyratio = moneyratio;
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

}
