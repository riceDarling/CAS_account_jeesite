/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;


/**
 * 参数项Entity
 * @author admin
 * @version 2017-08-02
 */
public class AccountParaInfo {
	
	private int id;
	
	private int pId;		// 参数名id（父id） 父类
	private String name;		// 参数项名称
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public AccountParaInfo() {
		super();
	}
	public AccountParaInfo(int pId){
		this.pId = pId;
	}

	public int getPId() {
		return pId;
	}

	public void setPId(int pId) {
		this.pId = pId;
	}
	
	@Length(min=0, max=50, message="参数项名称长度必须介于 0 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}