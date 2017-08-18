/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrival;
import com.thinkgem.jeesite.modules.erp.entity.AccountInspection;
import com.thinkgem.jeesite.modules.erp.dao.AccountInspectionDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountInspectionDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountInspectionInfo;
import com.thinkgem.jeesite.modules.erp.dao.AccountInspectionDetailDao;

/**
 * 送检单主表Service
 * @author admin
 * @version 2017-07-26
 */
@Service
@Transactional(readOnly = true)
public class AccountInspectionService extends CrudService<AccountInspectionDao, AccountInspection> {
	@Autowired
	private AccountInspectionDetailDao accountInspectionDetailDao;
	
	@Autowired
	private AccountInspectionDao accountInspectionDao;
	
	public AccountInspection get(String id) {
		AccountInspection accountInspection = super.get(id);
		//accountInspection.setAccountInspectionDetailList(accountInspectionDetailDao.findList(new AccountInspectionDetail(accountInspection)));
		return accountInspection;
	}
	
	public List<AccountInspection> findList(AccountInspection accountInspection) {
		return super.findList(accountInspection);
	}
	
	public Page<AccountInspection> findPage(Page<AccountInspection> page, AccountInspection accountInspection) {
		return super.findPage(page, accountInspection);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountInspection accountInspection) {
		super.save(accountInspection);
		for (AccountInspectionDetail accountInspectionDetail : accountInspection.getAccountInspectionDetailList()){
//			if (accountInspectionDetail.getId() == null){
//				continue;
//			}
			if (AccountInspectionDetail.DEL_FLAG_NORMAL.equals(accountInspectionDetail.getDelFlag())){
				if (StringUtils.isBlank(accountInspectionDetail.getId())){
					accountInspectionDetail.setParent(accountInspection);
					accountInspectionDetail.preInsert();
					accountInspectionDetailDao.insert(accountInspectionDetail);
				}else{
					accountInspectionDetail.preUpdate();
					accountInspectionDetailDao.update(accountInspectionDetail);
				}
			}else{
				accountInspectionDetailDao.delete(accountInspectionDetail);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public int updateDetail(AccountInspectionDetail accountInspectionDetail) {
		accountInspectionDetail.preUpdate();
		return accountInspectionDetailDao.updateDetail(accountInspectionDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountInspection accountInspection) {
		super.delete(accountInspection);
		accountInspectionDetailDao.delete(new AccountInspectionDetail(accountInspection));
	}
	public List<AccountInspectionInfo> getAccount_inspectionInfo(String ordernum) {
		return accountInspectionDetailDao.getAccount_inspectionInfo(ordernum);
		}
	public List<AccountArrival> getArrivalList(){
		return accountInspectionDao.getArrivalList();
	}
	
	public List<AccountArrival> getDetailByDateAndContractId(AccountArrival accountArrival){
		return accountInspectionDao.getDetailByDateAndContractId(accountArrival);
	}

	public List<AccountInspection> getNextInspection(AccountInspection accountInspection){
		return accountInspectionDao.getNextInspection(accountInspection);
	}
	public AccountInspection getInspectionDetailToAdd(AccountInspection accountInspection){
		return accountInspectionDao.getInspectionDetailToAdd(accountInspection);
	}

}