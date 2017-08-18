/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商期初余额录入Entity
 * @author 南鹏杰
 * @version 2017-06-26
 */
public class AccountSupplierInput extends DataEntity<AccountSupplierInput> {
	
	private static final long serialVersionUID = 1L;
	private String suppliernum;		// 供应商编号
	private String supplier;		// 供应商名称
	private Date begindate;		// 期初日期
	private Double beginmoney;		// 期初余额
	private String maker;		// 制单人
	
	public AccountSupplierInput() {
		super();
	}

	public AccountSupplierInput(String id){
		super(id);
	}

	public String getSuppliernum() {
		return suppliernum;
	}

	public void setSuppliernum(String suppliernum) {
		this.suppliernum = suppliernum;
	}
	
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="期初日期不能为空")
	public Date getBegindate() {
		return begindate;
	}

	public void setBegindate(Date begindate) {
		this.begindate = begindate;
	}
	
	@NotNull(message="期初余额不能为空")
	public Double getBeginmoney() {
		return beginmoney;
	}

	public void setBeginmoney(Double beginmoney) {
		this.beginmoney = beginmoney;
	}
	
	@Length(min=1, max=37, message="制单人长度必须介于 1 和 37 之间")
	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}
	
}