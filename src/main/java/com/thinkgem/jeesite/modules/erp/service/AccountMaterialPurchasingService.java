/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.erp.dao.AccountContractDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountContract;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountMaterialPurchaseReturnReason;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountMaterialPurchasingLossAnalysis;
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntMaterialPurchasingModifyQuery;
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntMaterialPurchasingSubsidiaryLedger;

/**
 * 供应商物资采购合同修改查询统计表  供应商明细账  供应商采购退货原因分析      供应商采购损耗分析  Service
 * @author Haitao
 * @version 2017-06-26
 */
@Service
@Transactional(readOnly = true)
public class AccountMaterialPurchasingService extends CrudService<AccountContractDao, AccountContract> {

	public AccountContract get(String id) {
		return super.get(id);
	}
	
	public List<AccountContract> findList(AccountContract accountContract) {
		return super.findList(accountContract);
	}
	
	public Page<AccountContract> findPage(Page<AccountContract> page, AccountContract accountContract) {
		return super.findPage(page, accountContract);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountContract accountContract) {
		super.save(accountContract);
	}
	
	@Transactional(readOnly = false)
	public void delete(AccountContract accountContract) {
		super.delete(accountContract);
	}
	
	public Page<AccuuntMaterialPurchasingModifyQuery> findTotalModifyQuery(Page<AccuuntMaterialPurchasingModifyQuery> page, AccuuntMaterialPurchasingModifyQuery accuuntMaterialPurchasingModifyQuery) {
		accuuntMaterialPurchasingModifyQuery.setPage(page);
		page.setList(dao.findTotalModifyQuery(accuuntMaterialPurchasingModifyQuery));
		return page;
	}
	
	public Page<AccuuntMaterialPurchasingSubsidiaryLedger> findTotalSubsidiaryLedger(Page<AccuuntMaterialPurchasingSubsidiaryLedger> page, AccuuntMaterialPurchasingSubsidiaryLedger accuuntMaterialPurchasingSubsidiaryLedger) {
		accuuntMaterialPurchasingSubsidiaryLedger.setPage(page);
		page.setList(dao.findTotalSubsidiaryLedger(accuuntMaterialPurchasingSubsidiaryLedger));
		return page;
	}
	
	public Page<AccountMaterialPurchaseReturnReason> findTotalPurchaseReturnReason(Page<AccountMaterialPurchaseReturnReason> page, AccountMaterialPurchaseReturnReason accountMaterialPurchaseReturnReason) {
		accountMaterialPurchaseReturnReason.setPage(page);
		page.setList(dao.findTotalPurchaseReturnReason(accountMaterialPurchaseReturnReason));
		return page;
	}
	public Page<AccountMaterialPurchasingLossAnalysis> findTotalPurchasingLossAnalysisOne(Page<AccountMaterialPurchasingLossAnalysis> page, AccountMaterialPurchasingLossAnalysis accountMaterialPurchasingLossAnalysis) {
		accountMaterialPurchasingLossAnalysis.setPage(page);
		page.setList(dao.findTotalPurchasingLossAnalysisOne(accountMaterialPurchasingLossAnalysis));
		return page;
	}
	public Page<AccountMaterialPurchasingLossAnalysis> findTotalPurchasingLossAnalysisTwo(Page<AccountMaterialPurchasingLossAnalysis> page, AccountMaterialPurchasingLossAnalysis accountMaterialPurchasingLossAnalysis) {
		accountMaterialPurchasingLossAnalysis.setPage(page);
		page.setList(dao.findTotalPurchasingLossAnalysisTwo(accountMaterialPurchasingLossAnalysis));
		return page;
	}
}