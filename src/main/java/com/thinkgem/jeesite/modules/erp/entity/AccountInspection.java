/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 送检单主表Entity
 * @author admin
 * @version 2017-07-26
 */
public class AccountInspection extends DataEntity<AccountInspection> {
	
	private static final long serialVersionUID = 1L;
	private String ordernum;		// 单据编号
	private String arrivalnum;		// 到货单编号
	private String inspectionman;		// 送检人
	private String checker;		// 检验人
	private Date inspectiondate;		// 送检日期
	private String beginInspectiondate;		// 开始 送检日期
	private String endInspectiondate;		// 结束 送检日期
	private List<AccountInspectionDetail> accountInspectionDetailList = Lists.newArrayList();		// 子表列表
	
	private String contractId;	//合同ID
	private String contractTitle;	//合同名称
	private String title;	//标题
	private String status;	//送检状态 0:不合格，1:合格
	private String materialname;		// 物资名称
	private String size;			//规格型号0:未完成1:完成
	private String inspectionDetailId;	//送检子表ID
	
	public String getInspectionDetailId() {
		return inspectionDetailId;
	}

	public void setInspectionDetailId(String inspectionDetailId) {
		this.inspectionDetailId = inspectionDetailId;
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

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getContractTitle() {
		return contractTitle;
	}

	public void setContractTitle(String contractTitle) {
		this.contractTitle = contractTitle;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public AccountInspection() {
		super();
	}

	public AccountInspection(String id){
		super(id);
	}

	@Length(min=1, max=64, message="单据编号长度必须介于 1 和 64 之间")
	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	
	@Length(min=1, max=64, message="到货单编号长度必须介于 1 和 64 之间")
	public String getArrivalnum() {
		return arrivalnum;
	}

	public void setArrivalnum(String arrivalnum) {
		this.arrivalnum = arrivalnum;
	}
	
	@Length(min=1, max=64, message="送检人长度必须介于 1 和 64 之间")
	public String getInspectionman() {
		return inspectionman;
	}

	public void setInspectionman(String inspectionman) {
		this.inspectionman = inspectionman;
	}
	
	@Length(min=0, max=64, message="检验人长度必须介于 0 和 64 之间")
	public String getChecker() {
		return checker;
	}

	public void setChecker(String checker) {
		this.checker = checker;
	}
		
	
	public Date getInspectiondate() {
		return inspectiondate;
	}

	public void setInspectiondate(Date inspectiondate) {
		this.inspectiondate = inspectiondate;
	}

	public String getBeginInspectiondate() {
		return beginInspectiondate;
	}

	public void setBeginInspectiondate(String beginInspectiondate) {
		if(beginInspectiondate!=null&&!beginInspectiondate.equals("")) {
			beginInspectiondate=beginInspectiondate+" 00:00:00";}
		this.beginInspectiondate = beginInspectiondate;
	}

	public String getEndInspectiondate() {
		return endInspectiondate;
	}

	public void setEndInspectiondate(String endInspectiondate) {
		if(endInspectiondate!=null&&!endInspectiondate.equals("")) {
			endInspectiondate=endInspectiondate+" 23:59:59";}
		this.endInspectiondate = endInspectiondate;
	}

	public List<AccountInspectionDetail> getAccountInspectionDetailList() {
		return accountInspectionDetailList;
	}

	public void setAccountInspectionDetailList(List<AccountInspectionDetail> accountInspectionDetailList) {
		this.accountInspectionDetailList = accountInspectionDetailList;
	}
}