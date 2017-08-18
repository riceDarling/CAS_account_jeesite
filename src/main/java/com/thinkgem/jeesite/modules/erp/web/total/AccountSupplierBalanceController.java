/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web.total;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountSupplierComparative;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountSupplierTotalBalance;
import com.thinkgem.jeesite.modules.erp.service.AccountPurchaseService;
import com.thinkgem.jeesite.modules.erp.service.AccountSupplierInputService;

/**
 * 供应商余额统计   供应商采购物资对比分析Controller
 * @author npj
 * @version 2017-06-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountPurchaseComparative")
public class AccountSupplierBalanceController extends BaseController {

	@Autowired
	private AccountSupplierInputService accountSupplierInputService;
	
	@Autowired
	private AccountPurchaseService accountPurchaseService;


	// 供应商余额统计
	@RequestMapping(value = { "balance", "" })
	public String balance(AccountSupplierTotalBalance accountSupplierTotalBalance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountSupplierTotalBalance> page = accountSupplierInputService.balance(new Page<AccountSupplierTotalBalance>(request,response), accountSupplierTotalBalance);
		model.addAttribute("page", page);
		return "modules/erp/total/accountSupplierTotalBalance";
	}
	
	/**
	 * 供应商采购物资对比分析
	 * 物资tab
	 * @return
	 */
	@RequestMapping(value="comparative")
	public String comparative(@ModelAttribute("accountSupplierComparative") AccountSupplierComparative accountSupplierComparative, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<AccountSupplierComparative> page = accountPurchaseService.comparative(new Page<AccountSupplierComparative>(request,response), accountSupplierComparative);
		model.addAttribute("page", page);
		return "modules/erp/total/accountSupplierComparative";
	}
	
	/**
	 * 供应商采购物资对比分析
	 * 供应商tab
	 * @return
	 */
	@RequestMapping(value="supplierComparative")
	public String supplierComparative(@ModelAttribute("accountSupplierComparative") AccountSupplierComparative accountSupplierComparative, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<AccountSupplierComparative> page = accountPurchaseService.supplierComparative(new Page<AccountSupplierComparative>(request,response), accountSupplierComparative);
		model.addAttribute("page", page);
		return "modules/erp/total/accountSupplierComparativeS";
	}
	
}
