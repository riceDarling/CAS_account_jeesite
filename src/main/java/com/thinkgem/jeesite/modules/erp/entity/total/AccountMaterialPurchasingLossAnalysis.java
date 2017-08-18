package com.thinkgem.jeesite.modules.erp.entity.total;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商采购退货原因分析实体
 * 
 * @author Haitao
 *
 */
public class AccountMaterialPurchasingLossAnalysis extends DataEntity<AccountMaterialPurchasingLossAnalysis> {

	private static final long serialVersionUID = 1L;
	private String materialcode;		// 物资编码 
	private String materialname;		// 物资名称
	private String size;		// 规格型号 物资型号
	private Integer loss;//损耗数量
	private double lossmoney; //损耗金额
	private String quantity;	//采购数量
	private double purchaseAmount; //采购金额
	
	private Integer rejectnum;//退货数量
	private double rejectmoney; //退货金额
	
	private double count; //数量比
	private double money; //金额比
	
	
	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;

	// 查询开始时间
	private Date beginDate;
	// 查询结束时间
	private Date endDate;

	

	public Integer getRejectnum() {
		return rejectnum;
	}

	public void setRejectnum(Integer rejectnum) {
		this.rejectnum = rejectnum;
	}

	public double getRejectmoney() {
		return rejectmoney;
	}

	public void setRejectmoney(double rejectmoney) {
		this.rejectmoney = rejectmoney;
	}

	public Integer getLoss() {
		return loss;
	}

	public void setLoss(Integer loss) {
		this.loss = loss;
	}

	public double getLossmoney() {
		return lossmoney;
	}

	public void setLossmoney(double lossmoney) {
		this.lossmoney = lossmoney;
	}

	public double getCount() {
		return count;
	}

	public void setCount(double count) {
		this.count = count;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
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

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public double getPurchaseAmount() {
		return purchaseAmount;
	}

	public void setPurchaseAmount(double purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}

	

	
}
