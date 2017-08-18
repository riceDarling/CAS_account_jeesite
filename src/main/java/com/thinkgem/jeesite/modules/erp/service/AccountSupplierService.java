/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountSupplier;
import com.thinkgem.jeesite.modules.erp.dao.AccountSupplierDao;
import com.thinkgem.jeesite.modules.utils.FormatDateUtils;
import com.thinkgem.jeesite.modules.utils.RandomUtils;

/**
 * 供应商（物资）Service
 * @author admin
 * @version 2017-07-21
 */
@Service
@Transactional(readOnly = true)
public class AccountSupplierService extends CrudService<AccountSupplierDao, AccountSupplier> {

	
	public AccountSupplier get(String id) {
		AccountSupplier accountSupplier = super.get(id);
		return accountSupplier;
	}
	
	public List<AccountSupplier> findList(AccountSupplier accountSupplier) {
		return super.findList(accountSupplier);
	}
	
	public Page<AccountSupplier> findPage(Page<AccountSupplier> page, AccountSupplier accountSupplier) {
		return super.findPage(page, accountSupplier);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountSupplier accountSupplier) {
		// 生成37位供应商编码
		String suppliernum = "gy-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
		accountSupplier.setSuppliernum(suppliernum);
		super.save(accountSupplier);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountSupplier accountSupplier) {
		super.delete(accountSupplier);
	}
	public AccountSupplier getAccountSupplierByName(String supplier) {
		return dao.getAccountSupplierByName(supplier);
	}
	
	public AccountSupplier getAccountSupplierBysupplierNum(String supplierNum) {
		return dao.getAccountSupplierBysupplierNum(supplierNum);
	}
}