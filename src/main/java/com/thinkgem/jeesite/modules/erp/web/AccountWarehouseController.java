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
import com.thinkgem.jeesite.modules.erp.entity.AccountWarehouse;
import com.thinkgem.jeesite.modules.erp.service.AccountWarehouseService;

/**
 * 仓库信息Controller
 * @author 宿通
 * @version 2017-06-27
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountWarehouse")
public class AccountWarehouseController extends BaseController {

	@Autowired
	private AccountWarehouseService accountWarehouseService;
	
	@ModelAttribute
	public AccountWarehouse get(@RequestParam(required=false) String id) {
		AccountWarehouse entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountWarehouseService.get(id);
		}
		if (entity == null){
			entity = new AccountWarehouse();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountWarehouse:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountWarehouse accountWarehouse, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountWarehouse> page = accountWarehouseService.findPage(new Page<AccountWarehouse>(request, response), accountWarehouse); 
		model.addAttribute("page", page);
		return "modules/erp/accountWarehouseList";
	}

	@RequiresPermissions("erp:accountWarehouse:view")
	@RequestMapping(value = "form")
	public String form(AccountWarehouse accountWarehouse, Model model) {
		model.addAttribute("accountWarehouse", accountWarehouse);
		return "modules/erp/accountWarehouseForm";
	}

	@RequiresPermissions("erp:accountWarehouse:edit")
	@RequestMapping(value = "save")
	public String save(AccountWarehouse accountWarehouse, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountWarehouse)){
			return form(accountWarehouse, model);
		}
		accountWarehouseService.save(accountWarehouse);
		addMessage(redirectAttributes, "保存仓库信息成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountWarehouse/?repage";
	}
	
	@RequiresPermissions("erp:accountWarehouse:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountWarehouse accountWarehouse, RedirectAttributes redirectAttributes) {
		accountWarehouseService.delete(accountWarehouse);
		addMessage(redirectAttributes, "删除仓库信息成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountWarehouse/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "getWarehouselList")
	public List<AccountWarehouse> getWarehouseList(RedirectAttributes redirectAttributes) {
		AccountWarehouse warehouse = new AccountWarehouse();
		List<AccountWarehouse> warehouses = accountWarehouseService.findList(warehouse);
		addMessage(redirectAttributes, "获取仓库列表");
		return warehouses;
	}
	@ResponseBody
	@RequestMapping(value = "getAllWarehouse")
	public List<AccountWarehouse> getAllWarehouse(String housename) {
		List<AccountWarehouse> locations = accountWarehouseService.getAllWarehouse(housename);
		return locations;
	}
}