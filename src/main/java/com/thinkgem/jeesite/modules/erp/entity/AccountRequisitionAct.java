package com.thinkgem.jeesite.modules.erp.entity;

import java.util.Date;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.Page;

public class AccountRequisitionAct {
	private int id;
	private String requisitionId;		// 申请单id
	private String requisitionName;		// 申请人
	private String checkerName; //办理人
	private Date startTime;		// 开始时间
	private Integer state;		// 状态0未处理，1已处理
	private Date endTime;		// 结束时间
	private Integer conclusion;		// 0不同意，1同意
	private String remarks;//结论说明（备注）
	private int step;		// 步骤
	
	/**
	 * 当前实体分页对象
	 */
	protected Page<Map<String,Object>> page;
	
	
	
	public Page<Map<String, Object>> getPage() {
		return page;
	}
	public void setPage(Page<Map<String, Object>> page) {
		this.page = page;
	}
	private int actindex;//流程标识
	
	public int getActindex() {
		return actindex;
	}
	public void setActindex(int actindex) {
		this.actindex = actindex;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public void setConclusion(Integer conclusion) {
		this.conclusion = conclusion;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRequisitionId() {
		return requisitionId;
	}
	public void setRequisitionId(String requisitionId) {
		this.requisitionId = requisitionId;
	}
	public String getRequisitionName() {
		return requisitionName;
	}
	public void setRequisitionName(String requisitionName) {
		this.requisitionName = requisitionName;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public int getConclusion() {
		return conclusion;
	}
	public void setConclusion(int conclusion) {
		this.conclusion = conclusion;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public String getCheckerName() {
		return checkerName;
	}
	public void setCheckerName(String checkerName) {
		this.checkerName = checkerName;
	}
	
	
}
