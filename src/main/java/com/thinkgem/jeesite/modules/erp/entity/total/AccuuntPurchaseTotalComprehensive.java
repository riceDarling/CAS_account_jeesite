package com.thinkgem.jeesite.modules.erp.entity.total;


import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商物资采购综合分析表实体
 * 
 * @author G8670
 *
 */
public class AccuuntPurchaseTotalComprehensive extends DataEntity<AccuuntPurchaseTotalComprehensive> {

	private static final long serialVersionUID = 1L;
	// 合同编号
	private String contractNum;
	// 物资编码
	private String materialCode;
	// 物资名称
	private String materialName;

	// 合同数量
	private Integer contractcount;
	// 合同金额
	private Double contractmoney;
	// 到货数量
	private Integer arrivalcount;
	// 到货金额
	private Double arrivalmoney;
	// 入库数量
	private Integer inputcount;
	// 入库金额
	private Double inputmoney;
	// 损耗数量
	private Integer losscount;
	// 损耗金额
	private Double lossmoney;

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

	public String getMaterialCode() {
		return materialCode;
	}

	public void setMaterialCode(String materialCode) {
		this.materialCode = materialCode;
	}

	public String getMaterialName() {
		return materialName;
	}

	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}

	public Integer getContractcount() {
		return contractcount;
	}

	public void setContractcount(Integer contractcount) {
		this.contractcount = contractcount;
	}

	public Double getContractmoney() {
		return contractmoney;
	}

	public void setContractmoney(Double contractmoney) {
		this.contractmoney = contractmoney;
	}

	public Integer getArrivalcount() {
		return arrivalcount;
	}

	public void setArrivalcount(Integer arrivalcount) {
		this.arrivalcount = arrivalcount;
	}

	public Double getArrivalmoney() {
		return arrivalmoney;
	}

	public void setArrivalmoney(Double arrivalmoney) {
		this.arrivalmoney = arrivalmoney;
	}

	public Integer getInputcount() {
		return inputcount;
	}

	public void setInputcount(Integer inputcount) {
		this.inputcount = inputcount;
	}

	public Double getInputmoney() {
		return inputmoney;
	}

	public void setInputmoney(Double inputmoney) {
		this.inputmoney = inputmoney;
	}

	public Integer getLosscount() {
		return losscount;
	}

	public void setLosscount(Integer losscount) {
		this.losscount = losscount;
	}

	public Double getLossmoney() {
		return lossmoney;
	}

	public void setLossmoney(Double lossmoney) {
		this.lossmoney = lossmoney;
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

}
