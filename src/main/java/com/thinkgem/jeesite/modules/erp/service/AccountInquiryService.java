/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiry;
import com.thinkgem.jeesite.modules.erp.dao.AccountInquiryDao;

/**
 * 询价单Service
 * @author 宿通
 * @version 2017-06-25
 */
@Service
@Transactional(readOnly = true)
public class AccountInquiryService extends CrudService<AccountInquiryDao, AccountInquiry> {

	@Autowired
	private AccountInquiryDao accountInquiryDao;
	
	public AccountInquiry get(String id) {
		return super.get(id);
	}
	
	public List<AccountInquiry> findList(AccountInquiry accountInquiry) {
		return super.findList(accountInquiry);
	}
	

	
	/*public Page<AccountInquiry> searchPage(Page<AccountInquiry> page, AccountInquiry accountInquiry) {
		List<AccountInquiry> list = accountInquiryDao.selectInquiryByDateAndStatus(accountInquiry);
		accountInquiry.setPage(page);
		page.setList(list);
		return page;
	}*/
	
	@Transactional(readOnly = false)
	public void save(AccountInquiry accountInquiry) {
		super.save(accountInquiry);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountInquiry accountInquiry) {
		super.delete(accountInquiry);
	}
	
	@Transactional(readOnly = false)
	public void commit1(String ordernum) {
		accountInquiryDao.commit1(ordernum);
	}
	
	public String getRequisitionId(String ordernum) {
		return dao.getRequisitionId(ordernum);
	}
	
}