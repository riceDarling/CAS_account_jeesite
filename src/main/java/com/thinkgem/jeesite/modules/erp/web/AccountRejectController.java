/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import java.util.ArrayList;
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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.AccountArrival;
import com.thinkgem.jeesite.modules.erp.entity.AccountReject;
import com.thinkgem.jeesite.modules.erp.service.AccountArrivalService;
import com.thinkgem.jeesite.modules.erp.service.AccountRejectService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 退货单Controller
 * 
 * @author 南鹏杰
 * @version 2017-06-25
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountReject")
public class AccountRejectController extends BaseController {
	@Autowired
	private AccountArrivalService accountArrivalService;
	@Autowired
	private AccountRejectService accountRejectService;

	@ModelAttribute
	public AccountReject get(@RequestParam(required = false) String id) {
		AccountReject entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = accountRejectService.get(id);
		}
		if (entity == null) {
			entity = new AccountReject();
		}
		return entity;
	}

	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = { "list", "" })
	public String list(AccountReject accountReject, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountReject> page = accountRejectService.findPage(new Page<AccountReject>(request, response), accountReject);
		model.addAttribute("page", page);
		return "modules/erp/accountRejectList";
	}
	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = "form")
	public String form(AccountReject accountReject,AccountArrival accountArrival,HttpServletRequest request, HttpServletResponse response,  Model model) {
		model.addAttribute("accountReject", accountReject);
		Page<AccountArrival> page = accountArrivalService.findPage(new Page<AccountArrival>(request, response), accountArrival);
		model.addAttribute("page2", page);
		return "modules/erp/accountRejectForm";
	}
	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = "form2")
	public String form(AccountReject accountReject, Model model) {
		model.addAttribute("accountReject", accountReject);
		return "modules/erp/accountRejectForm2";
	}

	@RequiresPermissions("erp:accountReject:edit")
	@RequestMapping(value = "save")
	public String save(AccountReject accountReject, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountReject)) {
			return form(accountReject, model);
		}
		// 生成17位单据编号 04-20170203-00001
/*		String ordernum = "22-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
		accountReject.setOrdernum(ordernum);
*/
		//制单人
		accountReject.setMaker(UserUtils.getUser().getName());
		
		accountRejectService.save(accountReject);
		addMessage(redirectAttributes, "保存退货单成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountReject/?repage";
	}

	@RequiresPermissions("erp:accountReject:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountReject accountReject, RedirectAttributes redirectAttributes) {
		accountRejectService.delete(accountReject);
		addMessage(redirectAttributes, "删除退货单成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountReject/?repage";
	}
	@RequestMapping(value = "getAccountArrivalById")
	public String toInputPopWindow(String id, RedirectAttributes redirectAttributes, Model model) {
		AccountArrival accountArrival = accountArrivalService.get(id);
		List<Object> list=new ArrayList<Object>();
		list.add(accountArrival);
		addMessage(redirectAttributes, "根据id获取到货单信息成功");
		model.addAttribute("accountArrival", list);
		return "modules/erp/accountRejectPopWindow";
	}
}