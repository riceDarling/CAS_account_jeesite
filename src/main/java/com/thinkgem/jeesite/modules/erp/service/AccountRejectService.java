/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.entity.AccountReject;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalCount;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalCountSuppliers;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalRejectRate;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalRejectRateSuppliers;
import com.thinkgem.jeesite.modules.erp.dao.AccountRejectDao;

/**
 * 退货单Service
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Service
@Transactional(readOnly = true)
public class AccountRejectService extends CrudService<AccountRejectDao, AccountReject> {

	public AccountReject get(String id) {
		return super.get(id);
	}
	
	public List<AccountReject> findList(AccountReject accountReject) {
		return super.findList(accountReject);
	}
	
	public Page<AccountReject> findPage(Page<AccountReject> page, AccountReject accountReject) {
		return super.findPage(page, accountReject);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountReject accountReject) {
		super.save(accountReject);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountReject accountReject) {
		super.delete(accountReject);
	}
	
	public Page<AccountRejectTotalRejectRate> rate(Page<AccountRejectTotalRejectRate> page, AccountRejectTotalRejectRate entity) {
		entity.setPage(page);
		page.setList(dao.rate(entity));
		return page;
	}
	
	public Page<AccountRejectTotalRejectRateSuppliers> rateSuppliers(Page<AccountRejectTotalRejectRateSuppliers> page, AccountRejectTotalRejectRateSuppliers entity) {
		entity.setPage(page);
		page.setList(dao.rateSuppliers(entity));
		return page;
	}
	
	public Page<AccountRejectTotalCount> moneyCount(Page<AccountRejectTotalCount> page, AccountRejectTotalCount entity) {
		entity.setPage(page);
		page.setList(dao.moneyCount(entity));
		return page;
	}
	
	public Page<AccountRejectTotalCountSuppliers> moneyCountSuppliers(Page<AccountRejectTotalCountSuppliers> page, AccountRejectTotalCountSuppliers entity) {
		entity.setPage(page);
		page.setList(dao.moneyCountSuppliers(entity));
		return page;
	}
}