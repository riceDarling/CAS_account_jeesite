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
import com.thinkgem.jeesite.modules.erp.entity.AccountInput;
import com.thinkgem.jeesite.modules.erp.entity.AccountInputInfo;
import com.thinkgem.jeesite.modules.erp.dao.AccountInputDao;

/**
 * 入库单主表Service
 * @author haitao
 * @version 2017-07-26
 */
@Service
@Transactional(readOnly = true)
public class AccountInputService extends CrudService<AccountInputDao, AccountInput> {
@Autowired
	private AccountInputDao accountInputDao;
	public AccountInput get(String id) {
		AccountInput accountInput = super.get(id);
		return accountInput;
	}
	
	public List<AccountInput> findList(AccountInput accountInput) {
		return super.findList(accountInput);
	}
	
	public Page<AccountInput> findPage(Page<AccountInput> page, AccountInput accountInput) {
		return super.findPage(page, accountInput);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountInput accountInput) {
		super.save(accountInput);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountInput accountInput) {
		super.delete(accountInput);
	}
	public List<AccountInputInfo> getAccountInputInfo() {
		return accountInputDao.getAccountInputInfo();
	}
	public	List<AccountInputInfo> getAccountInputListInfoBy(AccountInput accountInput){
		return accountInputDao.getAccountInputListInfoBy(accountInput);
	}
	public int getAccountInput(String Inspectionnum){
		return accountInputDao.getAccountInput(Inspectionnum);
	}
	@Transactional(readOnly = false)
	public Boolean updateStatus(String ordernum){
		return accountInputDao.updateStatus(ordernum);
	}
	@Transactional(readOnly = false)
	public Boolean updateInspectionStatus(String ordernum){
		return accountInputDao.updateInspectionStatus(ordernum);
	}
}