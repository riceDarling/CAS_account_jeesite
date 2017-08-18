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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountMaterial;
import com.thinkgem.jeesite.modules.erp.service.AccountMaterialService;

/**
 * 物资Controller
 * @author admin
 * @version 2017-07-24
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountMaterial")
public class AccountMaterialController extends BaseController {

	@Autowired
	private AccountMaterialService accountMaterialService;
	
	@ModelAttribute
	public AccountMaterial get(@RequestParam(required=false) String id) {
		AccountMaterial entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountMaterialService.get(id);
		}
		if (entity == null){
			entity = new AccountMaterial();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountMaterial:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountMaterial accountMaterial, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountMaterial> page = accountMaterialService.findPage(new Page<AccountMaterial>(request, response), accountMaterial); 
		model.addAttribute("page", page);
		return "modules/erp/accountMaterialList";
	}

	@RequiresPermissions("erp:accountMaterial:view")
	@RequestMapping(value = "form")
	public String form(AccountMaterial accountMaterial, Model model) {
		model.addAttribute("accountMaterial", accountMaterial);
		return "modules/erp/accountMaterialForm";
	}

	@RequiresPermissions("erp:accountMaterial:edit")
	@RequestMapping(value = "save")
	public String save(AccountMaterial accountMaterial, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountMaterial)){
			return form(accountMaterial, model);
		}
		accountMaterialService.save(accountMaterial);
		addMessage(redirectAttributes, "保存物资成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountMaterial/?repage";
	}
	
	@RequiresPermissions("erp:accountMaterial:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountMaterial accountMaterial, RedirectAttributes redirectAttributes) {
		accountMaterialService.delete(accountMaterial);
		addMessage(redirectAttributes, "删除物资成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountMaterial/?repage";
	}

	

	@ResponseBody
	@RequestMapping(value = "getMaterialByName")
	public AccountMaterial getMaterialByName(String materialname, RedirectAttributes redirectAttributes) {
		AccountMaterial accountMaterial = accountMaterialService.getMaterialByName(materialname);
		addMessage(redirectAttributes, "根据名称获取物资信息成功");
		return accountMaterial;
	}
	
	@ResponseBody
	@RequestMapping(value = "getMaterialBymaterialcode")
	public AccountMaterial getMaterialBymaterialcode(String materialcode, RedirectAttributes redirectAttributes) {
		AccountMaterial accountMaterial = accountMaterialService.getMaterialBymaterialcode(materialcode);
		addMessage(redirectAttributes, "根据物资编号获取物资信息成功");
		return accountMaterial;
	}
	
	@ResponseBody
	@RequestMapping(value = "getMaterialList")
	public List<AccountMaterial> getMaterialList(RedirectAttributes redirectAttributes) {
		AccountMaterial material = new AccountMaterial();
		List<AccountMaterial> materials = accountMaterialService.findList(material);
		addMessage(redirectAttributes, "获取物资列表");
		return materials;
	}
}