/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 物资Entity
 * @author admin
 * @version 2017-07-24
 */
public class AccountMaterial extends DataEntity<AccountMaterial> {
	
	private static final long serialVersionUID = 1L;
	private String materialnum;		// 物资编码
	private String materialname;		// 物资名称
	private String size;		// 规格型号
	private String unit;		// 计量单位
	
	public AccountMaterial() {
		super();
	}

	public AccountMaterial(String id){
		super(id);
	}

	@Length(min=1, max=37, message="物资编码长度必须介于 1 和 37 之间")
	public String getMaterialnum() {
		return materialnum;
	}

	public void setMaterialnum(String materialnum) {
		this.materialnum = materialnum;
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
	
	@Length(min=0, max=35, message="计量单位长度必须介于 0 和 35 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
}