/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.Iterator;
import java.util.List;

import org.apache.shiro.authc.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.entity.AccountPayment;
import com.thinkgem.jeesite.modules.erp.dao.AccountPaymentDao;

/**
 * 付款单Service
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Service
@Transactional(readOnly = true)
public class AccountPaymentService extends CrudService<AccountPaymentDao, AccountPayment> {

	@Autowired
	private AccountPaymentDao dao;
	
	public AccountPayment get(String id) {
		return super.get(id);
	}
	
	public List<AccountPayment> findList(AccountPayment accountPayment) {
		return super.findList(accountPayment);
	}
	
	public Page<AccountPayment> findPage(Page<AccountPayment> page, AccountPayment accountPayment) {
		return super.findPage(page, accountPayment);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountPayment accountPayment) {
		super.save(accountPayment);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountPayment accountPayment) {
		super.delete(accountPayment);
	}
	
	public double getAlreadyMoney(String contract) {
		List<AccountPayment> list = dao.selectPaymentByContract(contract);
		Iterator<AccountPayment> iterator = list.iterator();
		double alreadyMoney = 0;
		while (iterator.hasNext()) {
			alreadyMoney += Double.parseDouble(iterator.next().getPayamount()) ;
		}
		return alreadyMoney;
	}
	
}