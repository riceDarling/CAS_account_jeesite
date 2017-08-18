/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import java.util.List;
import java.util.Map;

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
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiry;
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiryDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchase;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchaseDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchaseSupplier;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisition;
import com.thinkgem.jeesite.modules.erp.service.AccountInquiryDetailService;
import com.thinkgem.jeesite.modules.erp.service.AccountInquiryService;
import com.thinkgem.jeesite.modules.erp.service.AccountParaInfoService;
import com.thinkgem.jeesite.modules.erp.service.AccountPurchaseService;
import com.thinkgem.jeesite.modules.erp.service.AccountRequisitionActService;

/**
 * 订货单Controller
 * @author admin
 * @version 2017-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountPurchase")
public class AccountPurchaseController extends BaseController {

	@Autowired
	private AccountPurchaseService accountPurchaseService;
	
	@Autowired
	private AccountInquiryService accountInquiryService;
	
	@Autowired
	private AccountInquiryDetailService accountInquiryDetailService;
	
	@Autowired
	private AccountRequisitionActService accountRequisitionActService;
	
	@Autowired
	private AccountParaInfoService accountParaInfoService;
	
	@ModelAttribute
	public AccountPurchase get(@RequestParam(required=false) String id) {
		AccountPurchase entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountPurchaseService.get(id);
		}
		if (entity == null){
			entity = new AccountPurchase();
		}
		return entity;
	}
	
	@RequiresPermissions("erp:accountPurchase:view")
	@RequestMapping(value = {"list", ""})
	public String list(AccountPurchase accountPurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountPurchase> page = accountPurchaseService.findPage(new Page<AccountPurchase>(request, response), accountPurchase); 
		model.addAttribute("page", page);
		return "modules/erp/accountPurchaseList";
	}

	@RequiresPermissions("erp:accountPurchase:view")
	@RequestMapping(value = "form")
	public String form(AccountPurchase accountPurchase,AccountInquiry accountInquiry, Model model,HttpServletRequest request, HttpServletResponse response) {
		accountInquiry.setStatus("1");
		Page<AccountInquiry> accountInquiryPage = accountInquiryService.findPage(new Page<AccountInquiry>(request, response), accountInquiry);
		
		model.addAttribute("accountInquiryPage", accountInquiryPage);
		if (!(accountPurchase.getIsNewRecord())) {
			accountPurchaseService.setAccountPurchaseDetailListService(accountPurchase);
		}	
		model.addAttribute("accountPurchase", accountPurchase);
		
		model.addAttribute("packway", accountParaInfoService.getParaInfoList(4));//包装方式
		model.addAttribute("transport", accountParaInfoService.getParaInfoList(6));//运输方式
		model.addAttribute("payway", accountParaInfoService.getParaInfoList(5));//支付方式
		return "modules/erp/accountPurchaseForm";
	}
	
	@RequiresPermissions("erp:accountRequisition:view")
	@RequestMapping(value = "formAudit")
	public String formAudit(AccountPurchase accountPurchase, Model model,HttpServletRequest request, HttpServletResponse response) {
		List<AccountPurchaseSupplier> accountPurchaseSuppliers= accountPurchaseService.getbyParentId(accountPurchase.getId());
		accountPurchaseService.setAccountPurchaseDetailListService(accountPurchase);
		model.addAttribute("accountPurchase", accountPurchase);
		model.addAttribute("accountPurchaseSuppliers", accountPurchaseSuppliers);
		
		List<Map<String,Object>> actlist=accountRequisitionActService.getbyRequisitionId(accountPurchase.getId());
		model.addAttribute("actlist",actlist);
		
		//创建人
		String crateById=accountPurchase.getCreateBy().getId();
		//当前节点办理人id
		Map<String,Object> act=actlist.get(actlist.size()-1);
		String checker_name=(String) act.get("checker_name");
		if(checker_name.equals(crateById)) {
			AccountInquiry accountInquiry=new AccountInquiry();
			accountInquiry.setStatus("1");
			Page<AccountInquiry> accountInquiryPage = accountInquiryService.findPage(new Page<AccountInquiry>(request, response), accountInquiry);
			model.addAttribute("accountInquiryPage", accountInquiryPage);
			
			model.addAttribute("packway", accountParaInfoService.getParaInfoList(4));//包装方式
			model.addAttribute("transport", accountParaInfoService.getParaInfoList(6));//运输方式
			model.addAttribute("payway", accountParaInfoService.getParaInfoList(5));//支付方式
			return "modules/erp/accountPurchaseForm";	
		}else {
			return "modules/erp/accountPurchaseAudit";	
		}

	}
	
	@RequiresPermissions("erp:accountPurchase:view")
	@RequestMapping(value = "formView")
	public String formView(AccountPurchase accountPurchase,AccountInquiry accountInquiry, Model model,HttpServletRequest request, HttpServletResponse response) {
		List<AccountPurchaseSupplier> accountPurchaseSuppliers= accountPurchaseService.getbyParentId(accountPurchase.getId());
		accountPurchaseService.setAccountPurchaseDetailListService(accountPurchase);
		model.addAttribute("accountPurchase", accountPurchase);
		model.addAttribute("accountPurchaseSuppliers", accountPurchaseSuppliers);
		
		List<Map<String,Object>> actlist=accountRequisitionActService.getbyRequisitionId(accountPurchase.getId());
		model.addAttribute("actlist",actlist);
		return "modules/erp/accountPurchaseView";
	}

	@RequiresPermissions("erp:accountPurchase:edit")
	@RequestMapping(value = "save")
	public String save(AccountPurchase accountPurchase, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		
		if("no".equals(accountPurchase.getConclusion())) {
			if (!(accountPurchase.getIsNewRecord())){	
				accountPurchaseService.actEnd(accountPurchase);
				addMessage(redirectAttributes, "删除订货单成功");
			}
			
		}else {
			if (!beanValidator(model, accountPurchase)){
				return form(accountPurchase,new AccountInquiry(), model,request,response);
			}
			accountPurchaseService.save(accountPurchase);
			addMessage(redirectAttributes, "保存订货单成功");
		}
		
		return "redirect:"+Global.getAdminPath()+"/erp/accountPurchase/?repage";
	}
	
	@RequiresPermissions("erp:accountPurchase:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(AccountPurchase accountPurchase, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		accountPurchaseService.saveAudit(accountPurchase);
		addMessage(redirectAttributes, "保存订货单成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountPurchase/?repage";
	}
	
	@RequiresPermissions("erp:accountPurchase:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountPurchase accountPurchase, RedirectAttributes redirectAttributes) {
		accountPurchaseService.delete(accountPurchase);
		addMessage(redirectAttributes, "删除订货单成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountPurchase/?repage";
	}
	
	@RequiresPermissions("erp:accountPurchase:view")
	@RequestMapping(value = "accountPurchaseFormWindow")
	public String accountPurchaseFormWindow(String ordernum,Model model) {
		List<AccountInquiryDetail> accountInquiryDetailList= accountInquiryDetailService.selectInquiryDetailByOrdernum(ordernum);
		model.addAttribute("accountInquiryDetailList", accountInquiryDetailList);
		return "modules/erp/accountPurchaseFormWindow";
	}
	@ResponseBody
	@RequestMapping(value = "getAccountPurchaseList")
	public List<AccountPurchase> getAccountPurchaseList(RedirectAttributes redirectAttributes) {
		AccountPurchase accountPurchase = new AccountPurchase();
		List<AccountPurchase> accountPurchases = accountPurchaseService.findList(accountPurchase);
		addMessage(redirectAttributes, "获取采购单列表");
		return accountPurchases;
	}
	@ResponseBody
	@RequestMapping(value = "getAccountPurchaseTitle")
	public List<AccountPurchase> getAccountPurchaseTitle(RedirectAttributes redirectAttributes) {
		List<AccountPurchase> accountPurchases = accountPurchaseService.getAccountPurchaseTitle();
		addMessage(redirectAttributes, "获取采购单标题");
		return accountPurchases;
	}
	@ResponseBody
	@RequestMapping(value = "getAccountSupplierByPurchasenum")
	public List<AccountPurchaseDetail> getAccountSupplierByPurchasenum(AccountPurchaseDetail accountPurchaseDetail,RedirectAttributes redirectAttributes) {
		List<AccountPurchaseDetail> adDetails = accountPurchaseService.getAccountSupplierByPurchasenum(accountPurchaseDetail);
		addMessage(redirectAttributes, "根据物资编码获取详细信息");
		return adDetails;
	}
	@ResponseBody
	@RequestMapping(value = "getAccountSupplierByPurchasenumtitle")
	public Map<String,AccountPurchaseDetail> getAccountSupplierByPurchasenumtitle(String purchasenumtitle,RedirectAttributes redirectAttributes) {
		Map<String,AccountPurchaseDetail> accountPurchaseDetail = accountPurchaseService.getAccountSupplierByPurchasenumtitle(purchasenumtitle);
		addMessage(redirectAttributes, "根据采购标题获取供应商列表信息");
		return accountPurchaseDetail;
	}
	
	@RequiresPermissions("erp:accountRequisition:edit")
	@RequestMapping(value = "revoke")
	public String revoke(AccountPurchase accountPurchase, Model model,RedirectAttributes redirectAttributes) {
		accountPurchaseService.revoke(accountPurchase);
		addMessage(redirectAttributes, "撤销采购单成功");
		return "redirect:"+Global.getAdminPath()+"/erp/accountPurchase/?repage";
	
	}
}