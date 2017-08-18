/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchase;
import com.thinkgem.jeesite.modules.erp.entity.AccountReceipt;
import com.thinkgem.jeesite.modules.erp.entity.AccountSupplier;
import com.thinkgem.jeesite.modules.erp.service.AccountReceiptService;
import com.thinkgem.jeesite.modules.erp.service.AccountSupplierService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.utils.FormatDateUtils;
import com.thinkgem.jeesite.modules.utils.RandomUtils;

/**
 * 发票Controller
 * 
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountReceipt")
public class AccountReceiptController extends BaseController {

	@Autowired
	private AccountReceiptService accountReceiptService;
	
	@Autowired
	private AccountSupplierService accountSupplierService;

	@ModelAttribute
	public AccountReceipt get(@RequestParam(required = false) String id) {
		AccountReceipt entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = accountReceiptService.get(id);
		}
		if (entity == null) {
			entity = new AccountReceipt();
		}
		return entity;
	}

	@RequiresPermissions("erp:accountReceipt:view")
	@RequestMapping(value = { "list", "" })
	public String list(AccountReceipt accountReceipt, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountReceipt> page = accountReceiptService.findPage(new Page<AccountReceipt>(request, response), accountReceipt);
		model.addAttribute("page", page);
		return "modules/erp/accountReceiptList";
	}

	@RequiresPermissions("erp:accountReceipt:view")
	@RequestMapping(value = "form")
	public String form(AccountReceipt accountReceipt, Model model) {
		model.addAttribute("accountReceipt", accountReceipt);
		return "modules/erp/accountReceiptForm";
	}

	@RequiresPermissions("erp:accountReceipt:edit")
	@RequestMapping(value = "save")
	public String save(AccountReceipt accountReceipt, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountReceipt)) {
			return form(accountReceipt, model);
		}

		accountReceipt.setReceiptnum(accountReceipt.getOrdernum());
		
		AccountSupplier accountSupplier = accountSupplierService.getAccountSupplierByName(accountReceipt.getSupplier());
		accountReceipt.setSuppliernum(accountSupplier.getSuppliernum());
		accountReceipt.setMaker(UserUtils.getUser().getName());
		accountReceiptService.save(accountReceipt);
		addMessage(redirectAttributes, "保存发票成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountReceipt/?repage";
	}

	@RequiresPermissions("erp:accountReceipt:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountReceipt accountReceipt, RedirectAttributes redirectAttributes) {
		accountReceiptService.delete(accountReceipt);
		addMessage(redirectAttributes, "删除发票成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountReceipt/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "getAccountSupplierByPurchasenum")
	public List<AccountReceipt> getAccountReceiptBysupplier(String supplier,RedirectAttributes redirectAttributes) {
		List<AccountReceipt> accountReceipt = accountReceiptService.getAccountReceiptBySupplier(supplier);
		addMessage(redirectAttributes, "根据供应商名称获取发票列表");
		return accountReceipt;
	}
	
	@ResponseBody
	@RequestMapping(value = "getAccountReceiptBySupplier")
	public List<AccountReceipt> getAccountReceiptBySupplier(String supplier, RedirectAttributes redirectAttributes) {
		addMessage(redirectAttributes, "根据供应商名称获取发票列表");
		return accountReceiptService.getAccountReceiptBySupplier(supplier);
	}
	
}