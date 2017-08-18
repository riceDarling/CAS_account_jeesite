package com.thinkgem.jeesite.modules.erp.web.total;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erp.entity.AccountReject;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalCount;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalCountSuppliers;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalRejectRate;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountRejectTotalRejectRateSuppliers;
import com.thinkgem.jeesite.modules.erp.service.AccountRejectService;
/**
 * 退货单Controller
 * @author 南鹏杰
 * @version 2017-06-25
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/accountRejectTotal")
public class AccountRejectTotalController extends BaseController{

	@Autowired
	private AccountRejectService accountRejectService;
	
	@ModelAttribute
	public AccountReject get(@RequestParam(required=false) String id) {
		AccountReject entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = accountRejectService.get(id);
		}
		if (entity == null){
			entity = new AccountReject();
		}
		return entity;
	}
	
	/**
	 * 供应商退货原因分析
	 * @param accountReject
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = {"rejectTotal", ""})
	public String list(AccountReject accountReject, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountReject> page = accountRejectService.findPage(new Page<AccountReject>(request, response), accountReject); 
		model.addAttribute("page", page);
		return "modules/erp/total/accountRejectTotal";
	}
	
	/**
	 * 供应商退货频率分析
	 * @param accountReject
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = {"rejectRate", ""})
	public String rate(AccountRejectTotalRejectRate accountRejectTotalRejectRate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountRejectTotalRejectRate> page = accountRejectService.rate(new Page<AccountRejectTotalRejectRate>(request, response), accountRejectTotalRejectRate); 
		model.addAttribute("page", page);
		return "modules/erp/total/accountRejectRate";
	}
	
	/**
	 * 供应商退货频率分析(供应商)
	 * @param accountReject
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = {"rejectRateSuppliers", ""})
	public String rateSuppliers(AccountRejectTotalRejectRateSuppliers accountRejectTotalRejectRateSuppliers, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountRejectTotalRejectRateSuppliers> page = accountRejectService.rateSuppliers(new Page<AccountRejectTotalRejectRateSuppliers>(request, response), accountRejectTotalRejectRateSuppliers); 
		model.addAttribute("page", page);
		return "modules/erp/total/accountRejectRate_suppliers";
	}

	/**
	 * 供应商采购退货数量及金额分析
	 * @param accountReject
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = {"rejectCount", ""})
	public String moneyCount(AccountRejectTotalCount accountRejectTotalCount, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountRejectTotalCount> page = accountRejectService.moneyCount(new Page<AccountRejectTotalCount>(request, response), accountRejectTotalCount); 
		model.addAttribute("page", page);
		return "modules/erp/total/accountRejectCount";
	}


	/**
	 * 供应商采购退货数量及金额分析(供应商)
	 * @param accountReject
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("erp:accountReject:view")
	@RequestMapping(value = {"rejectCountSuppliers", ""})
	public String moneyCountSuppliers(AccountRejectTotalCountSuppliers accountRejectTotalCountSuppliers, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountRejectTotalCountSuppliers> page = accountRejectService.moneyCountSuppliers(new Page<AccountRejectTotalCountSuppliers>(request, response), accountRejectTotalCountSuppliers); 
		model.addAttribute("page", page);
		return "modules/erp/total/accountRejectCount_suppliers";
	}

	

}
