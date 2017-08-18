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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountContract;
import com.thinkgem.jeesite.modules.erp.service.AccountContractService;

/**
 * 合同Controller
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountContract")
public class AccountContractController extends BaseController {

	@Autowired
	private AccountContractService accountContractService;
	
	@ModelAttribute
	public AccountContract get(@RequestParam(required=false) String id) {
		AccountContract entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountContractService.get(id);
		}
		if (entity == null){
			entity = new AccountContract();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountContract:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountContract accountContract, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountContract> page = accountContractService.findPage(new Page<AccountContract>(request, response), accountContract); 
		model.addAttribute("page", page);
		
		
		return "modules/erp/accountContractList";
	}

	@RequiresPermissions("erp:accountContract:view")
	@RequestMapping(value = "form")
	public String form(AccountContract accountContract, Model model) {
		model.addAttribute("accountContract", accountContract);
		return "modules/erp/accountContractForm";
	}
	@RequiresPermissions("erp:accountContract:view")
	@RequestMapping(value = "form2")
	public String form2(AccountContract accountContract, Model model) {
		model.addAttribute("accountContract", accountContract);
		return "modules/erp/accountContractForm2";
	}
	@RequiresPermissions("erp:accountContract:edit")
	@RequestMapping(value = "save")
	public String save(AccountContract accountContract, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountContract)){
			return form(accountContract, model);
		}
		accountContract.setStatus("0");
		accountContractService.save(accountContract);
		addMessage(redirectAttributes, "保存合同成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountContract/?repage";
	}
	
	@RequiresPermissions("erp:accountContract:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountContract accountContract, RedirectAttributes redirectAttributes) {
		accountContractService.delete(accountContract);
		addMessage(redirectAttributes, "删除合同成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountContract/?repage";
	}
	
	@ResponseBody
	@RequiresPermissions("erp:accountContract:view")
	@RequestMapping(value = "getCompanyById/{id}")
	public String getCompanyById(@PathVariable("id") String id) {
		return accountContractService.get(id).getCompany();
	}
	
	@ResponseBody
	@RequiresPermissions("erp:accountContract:view")
	@RequestMapping(value = "getMoneyById/{id}")
	public Double getMoneyById(@PathVariable("id") String id) {
		return accountContractService.get(id).getMoney();
	}

}