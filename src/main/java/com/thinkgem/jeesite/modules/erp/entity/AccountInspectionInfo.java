package com.thinkgem.jeesite.modules.erp.entity;


public class AccountInspectionInfo {
	private String ordernum;		// 单据编号
	private String arrivalnum;		// 到货单编号
	private String inspectionman;		// 送检人
	private String checker;		// 检验人
	private String materialname;		// 物资名称
	private String inspectionmode;		// 检验方式
	private String ingredient;		// 成分含量
	private String granularity;		// 粒度
	private String appearance;		// 外观
	public String getOrdernum() {
		return ordernum;
	}
	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	public String getArrivalnum() {
		return arrivalnum;
	}
	public void setArrivalnum(String arrivalnum) {
		this.arrivalnum = arrivalnum;
	}
	public String getInspectionman() {
		return inspectionman;
	}
	public void setInspectionman(String inspectionman) {
		this.inspectionman = inspectionman;
	}
	public String getChecker() {
		return checker;
	}
	public void setChecker(String checker) {
		this.checker = checker;
	}
	public String getMaterialname() {
		return materialname;
	}
	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}
	public String getInspectionmode() {
		return inspectionmode;
	}
	public void setInspectionmode(String inspectionmode) {
		this.inspectionmode = inspectionmode;
	}
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
	public String getAppearance() {
		return appearance;
	}
	public void setAppearance(String appearance) {
		this.appearance = appearance;
	}
	
}
