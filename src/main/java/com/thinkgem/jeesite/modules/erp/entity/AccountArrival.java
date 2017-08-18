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
 * 到货单Entity
 * @author admin
 * @version 2017-07-24
 */
public class AccountArrival extends DataEntity<AccountArrival> {
	
	private static final long serialVersionUID = 1L;
	private String contractId;		// 合同ID
	private String materialId;		// 采购商品ID
	private Date arrivalDate;		// 到货日期
	private String tobeNum;		// 应到数量
	private String arrivalNum;		// 实到数量
	
	private String contractTitle; //合同名称
	private String supplier;  //供应商名称
	private String materialName; //采购物资名称
	private String status;	//状态
	private String size;	//规格型号
	private String arrivalId; //到货ID（仅查询使用）
	
	public String getArrivalId() {
		return arrivalId;
	}

	public void setArrivalId(String arrivalId) {
		this.arrivalId = arrivalId;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getContractTitle() {
		return contractTitle;
	}

	public void setContractTitle(String contractTitle) {
		this.contractTitle = contractTitle;
	}

	public String getMaterialName() {
		return materialName;
	}

	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}

	public AccountArrival() {
		super();
	}

	public AccountArrival(String id){
		super(id);
	}

	@Length(min=1, max=64, message="合同ID长度必须介于 1 和 64 之间")
	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}
	
	@Length(min=1, max=64, message="采购商品ID长度必须介于 1 和 64 之间")
	public String getMaterialId() {
		return materialId;
	}

	public void setMaterialId(String materialId) {
		this.materialId = materialId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="到货日期不能为空")
	public Date getArrivalDate() {
		return arrivalDate;
	}

	public void setArrivalDate(Date arrivalDate) {
		this.arrivalDate = arrivalDate;
	}
	
	@Length(min=1, max=64, message="应到数量长度必须介于 1 和 64 之间")
	public String getTobeNum() {
		return tobeNum;
	}

	public void setTobeNum(String tobeNum) {
		this.tobeNum = tobeNum;
	}
	
	@Length(min=1, max=64, message="实到数量长度必须介于 1 和 64 之间")
	public String getArrivalNum() {
		return arrivalNum;
	}

	public void setArrivalNum(String arrivalNum) {
		this.arrivalNum = arrivalNum;
	}
	
}