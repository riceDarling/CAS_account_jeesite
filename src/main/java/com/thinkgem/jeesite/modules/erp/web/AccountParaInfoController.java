/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;


import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.AccountParaInfo;
import com.thinkgem.jeesite.modules.erp.service.AccountParaInfoService;

/**
 * 参数项Controller
 * 
 * @author admin
 * @version 2017-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountParaInfo")
public class AccountParaInfoController extends BaseController {

	@Autowired
	private AccountParaInfoService accountParaInfoService;

	@RequestMapping(value = "form")
	public String form(AccountParaInfo accountParaInfo, Model model) {
		return "modules/erp/accountParaInfoForm";
	}

	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AccountParaInfo accountParaInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountParaInfo)) {
			return form(accountParaInfo, model);
		}
		accountParaInfoService.save(accountParaInfo);
		return "保存参数项成功";
	}
	
	@ResponseBody
	@RequestMapping(value = "getAccountPara")
	public List<Map<String,Object>> getAccountPara() {
		return accountParaInfoService.getAccountPara();
	}
	
	@ResponseBody
	@RequestMapping(value = "getParaInfoList")
	public List<AccountParaInfo> getParaInfoList(int pId) {
		return accountParaInfoService.getParaInfoList(pId);
	}


}