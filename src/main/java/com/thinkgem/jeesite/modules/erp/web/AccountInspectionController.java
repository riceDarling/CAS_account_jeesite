/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrival;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrivalDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountInspection;
import com.thinkgem.jeesite.modules.erp.entity.AccountInspectionDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountInspectionInfo;
import com.thinkgem.jeesite.modules.erp.entity.AccountInspectionDetail;
import com.thinkgem.jeesite.modules.erp.service.AccountInspectionService;

/**
 * 送检单主表Controller
 * @author admin
 * @version 2017-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountInspection")
public class AccountInspectionController extends BaseController {

	@Autowired
	private AccountInspectionService accountInspectionService;
	
	@ModelAttribute
	public AccountInspection get(@RequestParam(required=false) String id) {
		AccountInspection entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountInspectionService.get(id);
		}
		if (entity == null){
			entity = new AccountInspection();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountInspection:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountInspection accountInspection, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountInspection> page = accountInspectionService.findPage(new Page<AccountInspection>(request, response), accountInspection); 
		model.addAttribute("page", page);
		return "modules/erp/accountInspectionIndex";
	}

	@RequiresPermissions("erp:accountInspection:view")
	@RequestMapping(value = "form")
	public String form(AccountInspection accountInspection, Model model) {
		model.addAttribute("accountInspection", accountInspectionService.getInspectionDetailToAdd(accountInspection));
		return "modules/erp/accountInspectionForm";
	}
	
	@RequiresPermissions("erp:accountInspection:view")
	@RequestMapping(value = "formSec")
	public String formSec(AccountInspection accountInspection, Model model) {
		model.addAttribute("arrivalList", accountInspectionService.getArrivalList());
		model.addAttribute("accountInspection", accountInspection);
		return "modules/erp/accountInspectionForm2";
	}
	
	@RequiresPermissions("erp:accountInspection:view")
	@RequestMapping(value = "nextForm")
	public String nextForm(AccountInspection accountInspection, Model model) {
		model.addAttribute("accountInspection", accountInspectionService.getNextInspection(accountInspection));
		return "modules/erp/accountInspectionNextList";
	}

	@RequiresPermissions("erp:accountInspection:edit")
	@RequestMapping(value = "save")
	public String save(@RequestBody AccountInspection accountInspection, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountInspection)){
			return form(accountInspection, model);
		}
		accountInspectionService.save(accountInspection);
		addMessage(redirectAttributes, "保存送检单主表成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountInspection/?repage";
	}
	
	@RequiresPermissions("erp:accountInspection:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountInspection accountInspection, RedirectAttributes redirectAttributes) {
		accountInspectionService.delete(accountInspection);
		addMessage(redirectAttributes, "删除送检单主表成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountInspection/?repage";
	}
	@ResponseBody
	@RequestMapping(value = "updateDetail")
	public Date updateDetail(AccountInspectionDetail accountInspectionDetail) {
		 accountInspectionService.updateDetail(accountInspectionDetail);
		 return new Date();
	}
	
	@RequiresPermissions("erp:accountInspection:view")
	@RequestMapping(value = "getDetailByDate")
	@ResponseBody
	public List<AccountArrival> getDetailByDate(AccountArrival accountArrival, Model model) {
		List<AccountArrival> detailByDateAndContractId = accountInspectionService.getDetailByDateAndContractId(accountArrival);
		model.addAttribute("accountInspectionDetail", detailByDateAndContractId);
		return detailByDateAndContractId;
	}
	@RequestMapping(value = "getAccountInspectionDetailByArrivalnum")
	public String toInputPopWindow(String arrivalnum, RedirectAttributes redirectAttributes, Model model) {
		List<AccountInspectionInfo> accountInspectionDetailPage =accountInspectionService.getAccount_inspectionInfo(arrivalnum);
		addMessage(redirectAttributes, "根据到货单号获取送检单信息成功");
		model.addAttribute("accountInspectionDetailPage", accountInspectionDetailPage);
		return "modules/erp/accountInspectionPopWindow";
	}

}