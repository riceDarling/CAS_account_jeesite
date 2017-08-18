/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 仓库信息Entity
 * @author 宿通
 * @version 2017-06-27
 */
public class AccountWarehouse extends DataEntity<AccountWarehouse> {
	
	private static final long serialVersionUID = 1L;
	private String housename;		// 仓库名称
	private Double size;		// 仓库面积
	private String address;		// 仓库地址
	private String location;		// 货位名称
	
	public AccountWarehouse() {
		super();
	}

	public AccountWarehouse(String id){
		super(id);
	}

	@Length(min=1, max=64, message="仓库名称长度必须介于 1 和 64 之间")
	public String getHousename() {
		return housename;
	}

	public void setHousename(String housename) {
		this.housename = housename;
	}
	
	@NotNull(message="仓库面积不能为空")
	public Double getSize() {
		return size;
	}

	public void setSize(Double size) {
		this.size = size;
	}
	
	@Length(min=1, max=255, message="仓库地址长度必须介于 1 和 255 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
}