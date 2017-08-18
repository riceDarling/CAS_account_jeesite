/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.entity.AccountReceipt;
import com.thinkgem.jeesite.modules.erp.dao.AccountReceiptDao;

/**
 * 发票Service
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Service
@Transactional(readOnly = true)
public class AccountReceiptService extends CrudService<AccountReceiptDao, AccountReceipt> {

	public AccountReceipt get(String id) {
		return super.get(id);
	}
	
	public List<AccountReceipt> findList(AccountReceipt accountReceipt) {
		return super.findList(accountReceipt);
	}
	
	public Page<AccountReceipt> findPage(Page<AccountReceipt> page, AccountReceipt accountReceipt) {
		return super.findPage(page, accountReceipt);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountReceipt accountReceipt) {
		super.save(accountReceipt);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountReceipt accountReceipt) {
		super.delete(accountReceipt);
	}

	public List<AccountReceipt> getAccountReceiptBySupplier(String supplier){
		return dao.getAccountReceiptBySupplier(supplier);
	}
}