/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 送检单主表Entity
 * @author admin
 * @version 2017-07-26
 */
public class AccountInspectionDetail extends DataEntity<AccountInspectionDetail> {
	
	private static final long serialVersionUID = 1L;
	private AccountInspection parent;		// 主表ID 父类
	private String materialname;		// 物资名称
	private String inspectionmode;		// 检验方式
	private String ingredient;		// 成分含量
	private String granularity;		// 粒度
	private String appearance;		// 外观
	private String size;			//规格型号
	private String status;			//检验状态 0:创建 1:不合格2:合格3:免检4:已入库
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public AccountInspectionDetail() {
		super();
	}

	public AccountInspectionDetail(String id){
		super(id);
	}

	public AccountInspectionDetail(AccountInspection parent){
		this.parent = parent;
	}

	@JsonBackReference
	@NotNull(message="主表ID不能为空")
	public AccountInspection getParent() {
		return parent;
	}

	public void setParent(AccountInspection parent) {
		this.parent = parent;
	}
	
	@Length(min=1, max=64, message="物资名称长度必须介于 1 和 64 之间")
	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}
	
	@Length(min=1, max=11, message="检验方式长度必须介于 1 和 11 之间")
	public String getInspectionmode() {
		return inspectionmode;
	}

	public void setInspectionmode(String inspectionmode) {
		this.inspectionmode = inspectionmode;
	}
	
	@Length(min=1, max=64, message="成分含量长度必须介于 1 和 64 之间")
	public String getIngredient() {
		return ingredient;
	}

	public void setIngredient(String ingredient) {
		this.ingredient = ingredient;
	}
	
	public String getGranularity() {
		return granularity;
	}

	public void setGranularity(String granularity) {
		this.granularity = granularity;
	}
	
	@Length(min=1, max=64, message="外观长度必须介于 1 和 64 之间")
	public String getAppearance() {
		return appearance;
	}

	public void setAppearance(String appearance) {
		this.appearance = appearance;
	}
	
}