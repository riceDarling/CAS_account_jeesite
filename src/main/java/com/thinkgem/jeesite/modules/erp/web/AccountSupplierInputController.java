/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountSupplierInput;
import com.thinkgem.jeesite.modules.erp.service.AccountSupplierInputService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 供应商期初余额录入Controller
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountSupplierInput")
public class AccountSupplierInputController extends BaseController {

	@Autowired
	private AccountSupplierInputService accountSupplierInputService;
	
	@ModelAttribute
	public AccountSupplierInput get(@RequestParam(required=false) String id) {
		AccountSupplierInput entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountSupplierInputService.get(id);
		}
		if (entity == null){
			entity = new AccountSupplierInput();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountSupplierInput:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountSupplierInput accountSupplierInput, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountSupplierInput> page = accountSupplierInputService.findPage(new Page<AccountSupplierInput>(request, response), accountSupplierInput); 
		model.addAttribute("page", page);
		return "modules/erp/accountSupplierInputList";
	}

	@RequiresPermissions("erp:accountSupplierInput:view")
	@RequestMapping(value = "form")
	public String form(AccountSupplierInput accountSupplierInput, Model model) {
		System.out.println(accountSupplierInput.getSupplier());
		model.addAttribute("accountSupplierInput", accountSupplierInput);
		return "modules/erp/accountSupplierInputForm";
	}

	@RequiresPermissions("erp:accountSupplierInput:edit")
	@RequestMapping(value = "save")
	public String save(AccountSupplierInput accountSupplierInput, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountSupplierInput)){
			return form(accountSupplierInput, model);
		}
		String maker = UserUtils.getUser().getName();
		accountSupplierInput.setMaker(maker);
		
		
		accountSupplierInputService.save(accountSupplierInput);
		addMessage(redirectAttributes, "保存供应商期初余额录入成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountSupplierInput/?repage";
	}
	
	@RequiresPermissions("erp:accountSupplierInput:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountSupplierInput accountSupplierInput, RedirectAttributes redirectAttributes) {
		accountSupplierInputService.delete(accountSupplierInput);
		addMessage(redirectAttributes, "删除供应商期初余额录入成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountSupplierInput/?repage";
	}

}