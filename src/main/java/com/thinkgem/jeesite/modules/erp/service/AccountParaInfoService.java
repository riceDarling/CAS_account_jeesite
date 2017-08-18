/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.modules.erp.dao.AccountParaInfoDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountParaInfo;

/**
 * 参数项Service
 * @author admin
 * @version 2017-08-02
 */
@Service
@Transactional(readOnly = true)
public class AccountParaInfoService  {

	@Autowired
	private AccountParaInfoDao accountParaInfoDao;
	
	@Transactional(readOnly = false)
	public void save(AccountParaInfo accountParaInfo) {
		accountParaInfoDao.insert(accountParaInfo);
	}
	
	public List<Map<String,Object>> getAccountPara(){
		return accountParaInfoDao.getAccountPara();
	}
	
	public List<AccountParaInfo> getParaInfoList(int pId){
		return accountParaInfoDao.getParaInfoList(pId);
	}
}