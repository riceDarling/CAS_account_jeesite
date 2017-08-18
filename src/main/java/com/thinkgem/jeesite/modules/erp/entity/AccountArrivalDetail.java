package com.thinkgem.jeesite.modules.erp.entity;

import java.io.Serializable;
 
public class AccountArrivalDetail implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id;	//id
	private String contractnum;		// 合同编号
	private String contracttitle;		// 合同名称

	private String purchasenum;		//采购订货单编号

	private String materialName; //采购物资名称
	private String size;		//规格型号
	private String contractId;	//物资ID
	private String quantity;	//合同签订物资数量
	private String arrivalNum;	//已到数量
	private String supplier;	//供应商名称
	
	private String materialId;	//物资ID
	
	public String getMaterialId() {
		return materialId;
	}
	public void setMaterialId(String materialId) {
		this.materialId = materialId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContractnum() {
		return contractnum;
	}
	public void setContractnum(String contractnum) {
		this.contractnum = contractnum;
	}
	public String getContracttitle() {
		return contracttitle;
	}
	public void setContracttitle(String contracttitle) {
		this.contracttitle = contracttitle;
	}
	public String getPurchasenum() {
		return purchasenum;
	}
	public void setPurchasenum(String purchasenum) {
		this.purchasenum = purchasenum;
	}
	public String getMaterialName() {
		return materialName;
	}
	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getContractId() {
		return contractId;
	}
	public void setContractId(String contractId) {
		this.contractId = contractId;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getArrivalNum() {
		return arrivalNum;
	}
	public void setArrivalNum(String arrivalNum) {
		this.arrivalNum = arrivalNum;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
}
