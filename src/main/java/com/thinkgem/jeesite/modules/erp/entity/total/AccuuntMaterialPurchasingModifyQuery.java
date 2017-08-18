package com.thinkgem.jeesite.modules.erp.entity.total;


import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商物资采购合同修改查询统计表实体
 * 
 * @author Haitao
 *
 */
public class AccuuntMaterialPurchasingModifyQuery extends DataEntity<AccuuntMaterialPurchasingModifyQuery> {

	private static final long serialVersionUID = 1L;
	// 合同编号
	private String contractNum;
	// 合同名称
	private String contracttitle;		

	private String materialcode;		// 物资编号
	private String materialname;		// 物资名称
	private String size;		// 规格型号
	private Integer totalbatch;		// 总批次
	private String totalmoney;		// 总金额（含税）
	private String maker;		// 制单人
	private String checker;		// 审核人
	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;

	// 查询开始时间
	private String beginDate;
	// 查询结束时间
	private String endDate;

	public String getContractNum() {
		return contractNum;
	}

	public void setContractNum(String contractNum) {
		this.contractNum = contractNum;
	}

	public String getSuppliercode() {
		return suppliercode;
	}

	public void setSuppliercode(String suppliercode) {
		this.suppliercode = suppliercode;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	
	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		if(beginDate!=null&&!beginDate.equals("")) {
			beginDate=beginDate+" 00:00:00";}
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		if(endDate!=null&&!endDate.equals("")) {
			endDate=endDate+" 23:59:59";}
		this.endDate = endDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getContracttitle() {
		return contracttitle;
	}

	public void setContracttitle(String contracttitle) {
		this.contracttitle = contracttitle;
	}

	public String getMaterialcode() {
		return materialcode;
	}

	public void setMaterialcode(String materialcode) {
		this.materialcode = materialcode;
	}

	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public Integer getTotalbatch() {
		return totalbatch;
	}

	public void setTotalbatch(Integer totalbatch) {
		this.totalbatch = totalbatch;
	}

	public String getTotalmoney() {
		return totalmoney;
	}

	public void setTotalmoney(String totalmoney) {
		this.totalmoney = totalmoney;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getChecker() {
		return checker;
	}

	public void setChecker(String checker) {
		this.checker = checker;
	}

}
