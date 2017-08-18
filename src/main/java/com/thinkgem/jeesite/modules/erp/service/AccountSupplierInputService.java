/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.entity.AccountSupplierInput;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountSupplierTotalBalance;
import com.thinkgem.jeesite.modules.erp.dao.AccountSupplierInputDao;

/**
 * 供应商期初余额录入Service
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Service
@Transactional(readOnly = true)
public class AccountSupplierInputService extends CrudService<AccountSupplierInputDao, AccountSupplierInput> {

	public AccountSupplierInput get(String id) {
		return super.get(id);
	}
	
	public List<AccountSupplierInput> findList(AccountSupplierInput accountSupplierInput) {
		return super.findList(accountSupplierInput);
	}
	
	public Page<AccountSupplierInput> findPage(Page<AccountSupplierInput> page, AccountSupplierInput accountSupplierInput) {
		return super.findPage(page, accountSupplierInput);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountSupplierInput accountSupplierInput) {
		super.save(accountSupplierInput);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountSupplierInput accountSupplierInput) {
		super.delete(accountSupplierInput);
	}

	public Page<AccountSupplierTotalBalance> balance(Page<AccountSupplierTotalBalance> page,
			AccountSupplierTotalBalance accountSupplierTotalBalance) {
		accountSupplierTotalBalance.setPage(page);
		page.setList(dao.findBalance());
		return page;
	}
	
}