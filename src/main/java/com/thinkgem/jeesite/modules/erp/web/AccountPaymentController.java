/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.AccountContract;
import com.thinkgem.jeesite.modules.erp.entity.AccountPayment;
import com.thinkgem.jeesite.modules.erp.service.AccountContractService;
import com.thinkgem.jeesite.modules.erp.service.AccountParaInfoService;
import com.thinkgem.jeesite.modules.erp.service.AccountPaymentService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.utils.FormatDateUtils;
import com.thinkgem.jeesite.modules.utils.RandomUtils;

/**
 * 付款单Controller
 * 
 * @author 南鹏杰
 * @version 2017-06-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountPayment")
public class AccountPaymentController extends BaseController {

	@Autowired
	private AccountContractService accountContractService;
	
	@Autowired
	private AccountPaymentService accountPaymentService;
	
	@Autowired
	private AccountParaInfoService accountParaInfoService;

	@ModelAttribute
	public AccountPayment get(@RequestParam(required = false) String id) {
		AccountPayment entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = accountPaymentService.get(id);
		}
		if (entity == null) {
			entity = new AccountPayment();
		}
		return entity;
	}

	//查询付款单列表
	@RequiresPermissions("erp:accountPayment:view")
	@RequestMapping(value = { "list", "" })
	public String list(AccountPayment accountPayment, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountPayment> page = accountPaymentService.findPage(new Page<AccountPayment>(request, response), accountPayment);
		model.addAttribute("page", page);
		List<AccountPayment> accountPayments = accountPaymentService.findList(accountPayment);
		Iterator<AccountPayment> iterator = accountPayments.iterator();
		List<Map<String, Object>> contractList = new ArrayList<>();
		while (iterator.hasNext()) {
			String contractId = iterator.next().getContract();
			String company = accountContractService.get(contractId).getCompany();
			Double money = accountContractService.get(contractId).getMoney();
			String contractTitle = accountContractService.get(contractId).getContracttitle();
			Map<String, Object> map = new HashMap<>();
			map.put("id", contractId);
			map.put("company", company);
			map.put("money", money);
			map.put("contractTitle", contractTitle);
			contractList.add(map);
		}
		model.addAttribute("contractList", contractList);
		return "modules/erp/accountPaymentList";
	}

	//添加合同界面
	@RequiresPermissions("erp:accountPayment:view")
	@RequestMapping(value = "form")
	public String form(AccountPayment accountPayment, Model model) {
		model.addAttribute("accountPayment", accountPayment);
		List<AccountContract> accountContracts = accountContractService.getAllAccountContractInfo();
		model.addAttribute("contracts", accountContracts);
		String json = "{";
			Iterator<AccountContract> iterator = accountContracts.iterator();
			while (iterator.hasNext()) {
				AccountContract accountContract = iterator.next();
				json += accountContract.getId() + ":{company:'" + accountContract.getCompany() + "', money:'" + accountContract.getMoney() +  "'},";
			}
		json += "}";
		model.addAttribute("contractJson", json);
		
		model.addAttribute("payway", accountParaInfoService.getParaInfoList(5));//支付方式
		return "modules/erp/accountPaymentForm";
	}

	@RequiresPermissions("erp:accountPayment:edit")
	@RequestMapping(value = "save")
	public String save(AccountPayment accountPayment, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, accountPayment)) {
			return form(accountPayment, model);
		}
		// 生成17位单据编号 04-20170203-00001
		String ordernum = "23-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
		accountPayment.setOrdernum(ordernum);
		
		// 制单人
		accountPayment.setMaker(UserUtils.getUser().getName());
		
		//发票编号
		String receiptnumRandom = "";
		for (int i = 0; i < 6; ++i) {
			receiptnumRandom += new Random().nextInt(9) + "";
		}
		String receiptnum = "fp-" + FormatDateUtils.dateToString(new Date()) + "-" + receiptnumRandom;
		accountPayment.setReceiptnum(receiptnum);
		accountPaymentService.save(accountPayment);
		accountContractService.updateContractStatus(accountPayment.getContract());
		addMessage(redirectAttributes, "保存付款单成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountPayment/?repage";
	}

	@RequiresPermissions("erp:accountPayment:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountPayment accountPayment, RedirectAttributes redirectAttributes) {
		accountPaymentService.delete(accountPayment);
		accountContractService.updateContractStatustwo(accountPayment.getContract());
		addMessage(redirectAttributes, "删除付款单成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountPayment/?repage";
	}
	
	@ResponseBody
	@RequiresPermissions("erp:accountPayment:edit")
	@RequestMapping(value = "getAlreadyMoney/{contract}")
	public double getAlreadyMoney(@PathVariable("contract") String contract) {
		return accountPaymentService.getAlreadyMoney(contract);
	}

}