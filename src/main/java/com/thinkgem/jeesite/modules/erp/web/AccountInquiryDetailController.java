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
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiryDetail;
import com.thinkgem.jeesite.modules.erp.service.AccountInquiryDetailService;

/**
 * 询价单子表Controller
 * @author yang
 * @version 2017-07-13
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountInquiryDetail")
public class AccountInquiryDetailController extends BaseController {

	@Autowired
	private AccountInquiryDetailService accountInquiryDetailService;
	
	@ModelAttribute
	public AccountInquiryDetail get(@RequestParam(required=false) String id) {
		AccountInquiryDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountInquiryDetailService.get(id);
		}
		if (entity == null){
			entity = new AccountInquiryDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountInquiryDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountInquiryDetail accountInquiryDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountInquiryDetail> page = accountInquiryDetailService.findPage(new Page<AccountInquiryDetail>(request, response), accountInquiryDetail); 
		model.addAttribute("page", page);
		return "modules/erp/accountInquiryDetailList";
	}

	@RequiresPermissions("erp:accountInquiryDetail:view")
	@RequestMapping(value = "form")
	public String form(AccountInquiryDetail accountInquiryDetail, Model model) {
		model.addAttribute("accountInquiryDetail", accountInquiryDetail);
		return "modules/erp/accountInquiryDetailForm";
	}

	@RequiresPermissions("erp:accountInquiryDetail:edit")
	@RequestMapping(value = "save")
	public String save(AccountInquiryDetail accountInquiryDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountInquiryDetail)){
			return form(accountInquiryDetail, model);
		}
		accountInquiryDetailService.save(accountInquiryDetail);
		addMessage(redirectAttributes, "保存询价单子表成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountInquiryDetail/?repage";
	}
	
	@RequiresPermissions("erp:accountInquiryDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountInquiryDetail accountInquiryDetail, RedirectAttributes redirectAttributes) {
		accountInquiryDetailService.delete(accountInquiryDetail);
		addMessage(redirectAttributes, "删除询价单子表成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountInquiryDetail/?repage";
	}

}