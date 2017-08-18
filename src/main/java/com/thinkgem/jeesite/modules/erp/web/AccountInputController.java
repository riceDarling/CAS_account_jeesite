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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountInput;
import com.thinkgem.jeesite.modules.erp.entity.AccountInputDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountInputInfo;
import com.thinkgem.jeesite.modules.erp.service.AccountInputDetailService;
import com.thinkgem.jeesite.modules.erp.service.AccountInputService;

/**
 * 入库单Controller
 * 
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountInput")
public class AccountInputController extends BaseController {
	@Autowired
	private AccountInputService accountInputService;
	@Autowired
	private AccountInputDetailService accountInputDetailService;
	@ModelAttribute
	public AccountInput get(@RequestParam(required=false) String id) {
		AccountInput entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountInputService.get(id);
		}
		if (entity == null){
			entity = new AccountInput();
		}
		return entity;
	}
	@RequiresPermissions("erp:accountInput:view")
	@RequestMapping(value = { "list", "" })
	public String list(AccountInput accountInput, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountInput> page = accountInputService.findPage(new Page<AccountInput>(request, response), accountInput);
		model.addAttribute("page", page);
		return "modules/erp/accountInputList";
	}

	@RequiresPermissions("erp:accountInput:view")
	@RequestMapping(value = "form")
	public String form(AccountInput accountInput,HttpServletRequest request, HttpServletResponse response,  Model model) {
		model.addAttribute("accountInput", accountInput);
		List<AccountInputInfo> accountInputInfo =  accountInputService.getAccountInputInfo();
		model.addAttribute("page2", accountInputInfo);
		return "modules/erp/accountInputForm";
	}
	@RequiresPermissions("erp:accountInput:view")
	@RequestMapping(value = "form2")
	public String form2(AccountInput accountInput, Model model) {
		List<AccountInputInfo> accountInputInfo =  accountInputService.getAccountInputListInfoBy(accountInput);
		model.addAttribute("accountInput", accountInput);
		model.addAttribute("page3", accountInputInfo);
		return "modules/erp/accountInputForm2";
	}
	@RequiresPermissions("erp:accountInput:edit")
	@RequestMapping(value = "save")
	public String save(AccountInputInfo accountInputInfo, Model model, RedirectAttributes redirectAttributes) {
		AccountInput accountInput=new AccountInput();
		accountInput.setInputnum(accountInputInfo.getInputnum());
		accountInput.setInspectionnum(accountInputInfo.getInspectionnum());
		accountInput.setRemarks(accountInputInfo.getRemarks());
		accountInput.setInputdate(accountInputInfo.getInputdate());
		if(accountInputService.getAccountInput(accountInputInfo.getInspectionnum())<=0){
			accountInputService.save(accountInput);
		}
		AccountInputDetail accountInputDetail=new AccountInputDetail();
		accountInputDetail.setParent_id(accountInputInfo.getInputnum());
		accountInputDetail.setWarehouse(accountInputInfo.getWarehouse());
		accountInputDetail.setMaterialname(accountInputInfo.getMaterialname());
		accountInputDetail.setLocation(accountInputInfo.getLocation());
		accountInputDetail.setSize(accountInputInfo.getSize());
		accountInputDetail.setQuantity(accountInputInfo.getQuantity());
		accountInputDetail.setRemarks(accountInputInfo.getInputremarks());
		accountInputDetailService.save(accountInputDetail);
		accountInputService.updateStatus(accountInputInfo.getInspectionnum());
		addMessage(redirectAttributes, "保存入库单成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountInput/?repage";
	}

	@RequiresPermissions("erp:accountInput:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountInput accountInput, RedirectAttributes redirectAttributes) {
		accountInputService.delete(accountInput);
		accountInputService.updateInspectionStatus(accountInput.getInspectionnum());
		addMessage(redirectAttributes, "删除入库单成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountInput/?repage";
	}

}