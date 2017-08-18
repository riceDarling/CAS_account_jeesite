/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.dao.AccountArrivalDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrival;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrivalDetail;
import com.thinkgem.jeesite.modules.erp.entity.ArrivalReceiptEntity;

/**
 * 到货单Service
 * @author admin
 * @version 2017-07-24
 */
@Service
@Transactional(readOnly = true)
public class AccountArrivalService extends CrudService<AccountArrivalDao, AccountArrival> {

	@Autowired
	AccountArrivalDao accountArrivalDao;
	
	public AccountArrival get(String id) {
		return super.get(id);
	}
	
	public List<AccountArrival> findList(AccountArrival accountArrival) {
		return super.findList(accountArrival);
	}
	
	public Page<AccountArrival> findPage(Page<AccountArrival> page, AccountArrival accountArrival) {
		return super.findPage(page, accountArrival);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountArrival accountArrival) {
		super.save(accountArrival);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountArrival accountArrival) {
		super.delete(accountArrival);
	}
	
	public List<AccountArrival> getNextForm(String id){
		return accountArrivalDao.getNextForm(id);
	}
	
	public List<AccountArrival> getLastForm(AccountArrival accountArrival){
		return accountArrivalDao.getLastForm(accountArrival);
	}

	@Transactional(readOnly = false)
	public void saveForm(ArrivalReceiptEntity arrEntity) {
		List<AccountArrival> list = arrEntity.getList();
		for (AccountArrival arr : list) {
			super.save(arr);
		}
	}
	
	public List<AccountArrivalDetail> getArrivalDetail(String contractNum){
		//分组数据
		List<AccountArrivalDetail> arrivalDetail = accountArrivalDao.getArrivalDetail(contractNum);
		//未分组数量
		List<AccountArrivalDetail> arrivalDetailNum = accountArrivalDao.getArrivalDetailNum(contractNum);
		
		for (AccountArrivalDetail ad : arrivalDetail) {
			String materialId = ad.getMaterialId();
			int arrNum = 0;
			for (AccountArrivalDetail adn : arrivalDetailNum) {
				if (materialId.equals(adn.getMaterialId())) {
					arrNum += Integer.parseInt(adn.getArrivalNum());
				}
			}
			ad.setArrivalNum(""+arrNum);
		}
		return arrivalDetail;
	}
}