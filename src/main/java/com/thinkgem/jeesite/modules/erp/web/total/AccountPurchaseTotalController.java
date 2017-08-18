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
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntPurchaseTotalComprehensive;
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntPurchaseTotalinvoice;
import com.thinkgem.jeesite.modules.erp.service.AccountPurchaseService;

/**
 * 采购订货单统计Controller
 * 
 * @author Luobo
 * @version 2017-06-25
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountPurchaseTotal")
public class AccountPurchaseTotalController extends BaseController {

	@Autowired
	private AccountPurchaseService accountPurchaseService;


	// 供应商物资采购综合分析表
	// @RequiresPermissions("erp:accountPurchase:view")
	@RequestMapping(value = { "comprehensive", "" })
	public String comprehensive(AccuuntPurchaseTotalComprehensive accuuntPurchaseTotalComprehensive, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccuuntPurchaseTotalComprehensive> page = accountPurchaseService.findTotalComprehensive(new Page<AccuuntPurchaseTotalComprehensive>(request, response), accuuntPurchaseTotalComprehensive);
		model.addAttribute("page", page);
		return "modules/erp/total/accountPurchaseComprehensive";
	}

	// 供应商到货发票统计表
	// @RequiresPermissions("erp:accountPurchase:view")
	@RequestMapping(value = { "invoice", "" })
	public String Invoice(AccuuntPurchaseTotalinvoice accuuntPurchaseTotalinvoice, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccuuntPurchaseTotalinvoice> page = accountPurchaseService.findTotalInvoice(new Page<AccuuntPurchaseTotalinvoice>(request, response), accuuntPurchaseTotalinvoice);
		model.addAttribute("page", page);
		return "modules/erp/total/accountPurchaseInvoice";
	}

}