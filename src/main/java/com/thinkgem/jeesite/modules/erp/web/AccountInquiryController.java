/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiry;
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiryDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountMaterial;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisition;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisitionDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountSupplier;
import com.thinkgem.jeesite.modules.erp.entity.AccoutInquiryPageBean;
import com.thinkgem.jeesite.modules.erp.service.AccountInquiryDetailService;
import com.thinkgem.jeesite.modules.erp.service.AccountInquiryService;
import com.thinkgem.jeesite.modules.erp.service.AccountMaterialService;
import com.thinkgem.jeesite.modules.erp.service.AccountRequisitionService;
import com.thinkgem.jeesite.modules.erp.service.AccountSupplierService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.utils.FormatDateUtils;
import com.thinkgem.jeesite.modules.utils.RandomUtils;

/**
 * 询价单Controller
 * 
 * @author 宿通
 * @version 2017-06-25
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountInquiry")
public class AccountInquiryController extends BaseController {

	@Autowired
	private AccountInquiryService accountInquiryService;
	
	@Autowired
	private AccountInquiryDetailService accountInquiryDetailService;
	
	@Autowired
	private AccountRequisitionService accountRequisitionService;
	
	@Autowired
	private AccountSupplierService accountSupplierService;
	
	@Autowired
	private AccountMaterialService accountMaterialService;
	

	@ModelAttribute
	public AccountInquiry get(@RequestParam(required = false) String id) {
		AccountInquiry entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = accountInquiryService.get(id);
		}
		if (entity == null) {
			entity = new AccountInquiry();
		}
		return entity;
	}

	//显示询价列表信息
	@RequiresPermissions("erp:accountInquiry:view")
	@RequestMapping(value = { "list", "" })
	public String list(AccountInquiry accountInquiry, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		accountInquiry.setInquiry(user.getId());
		Page<AccountInquiry> accountInquiryPage = accountInquiryService.findPage(new Page<AccountInquiry>(request, response), accountInquiry);
		model.addAttribute("accountInquiryPage", accountInquiryPage);
		return "modules/erp/accountInquiryList";
	}
	

	@RequiresPermissions("erp:accountInquiry:view")
	@RequestMapping(value = "form")
	public String form(AccountInquiry accountInquiry, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<AccountRequisition> accountRequisitions = accountRequisitionService.findList(new AccountRequisition());
		//Page<AccountRequisition> page = accountRequisitionService.findPageNoInquiry(new Page<AccountRequisition>(request, response), new AccountRequisition());
		//model.addAttribute("page", page);
		model.addAttribute("accountRequisitions",accountRequisitions);
		model.addAttribute("accountInquiry", accountInquiry);
		
		Page<AccountInquiry> accountInquiryPage = accountInquiryService.findPage(new Page<AccountInquiry>(request, response), accountInquiry);
		model.addAttribute("accountInquiryPage", accountInquiryPage);
		return "modules/erp/accountInquiryForm";
	}
	@RequiresPermissions("erp:accountInquiry:view")
	@RequestMapping(value = "form2")
	public String form2(AccountInquiry accountInquiry, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("accountInquiry", accountInquiry);
		return "modules/erp/accountInquiryForm2";
	}
	@RequiresPermissions("erp:accountInquiry:edit")
	@RequestMapping(value = "save")
	public String save(@RequestBody AccoutInquiryPageBean accoutInquiryPageBean , Model model, RedirectAttributes redirectAttributes) {
		// 添加 询价明细表
		System.out.println("---------------------"+accoutInquiryPageBean.getList().size());
		for (AccountInquiryDetail accountInquiryDetail : accoutInquiryPageBean.getList()) {
			System.out.println(accountInquiryDetail);
			String ordernum = "23-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
			accountInquiryDetail.setInquirydetailnum(ordernum);
			accountInquiryDetail.setDelFlag("0");
			accountInquiryDetail.setMaker(UserUtils.getUser().getName());
	
			accountInquiryDetailService.save(accountInquiryDetail);
		}
		
		// 添加 询价表
		AccountInquiry accountInquiry=new AccountInquiry();
		accountInquiry.setInquirynum(accoutInquiryPageBean.getList().get(0).getOrdernum());
		accountInquiry.setDelFlag("0");
		accountInquiry.setMaker(UserUtils.getUser().getName());
		accountInquiry.setOrdernum(accoutInquiryPageBean.getList().get(0).getOrdernum());
		accountInquiry.setRequisition(accoutInquiryPageBean.getList().get(0).getRequisition());
		accountInquiry.setValiddate(accoutInquiryPageBean.getList().get(0).getValiddate());
		accountInquiry.setRemarks(accoutInquiryPageBean.getList().get(0).getRemarks());
				
		//执行询价单父表保存
		accountInquiryService.save(accountInquiry);
		model.addAttribute("accountInquiry",accountInquiry);
//		accountInquiry.setMaker(UserUtils.getUser().getName());
//		accountInquiry.setInquirynum(accountInquiry.getOrdernum());
//		accountInquiry.setValiddate(new Date());

		return "redirect:"+ Global.getAdminPath() + "/erp/accountInquiry/form";
	}
	
	@RequestMapping(value =  "getAccountInquiryList")
	public String getAccountInquiryList(AccountInquiry accountInquiry, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountInquiry> accountInquiryPage = accountInquiryService.findPage(new Page<AccountInquiry>(request, response), accountInquiry);
		model.addAttribute("accountInquiryPage", accountInquiryPage);
		return "modules/erp/accountInquiryForm";
	}
	
	//保存询价记录
	@RequiresPermissions("erp:accountInquiry:edit")
	@RequestMapping(value = "saveDetail")
	public String saveDetail(AccountInquiryDetail accountInquiryDetail, Model model, RedirectAttributes redirectAttributes) {
		accountInquiryDetail.setMaker(UserUtils.getUser().getName());

		accountInquiryDetail.setInquirydetailnum(new Date().toString() + accountInquiryDetail.getOrdernum());
		String suppliercode = accountSupplierService.getAccountSupplierByName(accountInquiryDetail.getSupplier()).getSuppliernum();
		accountInquiryDetail.setSuppliercode(suppliercode);
		//String materialName = accountInquiryDetail.getMaterialname();
		//accountInquiryDetail.setMaterialcode(accountMaterialService.getMaterialByName(materialName).getMaterialnum());
		//执行询价单子表保存
		accountInquiryDetailService.save(accountInquiryDetail);
		return "redirect:" + Global.getAdminPath() + "/erp/accountInquiry/?repage";
	}

	@RequiresPermissions("erp:accountInquiry:edit")
	@RequestMapping(value = "delete")
	public String delete(AccountInquiry accountInquiry, RedirectAttributes redirectAttributes) {
		accountInquiryService.delete(accountInquiry);
		addMessage(redirectAttributes, "删除询价单成功");
		return "redirect:" + Global.getAdminPath() + "/erp/accountInquiry/?repage";
	}
		
	//提交询价单
	@RequiresPermissions("erp:accountInquiry:edit")
	@RequestMapping(value = "commit1/{ordernum}")
	public String commit1(@PathVariable("ordernum") String ordernum, AccountInquiry accountInquiry, RedirectAttributes redirectAttributes) {	
		List<AccountInquiryDetail> accountInquiryDetails=accountInquiryDetailService.selectInquiryDetailByOrdernum(ordernum);
		if(accountInquiryDetails.size()>0) {
			accountInquiryService.commit1(ordernum);
			addMessage(redirectAttributes, "询价单提交成功");
		}else {
			addMessage(redirectAttributes, "询价单没有询价记录，提交失败");
		}	
		return "redirect:" + Global.getAdminPath() + "/erp/accountInquiry/?repage";
	}
	
	//查看申请单详情
	@RequiresPermissions("erp:accountInquiry:view")
	@RequestMapping(value = "requisition/{ordernum}")
	public String requisition(@PathVariable("ordernum") String ordernum, HttpServletRequest request, HttpServletResponse response, Model model) {
		AccountRequisition accountRequisition = accountRequisitionService.getRequisitionByOrdernum(ordernum);
		List<AccountRequisitionDetail> details = accountRequisitionService.getDetailById(accountRequisition.getId());
		System.out.println("=========================");
		System.out.println(details.size());
		System.out.println("=========================");
		model.addAttribute("detail", details);
		Iterator<AccountRequisitionDetail> iterator = details.iterator();
		List<String> materialNames = new ArrayList<>();
		while (iterator.hasNext()) {
			AccountRequisitionDetail accountRequisitionDetail = iterator.next();
			String code = accountRequisitionDetail.getMaterialcode();
			//根据物资编码求物资信息
			String name = accountMaterialService.getMaterialByCode(code).getMaterialname();
			materialNames.add(name);
		}
		model.addAttribute("materialNames",materialNames);
		
		return "modules/erp/accountInquiryRequisition";
	}
	
	//询价单记录
	@RequiresPermissions("erp:accountInquiry:view")
	@RequestMapping(value = "detail/{ordernum}")
	public String inquiryDetail(@PathVariable("ordernum") String ordernum, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<AccountInquiryDetail> list = accountInquiryDetailService.selectInquiryDetailByOrdernum(ordernum);
		model.addAttribute("accountRequisitionDetail", list);
		model.addAttribute("ordernum", ordernum);
		return "modules/erp/accountInquiryDetail";
	}
	
	//添加询价单记录
	@RequiresPermissions("erp:accountInquiry:view")
	@RequestMapping(value = "add/{ordernum}")
	public String inquiryDetailAdd(@PathVariable("ordernum") String ordernum, HttpServletRequest request, HttpServletResponse response, Model model) {
		//List<AccountInquiryDetail> list = accountInquiryDetailService.selectInquiryDetailByOrdernum(ordernum);
		//List<AccountSupplier> accountSuppliers = accountSupplierService.findList(new AccountSupplier());
		//model.addAttribute("accountRequisitionDetail", list);
		//model.addAttribute("suppliers", accountSuppliers);
		//List<AccountMaterial> accountMaterials = accountMaterialService.findList(new AccountMaterial());
		//model.addAttribute("accountMaterials", accountMaterials);
		String requisitionId=accountInquiryService.getRequisitionId(ordernum);
	
		List<AccountRequisitionDetail> details = accountRequisitionService.getDetailById(requisitionId);
		
		List<AccountMaterial> materials=new ArrayList<AccountMaterial>();
		for (AccountRequisitionDetail accountRequisitionDetail : details) {
			String code=accountRequisitionDetail.getMaterialcode();
			//根据物资编码求物资信息
			AccountMaterial material = accountMaterialService.getMaterialByCode(code);
			materials.add(material);
		}
			
		model.addAttribute("accountMaterials", materials);
		model.addAttribute("accountSupplier", accountSupplierService.findList(new AccountSupplier()));
		
		model.addAttribute("orderNum", ordernum);
		return "modules/erp/accountInquiryForm2";
	}
	
	@RequestMapping(value ="toInquiryPopWindow")
	public String toInquiryPopWindow(AccountInquiry accountInquiry, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<AccountRequisitionDetail> accountRequisitionDetails = accountRequisitionService.getAccountRequisitionDetailsByid(accountInquiry.getId());
		List<AccountSupplier> accountSuppliers = accountSupplierService.findList(new AccountSupplier());
		model.addAttribute("accountSuppliers", accountSuppliers);
		model.addAttribute("accountRequisitionDetails", accountRequisitionDetails);
		model.addAttribute("accountInquiry", accountInquiry);
		return "modules/erp/accountInquiryPopWindow";
	}
	
}
