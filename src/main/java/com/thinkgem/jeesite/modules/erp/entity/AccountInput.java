/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 入库单主表Entity
 * @author haitao
 * @version 2017-07-26
 */
public class AccountInput extends DataEntity<AccountInput> {
	
	private static final long serialVersionUID = 1L;
	private String inputnum;		// 入库单号
	private Date inputdate;		// 入库日期
	private String category;		// 入库类别
	private String inspectionnum;		//送检单号
	private String contracttitle;		// 合同名称
	private String beginDate;//开始日期
	private String endDate;//结束日期
	public AccountInput() {
		super();
	}

	public AccountInput(String id){
		super(id);
	}

	@Length(min=1, max=37, message="入库单号长度必须介于 1 和 37 之间")
	public String getInputnum() {
		return inputnum;
	}

	public void setInputnum(String inputnum) {
		this.inputnum = inputnum;
	}
	
	public Date getInputdate() {
		return inputdate;
	}

	public void setInputdate(Date inputdate) {
		this.inputdate = inputdate;
	}

	@Length(min=0, max=255, message="入库类别长度必须介于 0 和 255 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	

	public String getInspectionnum() {
		return inspectionnum;
	}

	public void setInspectionnum(String inspectionnum) {
		this.inspectionnum = inspectionnum;
	}

	public String getContracttitle() {
		return contracttitle;
	}

	public void setContracttitle(String contracttitle) {
		this.contracttitle = contracttitle;
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

	
}