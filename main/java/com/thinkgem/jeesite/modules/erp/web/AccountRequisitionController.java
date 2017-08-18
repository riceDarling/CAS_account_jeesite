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
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisition;
import com.thinkgem.jeesite.modules.erp.service.AccountRequisitionService;

/**
 * 申请单Controller
 * @author admin
 * @version 2017-07-24
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountRequisition")
public class AccountRequisitionController extends BaseController {

	@Autowired
	private AccountRequisitionService accountRequisitionService;
	
	@ModelAttribute
	public AccountRequisition get(@RequestParam(required=false) String id) {
		AccountRequisition entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountRequisitionService.get(id);
		}
		if (entity == null){
			entity = new AccountRequisition();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountRequisition:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountRequisition accountRequisition, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountRequisition> page = accountRequisitionService.findPage(new Page<AccountRequisition>(request, response), accountRequisition); 
		model.addAttribute("page", page);
		return "modules/erp/accountRequisitionList";
	}

	@RequiresPermissions("erp:accountRequisition:view")
	@RequestMapping(value = "form")
	public String form(AccountRequisition accountRequisition, Model model) {
		model.addAttribute("accountRequisition", accountRequisition);
		return "modules/erp/accountRequisitionForm";
	}

	@RequiresPermissions("erp:accountRequisition:edit")
	@RequestMapping(value = "save")
	public String save(AccountRequisition accountRequisition, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountRequisition)){
			return form(accountRequisition, model);
		}
		accountRequisitionService.save(accountRequisition);
		addMessage(redirectAttributes, "保存申请单成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountRequisition/?repage";
	}
	
	@RequiresPermissions("erp:accountRequisition:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountRequisition accountRequisition, RedirectAttributes redirectAttributes) {
		accountRequisitionService.delete(accountRequisition);
		addMessage(redirectAttributes, "删除申请单成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountRequisition/?repage";
	}

}