package com.thinkgem.jeesite.modules.erp.entity.total;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商到货发票统计表实体
 * 
 * @author G8670
 *
 */
public class AccuuntPurchaseTotalinvoice extends DataEntity<AccuuntPurchaseTotalinvoice> {

	private static final long serialVersionUID = 1L;

	// 入库单号
	private String inputcode;
	// 入库数量
	private Integer inputcount;
	// 入库金额
	private Double inputmoney;

	// 发票号码
	private String receiptcode;
	// 发票数量
	private Integer receiptcount;
	// 发票金额
	private Double receiptmoney;

	// 期末数量
	private Integer losscount;
	// 期末金额
	private Double lossmoney;

	// 供应商编号
	private String suppliercode;
	// 供应商名称
	private String supplier;

	// 查询开始时间
	private String beginDate;
	// 查询结束时间
	private String endDate;

	public String getInputcode() {
		return inputcode;
	}

	public void setInputcode(String inputcode) {
		this.inputcode = inputcode;
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

	public String getReceiptcode() {
		return receiptcode;
	}

	public void setReceiptcode(String receiptcode) {
		this.receiptcode = receiptcode;
	}

	public Integer getReceiptcount() {
		return receiptcount;
	}

	public void setReceiptcount(Integer receiptcount) {
		this.receiptcount = receiptcount;
	}

	public Double getReceiptmoney() {
		return receiptmoney;
	}

	public void setReceiptmoney(Double receiptmoney) {
		this.receiptmoney = receiptmoney;
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
