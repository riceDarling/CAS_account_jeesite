package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.erp.dao.AccountRequisitionActDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchase;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisitionAct;

@Service
@Transactional(readOnly = true)
public class AccountRequisitionActService {
	
	@Autowired
	private	AccountRequisitionActDao dao;

	
	void insert(AccountRequisitionAct entity) {
		dao.insert(entity);
	};
	
	void update(AccountRequisitionAct entity) {
		dao.update(entity);
	};
	
	public List<Map<String,Object>> getbyRequisitionId(String requisitionId){
		return dao.getbyRequisitionId(requisitionId);
	};
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param entity
	 * @return
	 */
	public Page<Map<String,Object>> findPage(Page<Map<String,Object>> page, AccountRequisitionAct entity) {
		entity.setPage(page);
		page.setList(dao.findList(entity));
		return page;
	}
	
}
