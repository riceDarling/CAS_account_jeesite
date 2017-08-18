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
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchase;
import com.thinkgem.jeesite.modules.erp.service.AccountPurchaseService;

/**
 * 采购订货单统计Controller
 * 
 * @author Luobo
 * @version 2017-06-25
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountLossTotal")
public class AccountLossTotalController extends BaseController {

	@Autowired
	private AccountPurchaseService accountPurchaseService;

	// 供应商物资采购损耗分析表
	// @RequiresPermissions("erp:accountPurchase:view")
	@RequestMapping(value = { "loss", "" })
	public String comprehensive(AccountPurchase accountPurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountPurchase> page = accountPurchaseService.findPage(new Page<AccountPurchase>(request, response), accountPurchase);
		model.addAttribute("page", page);
		return "modules/erp/total/accountLoss";
	}

//	// 供应商到货发票统计表
//	// @RequiresPermissions("erp:accountPurchase:view")
//	@RequestMapping(value = { "invoice", "" })
//	public String Invoice(AccountPurchase accountPurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<AccountPurchase> page = accountPurchaseService.findPage(new Page<AccountPurchase>(request, response), accountPurchase);
//		model.addAttribute("page", page);
//		return "modules/erp/total/accountPurchaseInvoice";
//	}

}