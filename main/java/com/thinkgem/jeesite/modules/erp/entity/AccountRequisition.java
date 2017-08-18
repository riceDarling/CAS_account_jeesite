/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 申请单Entity
 * @author admin
 * @version 2017-07-24
 */
public class AccountRequisition extends DataEntity<AccountRequisition> {
	
	private static final long serialVersionUID = 1L;
	private String ordernum;		// 单据编号
	private String title;		// 标题
	private String reason;		// 申请原因
	private Date receivedate;		// 期望到货日期
	private Office office;		// 申请部门
	private String procInsId;		// 流程节点状态
	private String maker;		// 制单人
	private String checker;		// 审核人
	private String leadText;		// lead_text
	private String hrText;		// hr_text
	private String isInquiry;		// is_inquiry
	private List<AccountRequisitionDetail> accountRequisitionDetailList = Lists.newArrayList();		// 子表列表
	
	public AccountRequisition() {
		super();
	}

	public AccountRequisition(String id){
		super(id);
	}

	@Length(min=1, max=17, message="单据编号长度必须介于 1 和 17 之间")
	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	
	@Length(min=0, max=60, message="标题长度必须介于 0 和 60 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=255, message="申请原因长度必须介于 0 和 255 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="期望到货日期不能为空")
	public Date getReceivedate() {
		return receivedate;
	}

	public void setReceivedate(Date receivedate) {
		this.receivedate = receivedate;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=0, max=64, message="流程节点状态长度必须介于 0 和 64 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=35, message="制单人长度必须介于 1 和 35 之间")
	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}
	
	@Length(min=0, max=35, message="审核人长度必须介于 0 和 35 之间")
	public String getChecker() {
		return checker;
	}

	public void setChecker(String checker) {
		this.checker = checker;
	}
	
	public String getLeadText() {
		return leadText;
	}

	public void setLeadText(String leadText) {
		this.leadText = leadText;
	}
	
	public String getHrText() {
		return hrText;
	}

	public void setHrText(String hrText) {
		this.hrText = hrText;
	}
	
	@Length(min=0, max=64, message="is_inquiry长度必须介于 0 和 64 之间")
	public String getIsInquiry() {
		return isInquiry;
	}

	public void setIsInquiry(String isInquiry) {
		this.isInquiry = isInquiry;
	}
	
	public List<AccountRequisitionDetail> getAccountRequisitionDetailList() {
		return accountRequisitionDetailList;
	}

	public void setAccountRequisitionDetailList(List<AccountRequisitionDetail> accountRequisitionDetailList) {
		this.accountRequisitionDetailList = accountRequisitionDetailList;
	}
}