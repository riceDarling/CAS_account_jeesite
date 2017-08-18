/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.dao.AccountInquiryDetailDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiryDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisitionDetail;

/**
 * 询价单子表Service
 * @author yang
 * @version 2017-07-13
 */
@Service
@Transactional(readOnly = true)
public class AccountInquiryDetailService extends CrudService<AccountInquiryDetailDao, AccountInquiryDetail> {

	@Autowired
	private AccountInquiryDetailDao accountInquiryDetailDao;
	
	public AccountInquiryDetail get(String id) {
		return super.get(id);
	}
	
	public List<AccountInquiryDetail> findList(AccountInquiryDetail accountInquiryDetail) {
		return super.findList(accountInquiryDetail);
	}
	
	public Page<AccountInquiryDetail> findPage(Page<AccountInquiryDetail> page, AccountInquiryDetail accountInquiryDetail) {
		return super.findPage(page, accountInquiryDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountInquiryDetail accountInquiryDetail) {
		super.save(accountInquiryDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountInquiryDetail accountInquiryDetail) {
		super.delete(accountInquiryDetail);
	}
	
	@Transactional(readOnly = false)
	public List<AccountInquiryDetail> selectInquiryDetailByOrdernum(String ordernum) {
		return accountInquiryDetailDao.selectInquiryDetailByOrdernum(ordernum);
	}
	
}