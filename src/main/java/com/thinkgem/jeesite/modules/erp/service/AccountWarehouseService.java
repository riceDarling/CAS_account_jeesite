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
import com.thinkgem.jeesite.modules.erp.entity.AccountWarehouse;
import com.thinkgem.jeesite.modules.erp.dao.AccountWarehouseDao;

/**
 * 仓库信息Service
 * @author 宿通
 * @version 2017-06-27
 */
@Service
@Transactional(readOnly = true)
public class AccountWarehouseService extends CrudService<AccountWarehouseDao, AccountWarehouse> {
@Autowired 
private AccountWarehouseDao accountWarehouseDao;
	public AccountWarehouse get(String id) {
		return super.get(id);
	}
	
	public List<AccountWarehouse> findList(AccountWarehouse accountWarehouse) {
		return super.findList(accountWarehouse);
	}
	
	public Page<AccountWarehouse> findPage(Page<AccountWarehouse> page, AccountWarehouse accountWarehouse) {
		return super.findPage(page, accountWarehouse);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountWarehouse accountWarehouse) {
		super.save(accountWarehouse);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountWarehouse accountWarehouse) {
		super.delete(accountWarehouse);
	}
	public List<AccountWarehouse> getAllWarehouse(String housename) {
		return accountWarehouseDao.getAllWarehouse(housename);
	}
}