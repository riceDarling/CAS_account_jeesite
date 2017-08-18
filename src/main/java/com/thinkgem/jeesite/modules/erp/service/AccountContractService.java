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
import com.thinkgem.jeesite.modules.erp.entity.AccountContract;
import com.thinkgem.jeesite.modules.erp.dao.AccountContractDao;

/**
 * 合同Service
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Service
@Transactional(readOnly = true)
public class AccountContractService extends CrudService<AccountContractDao, AccountContract> {
@Autowired AccountContractDao accountContractDao;
	public AccountContract get(String id) {
		return super.get(id);
	}
	
	public List<AccountContract> findList(AccountContract accountContract) {
		return super.findList(accountContract);
	}
	
	public Page<AccountContract> findPage(Page<AccountContract> page, AccountContract accountContract) {
		return super.findPage(page, accountContract);
	}
	public List<AccountContract> getAllAccountContractInfo(){
	return	accountContractDao.getAllAccountContractInfo();
	}
	@Transactional(readOnly = false)
	public void save(AccountContract accountContract) {
		super.save(accountContract);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountContract accountContract) {
		super.delete(accountContract);
	}
	@Transactional(readOnly = false)
    public Boolean updateContractStatus(String id) {
		return accountContractDao.updateContractStatus(id);
	}
	@Transactional(readOnly = false)
    public Boolean updateContractStatustwo(String id) {
		return accountContractDao.updateContractStatustwo(id);
	}
}