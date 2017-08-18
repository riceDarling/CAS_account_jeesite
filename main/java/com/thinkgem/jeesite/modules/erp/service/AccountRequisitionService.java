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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisition;
import com.thinkgem.jeesite.modules.erp.dao.AccountRequisitionDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisitionDetail;
import com.thinkgem.jeesite.modules.erp.dao.AccountRequisitionDetailDao;

/**
 * 申请单Service
 * @author admin
 * @version 2017-07-24
 */
@Service
@Transactional(readOnly = true)
public class AccountRequisitionService extends CrudService<AccountRequisitionDao, AccountRequisition> {

	@Autowired
	private AccountRequisitionDetailDao accountRequisitionDetailDao;
	
	public AccountRequisition get(String id) {
		AccountRequisition accountRequisition = super.get(id);
		accountRequisition.setAccountRequisitionDetailList(accountRequisitionDetailDao.findList(new AccountRequisitionDetail(accountRequisition)));
		return accountRequisition;
	}
	
	public List<AccountRequisition> findList(AccountRequisition accountRequisition) {
		return super.findList(accountRequisition);
	}
	
	public Page<AccountRequisition> findPage(Page<AccountRequisition> page, AccountRequisition accountRequisition) {
		return super.findPage(page, accountRequisition);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountRequisition accountRequisition) {
		super.save(accountRequisition);
		for (AccountRequisitionDetail accountRequisitionDetail : accountRequisition.getAccountRequisitionDetailList()){
			if (accountRequisitionDetail.getId() == null){
				continue;
			}
			if (AccountRequisitionDetail.DEL_FLAG_NORMAL.equals(accountRequisitionDetail.getDelFlag())){
				if (StringUtils.isBlank(accountRequisitionDetail.getId())){
					accountRequisitionDetail.setParent(accountRequisition);
					accountRequisitionDetail.preInsert();
					accountRequisitionDetailDao.insert(accountRequisitionDetail);
				}else{
					accountRequisitionDetail.preUpdate();
					accountRequisitionDetailDao.update(accountRequisitionDetail);
				}
			}else{
				accountRequisitionDetailDao.delete(accountRequisitionDetail);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountRequisition accountRequisition) {
		super.delete(accountRequisition);
		accountRequisitionDetailDao.delete(new AccountRequisitionDetail(accountRequisition));
	}
	
}