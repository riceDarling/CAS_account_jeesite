/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 退货单Entity
 * @author 南鹏杰
 * @version 2017-06-25
 */
public class AccountReject extends DataEntity<AccountReject> {
	
	private static final long serialVersionUID = 1L;
	private String ordernum;		// 单据编号
	private String warehouse;		// 仓库
	private String materialname;		// 物资名称
	private String size;		// 规格型号
	private String ingredient;		// 成分含量
	private Integer quantity;		// 退货数量
	private String locationcode;		// 货位编码
	private String batch;		// 批次
	private String supplier;		// 供应商名称
	private String purchasenum;		// 采购订货编号
	private String arrivalnum;		// 到货单号
	private String maker;		// 制单人
	
	public AccountReject() {
		super();
	}

	public AccountReject(String id){
		super(id);
	}

	@Length(min=1, max=17, message="单据编号长度必须介于 1 和 17 之间")
	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	
	@Length(min=1, max=37, message="仓库长度必须介于 1 和 37 之间")
	public String getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(String warehouse) {
		this.warehouse = warehouse;
	}
	
	@Length(min=1, max=37, message="物资名称长度必须介于 1 和 37 之间")
	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}
	
	@Length(min=1, max=37, message="规格型号长度必须介于 1 和 37 之间")
	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	
	@Length(min=1, max=37, message="成分含量长度必须介于 1 和 37 之间")
	public String getIngredient() {
		return ingredient;
	}

	public void setIngredient(String ingredient) {
		this.ingredient = ingredient;
	}
	
	@NotNull(message="退货数量不能为空")
	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	
	@Length(min=1, max=17, message="货位编码长度必须介于 1 和 17 之间")
	public String getLocationcode() {
		return locationcode;
	}

	public void setLocationcode(String locationcode) {
		this.locationcode = locationcode;
	}
	
	@Length(min=1, max=255, message="批次长度必须介于 1 和 255 之间")
	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}
	
	@Length(min=1, max=37, message="供应商名称长度必须介于 1 和 37 之间")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=1, max=37, message="采购订货编号长度必须介于 1 和 37 之间")
	public String getPurchasenum() {
		return purchasenum;
	}

	public void setPurchasenum(String purchasenum) {
		this.purchasenum = purchasenum;
	}
	
	@Length(min=1, max=37, message="到货单号长度必须介于 1 和 37 之间")
	public String getArrivalnum() {
		return arrivalnum;
	}

	public void setArrivalnum(String arrivalnum) {
		this.arrivalnum = arrivalnum;
	}
	
	@Length(min=1, max=37, message="制单人长度必须介于 1 和 37 之间")
	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}
	
}