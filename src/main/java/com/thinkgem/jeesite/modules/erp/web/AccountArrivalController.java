/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import java.util.List;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrival;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrivalDetail;
import com.thinkgem.jeesite.modules.erp.service.AccountArrivalService;
import com.thinkgem.jeesite.modules.erp.service.AccountContractService;

/**
 * 到货单Controller
 * @author admin
 * @version 2017-07-24
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountArrival")
public class AccountArrivalController extends BaseController {

	@Autowired
	private AccountArrivalService accountArrivalService;
	
	@Autowired
	private AccountContractService accountContractService;
	
	@ModelAttribute
	public AccountArrival get(@RequestParam(required=false) String id) {
		AccountArrival entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountArrivalService.get(id);
		}
		if (entity == null){
			entity = new AccountArrival();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountArrival:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountArrival accountArrival, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountArrival> page = accountArrivalService.findPage(new Page<AccountArrival>(request, response), accountArrival); 
		model.addAttribute("page", page);
		return "modules/erp/accountArrivalListIndex";
	}

	@RequiresPermissions("erp:accountArrival:view")
	@RequestMapping(value = "form")
	public String form(AccountArrival accountArrival, Model model) {
		model.addAttribute("accountArrival", accountArrival);
		return "modules/erp/accountArrivalForm";
	}
	
	@RequiresPermissions("erp:accountArrival:view")
	@RequestMapping(value = "nextForm")
	public String nextForm(AccountArrival accountArrival, Model model) {
		model.addAttribute("nextForm", accountArrivalService.getNextForm(accountArrival.getContractId()));
		model.addAttribute("accountArrival", accountArrival);
		return "modules/erp/accountArrivalNextForm";
	}
	
	@RequiresPermissions("erp:accountArrival:view")
	@RequestMapping(value = "lastForm")
	public String lastForm(AccountArrival accountArrival, Model model) {
		model.addAttribute("lastForm", accountArrivalService.getLastForm(accountArrival));
		return "modules/erp/accountArrivalList";
	}
	
	@RequiresPermissions("erp:accountArrival:view")
	@RequestMapping(value = "editForm")
	public String editForm(AccountArrival accountArrival, Model model) {
		model.addAttribute("accountArrival", accountArrival);
		return "modules/erp/accountArrivalEdit";
	}
	
	@RequiresPermissions("erp:accountArrival:view")
	@RequestMapping(value = "addform")
	@ResponseBody
	public List<AccountArrivalDetail> addform(String contractNum, Model model, RedirectAttributes redirectAttributes) {
		List<AccountArrivalDetail> arrivalDetail = accountArrivalService.getArrivalDetail(contractNum);
		return arrivalDetail;
	}

	@RequiresPermissions("erp:accountArrival:edit")
	@RequestMapping(value = "save")
	public String save(AccountArrival accountArrival, Model model, RedirectAttributes redirectAttributes) {
		accountArrivalService.save(accountArrival);
		addMessage(redirectAttributes, "保存到货单成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountArrival/?repage";
	}
	
	@RequiresPermissions("erp:accountArrival:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountArrival accountArrival, RedirectAttributes redirectAttributes) {
		accountArrivalService.delete(accountArrival);
		addMessage(redirectAttributes, "删除到货单成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountArrival/?repage";
	}

}