/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.entity.AccountInputDetail;
import com.thinkgem.jeesite.modules.erp.dao.AccountInputDetailDao;

/**
 * 入库单子表Service
 * @author haitao
 * @version 2017-07-26
 */
@Service
@Transactional(readOnly = true)
public class AccountInputDetailService extends CrudService<AccountInputDetailDao, AccountInputDetail> {

	public AccountInputDetail get(String id) {
		return super.get(id);
	}
	
	public List<AccountInputDetail> findList(AccountInputDetail accountInputDetail) {
		return super.findList(accountInputDetail);
	}
	
	public Page<AccountInputDetail> findPage(Page<AccountInputDetail> page, AccountInputDetail accountInputDetail) {
		return super.findPage(page, accountInputDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountInputDetail accountInputDetail) {
		super.save(accountInputDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountInputDetail accountInputDetail) {
		super.delete(accountInputDetail);
	}
	
}