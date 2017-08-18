/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 入库单子表Entity
 * @author haitao
 * @version 2017-07-26
 */
public class AccountInputDetail extends DataEntity<AccountInputDetail> {
	
	private static final long serialVersionUID = 1L;
	private String parent_id;		// 主表ordernum
	private String warehouse;		// 仓库
	private String materialname;		// 物资名称
	private String location;		// 货位编码
	private String size;		// 规格型号
	private String quantity;		// 入库数量

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	@Length(min=1, max=37, message="仓库长度必须介于 1 和 37 之间")
	public String getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(String warehouse) {
		this.warehouse = warehouse;
	}
	
	@Length(min=1, max=35, message="物资名称长度必须介于 1 和 35 之间")
	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}
	
	@Length(min=0, max=255, message="货位编码长度必须介于 0 和 255 之间")
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
	@Length(min=1, max=35, message="规格型号长度必须介于 1 和 35 之间")
	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	
	@Length(min=1, max=11, message="入库数量长度必须介于 1 和 11 之间")
	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	
}