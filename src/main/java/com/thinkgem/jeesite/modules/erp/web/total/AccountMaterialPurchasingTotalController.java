/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web.total;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountMaterialPurchaseReturnReason;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountMaterialPurchasingLossAnalysis;
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntMaterialPurchasingModifyQuery;
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntMaterialPurchasingSubsidiaryLedger;
import com.thinkgem.jeesite.modules.erp.service.AccountMaterialPurchasingService;

/**
 * 供应商物资采购合同修改查询统计表 供应商明细账  供应商采购退货原因分析      供应商采购损耗分析 controller
 * 
 * @author Haitao
 * @version 2017-06-26 
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountMaterialPurchasingTotal")
public class AccountMaterialPurchasingTotalController extends BaseController {

	@Autowired
	private AccountMaterialPurchasingService accountMaterialPurchasingService;

	// 供应商物资采购合同修改查询统计表
	// @RequiresPermissions("erp:accountModifyQuery:view")
	@RequestMapping(value = { "ModifyQuery", "" })
	public String modifyQuery(AccuuntMaterialPurchasingModifyQuery accuuntMaterialPurchasingModifyQuery,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccuuntMaterialPurchasingModifyQuery> page = accountMaterialPurchasingService.findTotalModifyQuery(
				new Page<AccuuntMaterialPurchasingModifyQuery>(request, response),
				accuuntMaterialPurchasingModifyQuery);
		model.addAttribute("page", page);
		return "modules/erp/total/accountModifyQuery";
	}

	// 供应商明细账
	// @RequiresPermissions("erp:accountSubsidiaryLedger:view")
	@RequestMapping(value = { "SubsidiaryLedger", "" })
	public String subsidiaryLedger(AccuuntMaterialPurchasingSubsidiaryLedger accuuntMaterialPurchasingSubsidiaryLedger,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccuuntMaterialPurchasingSubsidiaryLedger> page = accountMaterialPurchasingService
				.findTotalSubsidiaryLedger(new Page<AccuuntMaterialPurchasingSubsidiaryLedger>(request, response),
						accuuntMaterialPurchasingSubsidiaryLedger);
		model.addAttribute("page", page);
		return "modules/erp/total/accountSubsidiaryLedger";
	}

	// 供应商采购退货原因分析
	// @RequiresPermissions("erp:accountPurchaseReturnReason:view")
	@RequestMapping(value = { "PurchaseReturnReason", "" })
	public String purchaseReturnReason(AccountMaterialPurchaseReturnReason accountMaterialPurchaseReturnReason,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountMaterialPurchaseReturnReason> page = accountMaterialPurchasingService.findTotalPurchaseReturnReason(
				new Page<AccountMaterialPurchaseReturnReason>(request, response), accountMaterialPurchaseReturnReason);
		model.addAttribute("page", page);
		return "modules/erp/total/accountPurchaseReturnReason";
	}

	// 供应商采购损耗分析其一
	// @RequiresPermissions("erp:accountPurchasingLossAnalysisOne:view")
	@RequestMapping(value = { "PurchasingLossAnalysisOne", "" })
	public String purchasingLossAnalysisOne(AccountMaterialPurchasingLossAnalysis accountMaterialPurchasingLossAnalysis,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountMaterialPurchasingLossAnalysis> page = accountMaterialPurchasingService
				.findTotalPurchasingLossAnalysisOne(new Page<AccountMaterialPurchasingLossAnalysis>(request, response),
						accountMaterialPurchasingLossAnalysis);
		model.addAttribute("page", page);
		return "modules/erp/total/accountPurchasingLossAnalysisOne";
	}

	// 供应商采购损耗分析其二
	// @RequiresPermissions("erp:accountPurchasingLossAnalysisTwo:view")
	@RequestMapping(value = { "PurchasingLossAnalysisTwo", "" })
	public String purchasingLossAnalysisTwo(AccountMaterialPurchasingLossAnalysis accountMaterialPurchasingLossAnalysis,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountMaterialPurchasingLossAnalysis> page = accountMaterialPurchasingService
				.findTotalPurchasingLossAnalysisTwo(new Page<AccountMaterialPurchasingLossAnalysis>(request, response),
						accountMaterialPurchasingLossAnalysis);
		model.addAttribute("page", page);
		return "modules/erp/total/accountPurchasingLossAnalysisTwo";
	}
}