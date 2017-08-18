/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 申请单Entity
 * @author admin
 * @version 2017-07-24
 */
public class AccountRequisitionDetail extends DataEntity<AccountRequisitionDetail> {
	
	private static final long serialVersionUID = 1L;
	private AccountRequisition parent;		// parent_id 父类
	private String ordernum;		// 单据编号
	private String materialcode;		// 物资编码
	private String materialname;		// 物资名称
	private String quantitiy;		// 申请数量
	private String size;		// 规格型号
	private String reason;		// 申请原因
	private Office office;		// 申请部门
	private String ingredient;		// 成分含量
	private String unit;		// 计量单位
	
	public AccountRequisitionDetail() {
		super();
	}

	public AccountRequisitionDetail(String id){
		super(id);
	}

	public AccountRequisitionDetail(AccountRequisition parent){
		this.parent = parent;
	}

	@JsonBackReference
	@NotNull(message="parent_id不能为空")
	public AccountRequisition getParent() {
		return parent;
	}

	public void setParent(AccountRequisition parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=17, message="单据编号长度必须介于 0 和 17 之间")
	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	
	@Length(min=1, max=35, message="物资编码长度必须介于 1 和 35 之间")
	public String getMaterialcode() {
		return materialcode;
	}

	public void setMaterialcode(String materialcode) {
		this.materialcode = materialcode;
	}
	
	@Length(min=1, max=35, message="物资名称长度必须介于 1 和 35 之间")
	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}
	
	@Length(min=1, max=11, message="申请数量长度必须介于 1 和 11 之间")
	public String getQuantitiy() {
		return quantitiy;
	}

	public void setQuantitiy(String quantitiy) {
		this.quantitiy = quantitiy;
	}
	
	@Length(min=1, max=35, message="规格型号长度必须介于 1 和 35 之间")
	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=1, max=120, message="成分含量长度必须介于 1 和 120 之间")
	public String getIngredient() {
		return ingredient;
	}

	public void setIngredient(String ingredient) {
		this.ingredient = ingredient;
	}
	
	@Length(min=1, max=35, message="计量单位长度必须介于 1 和 35 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
}