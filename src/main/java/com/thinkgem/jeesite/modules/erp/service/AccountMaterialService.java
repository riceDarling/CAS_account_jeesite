/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.entity.AccountMaterial;
import com.thinkgem.jeesite.modules.utils.FormatDateUtils;
import com.thinkgem.jeesite.modules.utils.RandomUtils;
import com.thinkgem.jeesite.modules.erp.dao.AccountMaterialDao;

/**
 * 物资Service
 * @author admin
 * @version 2017-07-24
 */
@Service
@Transactional(readOnly = true)
public class AccountMaterialService extends CrudService<AccountMaterialDao, AccountMaterial> {

	public AccountMaterial get(String id) {
		return super.get(id);
	}
	
	public List<AccountMaterial> findList(AccountMaterial accountMaterial) {
		return super.findList(accountMaterial);
	}
	
	public Page<AccountMaterial> findPage(Page<AccountMaterial> page, AccountMaterial accountMaterial) {
		return super.findPage(page, accountMaterial);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountMaterial accountMaterial) {
		if (accountMaterial.getIsNewRecord()) {
			// 生成17位单据编号 04-20170203-00001
			String num = "25-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
			accountMaterial.setMaterialnum(num);
		}	
		super.save(accountMaterial);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountMaterial accountMaterial) {
		super.delete(accountMaterial);
	}
	
	
	
	public AccountMaterial getMaterialBymaterialcode(String materialcode) {
		return dao.getMaterialBymaterialcode(materialcode);
	}
	
	public AccountMaterial getMaterialByName(String materialname) {
		return dao.getMaterialByName(materialname);
	}

	public AccountMaterial getMaterialByCode(String code) {
		return dao.getMaterialBymaterialcode(code);
	}
}