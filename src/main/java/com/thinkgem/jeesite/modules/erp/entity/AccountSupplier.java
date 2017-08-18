/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 供应商Entity
 * @author admin
 * @version 2017-08-10
 */
public class AccountSupplier extends DataEntity<AccountSupplier> {
	
	private static final long serialVersionUID = 1L;
	private String suppliernum;		// 供应商编号
	private String supplier;		// 供应商名称
	private String address;		// 地址
	private String category;		// 分类
	private String linkman;		// 联系人
	private String phone;		// 电话
	private String weixin;		// 微信
	private String qq;		// QQ号码
	private String license;		// 营业执照
	private String certificate;		// 资质证书
	private String credit;		// 信用额度
	private String deadline;		// 付款期限
	private String information;		// 开票信息
	private String bank;		// 开户银行
	private String supplycategory;		// 主要供货种类
	private String banknum;		// 银行账号
	private String maker;		// 制单人
	
	public AccountSupplier() {
		super();
	}

	public AccountSupplier(String id){
		super(id);
	}

	@Length(min=1, max=37, message="供应商编号长度必须介于 1 和 37 之间")
	public String getSuppliernum() {
		return suppliernum;
	}

	public void setSuppliernum(String suppliernum) {
		this.suppliernum = suppliernum;
	}
	
	@Length(min=1, max=35, message="供应商名称长度必须介于 1 和 35 之间")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=1, max=120, message="地址长度必须介于 1 和 120 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=11, message="分类长度必须介于 0 和 11 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@Length(min=1, max=35, message="联系人长度必须介于 1 和 35 之间")
	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	
	@Length(min=1, max=35, message="电话长度必须介于 1 和 35 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Length(min=0, max=35, message="微信长度必须介于 0 和 35 之间")
	public String getWeixin() {
		return weixin;
	}

	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}
	
	@Length(min=0, max=35, message="QQ号码长度必须介于 0 和 35 之间")
	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}
	
	@Length(min=1, max=255, message="营业执照长度必须介于 1 和 255 之间")
	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}
	
	@Length(min=0, max=255, message="资质证书长度必须介于 0 和 255 之间")
	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}
	
	public String getCredit() {
		return credit;
	}

	public void setCredit(String credit) {
		this.credit = credit;
	}
	
	@Length(min=0, max=255, message="付款期限长度必须介于 0 和 255 之间")
	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	
	@Length(min=1, max=255, message="开票信息长度必须介于 1 和 255 之间")
	public String getInformation() {
		return information;
	}

	public void setInformation(String information) {
		this.information = information;
	}
	
	@Length(min=1, max=35, message="开户银行长度必须介于 1 和 35 之间")
	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}
	
	@Length(min=1, max=255, message="主要供货种类长度必须介于 1 和 255 之间")
	public String getSupplycategory() {
		return supplycategory;
	}

	public void setSupplycategory(String supplycategory) {
		this.supplycategory = supplycategory;
	}
	
	@Length(min=1, max=35, message="银行账号长度必须介于 1 和 35 之间")
	public String getBanknum() {
		return banknum;
	}

	public void setBanknum(String banknum) {
		this.banknum = banknum;
	}
	
	@Length(min=1, max=35, message="制单人长度必须介于 1 和 35 之间")
	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}
	
}