///**
// * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
// */
//package com.thinkgem.jeesite.modules.erp.web.total;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.shiro.authz.annotation.RequiresPermissions;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.thinkgem.jeesite.common.config.Global;
//import com.thinkgem.jeesite.common.persistence.Page;
//import com.thinkgem.jeesite.common.web.BaseController;
//import com.thinkgem.jeesite.common.utils.StringUtils;
//import com.thinkgem.jeesite.modules.erp.entity.AccountPurchase;
//import com.thinkgem.jeesite.modules.erp.service.AccountPurchaseService;
//
///**
// * 采购对比分析Controller
// * 
// * @author Luobo
// * @version 2017-06-25
// */
//@Controller
//@RequestMapping(value = "${adminPath}/erp/accountPurchaseComparative")
//public class AccountPurchaseComparativeController extends BaseController {
//
//	@Autowired
//	private AccountPurchaseService accountPurchaseService;
//
//	// 供应商物资采购对比分析表
//	// @RequiresPermissions("erp:accountPurchase:view")
//	@RequestMapping(value = { "comparative", "" })
//	public String comprehensive(AccountPurchase accountPurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<AccountPurchase> page = accountPurchaseService.findPage(new Page<AccountPurchase>(request, response), accountPurchase);
//		model.addAttribute("page", page);
//		return "modules/erp/total/accountComparative";
//	}
//
//	// 供应商物资采购对比分析表(供应商)
//	// @RequiresPermissions("erp:accountPurchase:view")
//	@RequestMapping(value = { "comparativeSuppliers", "" })
//	public String comprehensiveSuppliers(AccountPurchase accountPurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<AccountPurchase> page = accountPurchaseService.findPage(new Page<AccountPurchase>(request, response), accountPurchase);
//		model.addAttribute("page", page);
//		return "modules/erp/total/accountComparative_suppliers";
//	}
//
//	// 供应商余额分析表
//	// @RequiresPermissions("erp:accountPurchase:view")
//	@RequestMapping(value = { "balance", "" })
//	public String balance(AccountPurchase accountPurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<AccountPurchase> page = accountPurchaseService.findPage(new Page<AccountPurchase>(request, response), accountPurchase);
//		model.addAttribute("page", page);
//		return "modules/erp/total/accountBalance";
//	}
//
//}