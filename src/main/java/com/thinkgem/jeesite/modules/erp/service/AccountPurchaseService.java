/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiry;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchase;
import com.thinkgem.jeesite.modules.erp.dao.AccountInquiryDao;
import com.thinkgem.jeesite.modules.erp.dao.AccountPurchaseDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchaseDetail;
import com.thinkgem.jeesite.modules.erp.entity.AccountPurchaseSupplier;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisition;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisitionAct;
import com.thinkgem.jeesite.modules.erp.entity.total.AccountSupplierComparative;
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntPurchaseTotalComprehensive;
import com.thinkgem.jeesite.modules.erp.entity.total.AccuuntPurchaseTotalinvoice;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.utils.FormatDateUtils;
import com.thinkgem.jeesite.modules.utils.RandomUtils;
import com.thinkgem.jeesite.modules.erp.dao.AccountPurchaseDetailDao;
import com.thinkgem.jeesite.modules.erp.dao.AccountPurchaseSupplierDao;
import com.thinkgem.jeesite.modules.erp.dao.AccountRequisitionActDao;

/**
 * 订货单Service
 * @author admin
 * @version 2017-07-26
 */
@Service
@Transactional(readOnly = true)
public class AccountPurchaseService extends CrudService<AccountPurchaseDao, AccountPurchase> {

	@Autowired
	private AccountPurchaseDetailDao accountPurchaseDetailDao;
	
	@Autowired
	private AccountPurchaseSupplierDao accountPurchaseSupplierDao;
	
	@Autowired
	private AccountRequisitionActDao accountRequisitionActDao;
	
	@Autowired
	private AccountInquiryDao accountInquiryDao;
	@Autowired
	private AccountPurchaseDao accountPurchaseDao;
	public AccountPurchase get(String id) {
		AccountPurchase accountPurchase = super.get(id);
		//accountPurchase.setAccountPurchaseDetailList(accountPurchaseDetailDao.findList(new AccountPurchaseDetail(accountPurchase)));
		return accountPurchase;
	}
	
	public void setAccountPurchaseDetailListService(AccountPurchase accountPurchase) {
		accountPurchase.setAccountPurchaseDetailList(accountPurchaseDetailDao.findList(new AccountPurchaseDetail(accountPurchase)));
	}
	public List<AccountPurchase> findList(AccountPurchase accountPurchase) {
		return super.findList(accountPurchase);
	}
	
	public Page<AccountPurchase> findPage(Page<AccountPurchase> page, AccountPurchase accountPurchase) {
		return super.findPage(page, accountPurchase);
	}
	
	@Transactional(readOnly = false)
	public void save(AccountPurchase accountPurchase) {
		String inquirynum=accountPurchase.getInquirynum();
		AccountInquiry accountInquiry=new AccountInquiry();
		accountInquiry.setOrdernum(inquirynum);
		accountInquiry.setStatus("2");
		accountInquiryDao.setAccountInquiryStatus(accountInquiry);
		
		if (accountPurchase.getIsNewRecord()) {
			// 生成17位单据编号 04-20170203-00001
			String ordernum = "06-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
			accountPurchase.setOrdernum(ordernum);
		} else {
			AccountRequisitionAct now_act = new AccountRequisitionAct();
			now_act.setActindex(0);
			User user = UserUtils.getUser();
			now_act.setCheckerName(user.getId());
			now_act.setRequisitionId(accountPurchase.getId());
			now_act = accountRequisitionActDao.getbyRequisitionIdAndChecknameAndState(now_act);
			now_act.setState(1);
			now_act.setConclusion(1);
			now_act.setRemarks("重申");
			now_act.setEndTime(new Date());
			accountRequisitionActDao.update(now_act);
		}
		
		User user = UserUtils.getUser();
		accountPurchase.setMaker(user.getId());
		accountPurchase.setProcInsId("start");
		super.save(accountPurchase);
		accountPurchaseDetailDao.deleteByparentId(accountPurchase.getId());
		for (AccountPurchaseDetail accountPurchaseDetail : accountPurchase.getAccountPurchaseDetailList()){
			accountPurchaseDetail.setParent(accountPurchase);
			accountPurchaseDetail.preInsert();
			if(!(accountPurchaseDetail.getReceivedate()!=null)) {
				//由于date类型无法接受（bug），此处用字符串接收转date，存储，页面展示的时候依然用date
				String receivedates=accountPurchaseDetail.getReceivedates();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				Date receivedate=null;
				try {
					receivedate=sdf.parse(receivedates);
				} catch (ParseException e) {
				}
				accountPurchaseDetail.setReceivedate(receivedate);
			}
			
			
			accountPurchaseDetailDao.insert(accountPurchaseDetail);	
		}
		
		accountPurchaseSupplierDao.deleteByparentId(accountPurchase.getId());
		for (AccountPurchaseSupplier accountPurchaseSupplier : accountPurchase.getSupplierList()){
			accountPurchaseSupplier.setParent(accountPurchase);
			
			if(!(accountPurchaseSupplier.getDeadline()!=null)) {
				//由于date类型无法接受（bug），此处用字符串接收转date，存储，页面展示的时候依然用date
				String deadlines=accountPurchaseSupplier.getDeadlines();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				Date deadline=null;
				try {
					deadline=sdf.parse(deadlines);
				} catch (ParseException e) {
				}
				accountPurchaseSupplier.setDeadline(deadline);
			}
			accountPurchaseSupplierDao.insert(accountPurchaseSupplier);
		}
		
		AccountRequisitionAct act = new AccountRequisitionAct();
		act.setActindex(1);
		act.setRequisitionId(accountPurchase.getId());
		act.setRequisitionName(user.getId());
		act.setStartTime(new Date());
		act.setStep(0);
		act.setState(1);
		act.setCheckerName(user.getId());
		accountRequisitionActDao.insert(act);
		
		act.setConclusion(1);
		act.setRemarks("提交申请");
		act.setEndTime(new Date());
		accountRequisitionActDao.update(act);
		
		AccountRequisitionAct next_act = new AccountRequisitionAct();
		next_act.setActindex(1);
		next_act.setRequisitionId(accountPurchase.getId());
		next_act.setRequisitionName(user.getId());
		next_act.setStartTime(new Date());
		next_act.setStep(1);
		next_act.setState(0);
		next_act.setCheckerName(accountPurchase.getChecker());
		accountRequisitionActDao.insert(next_act);
	}
	@Transactional(readOnly = false)
	public void saveAudit(AccountPurchase accountPurchase) {
		AccountRequisitionAct now_act = new AccountRequisitionAct();
		now_act.setActindex(1);
		User user = UserUtils.getUser();
		now_act.setCheckerName(user.getId());
		now_act.setRequisitionId(accountPurchase.getId());
		now_act = accountRequisitionActDao.getbyRequisitionIdAndChecknameAndState(now_act);

		now_act.setState(1);
		now_act.setConclusion("yes".equals(accountPurchase.getConclusion()) || "end".equals(accountPurchase.getConclusion()) ? 1: 0);
		now_act.setRemarks(accountPurchase.getComment());
		now_act.setEndTime(new Date());
		accountRequisitionActDao.update(now_act);
		if ("yes".equals(accountPurchase.getConclusion())) {
			//如果有人进行审核并且通过，修改主表状态为"examine"，表示当前这个任务无法撤回了
			accountPurchase.setProcInsId("examine");
			dao.update(accountPurchase);
			// 如果同意则，进入下一个节点
			AccountRequisitionAct next_act = new AccountRequisitionAct();
			next_act.setActindex(1);
			next_act.setRequisitionId(accountPurchase.getId());
			next_act.setRequisitionName(user.getId());
			next_act.setStartTime(new Date());
			next_act.setStep(now_act.getStep() + 1);
			next_act.setState(0);
			next_act.setCheckerName(accountPurchase.getChecker());
			accountRequisitionActDao.insert(next_act);
		} else if ("end".equals(accountPurchase.getConclusion())) {
			// 结束标识
			accountPurchase.setProcInsId("end");
			dao.update(accountPurchase);
			
		} else {
			// 返回上一个节点驳回目标人为上一节点人
			AccountRequisitionAct next_act = new AccountRequisitionAct();
			next_act.setActindex(1);
			next_act.setRequisitionId(accountPurchase.getId());
			next_act.setRequisitionName(user.getId());
			next_act.setStartTime(new Date());
			next_act.setStep(now_act.getStep() - 1);
			next_act.setState(0);
			next_act.setCheckerName(now_act.getRequisitionName());
			accountRequisitionActDao.insert(next_act);
			
			String inquirynum=accountPurchase.getInquirynum();
			AccountInquiry accountInquiry=new AccountInquiry();
			accountInquiry.setOrdernum(inquirynum);
			accountInquiry.setStatus("1");
			accountInquiryDao.setAccountInquiryStatus(accountInquiry);
		}

	}
	
	
	@Transactional(readOnly = false)
	public void delete(AccountPurchase accountPurchase) {
		super.delete(accountPurchase);
		accountPurchaseDetailDao.delete(new AccountPurchaseDetail(accountPurchase));
	}
	
	public List<AccountPurchaseSupplier> getbyParentId(String parentId){
		return accountPurchaseSupplierDao.getbyParentId(parentId);
	}
	public Page<AccuuntPurchaseTotalinvoice> findTotalInvoice(Page<AccuuntPurchaseTotalinvoice> page, AccuuntPurchaseTotalinvoice accuuntPurchaseTotalinvoice) {
		accuuntPurchaseTotalinvoice.setPage(page);
		page.setList(dao.findTotalInvoice(accuuntPurchaseTotalinvoice));
		return page;
	}

	public Page<AccountSupplierComparative> comparative(Page<AccountSupplierComparative> page,
			AccountSupplierComparative accountSupplierComparative) {
		accountSupplierComparative.setPage(page);
		page.setList(dao.comparative(accountSupplierComparative));
		return page;
	}
	public Page<AccuuntPurchaseTotalComprehensive> findTotalComprehensive(Page<AccuuntPurchaseTotalComprehensive> page, AccuuntPurchaseTotalComprehensive totalComprehensive) {
		totalComprehensive.setPage(page);
		page.setList(dao.findTotalComprehensive(totalComprehensive));
		return page;
	}
	public Page<AccountSupplierComparative> supplierComparative(Page<AccountSupplierComparative> page,
			AccountSupplierComparative accountSupplierComparative) {
		accountSupplierComparative.setPage(page);
		page.setList(dao.supplierComparative(accountSupplierComparative));
		
		return page;
	}
	public List<AccountPurchase> getAccountSupplierListBysupplier(String supplier){
		return dao.getAccountSupplierListBysupplier(supplier);
	}
	
	public List<AccountPurchaseDetail> getAccountSupplierByPurchasenum(AccountPurchaseDetail accountPurchaseDetail){
		return accountPurchaseDetailDao.getAccountSupplierByPurchasenum(accountPurchaseDetail);
	}
	public Map<String,AccountPurchaseDetail> getAccountSupplierByPurchasenumtitle(String purchasenumtitle){
		List<AccountPurchaseDetail> li=accountPurchaseDetailDao.getAccountSupplierByPurchasenumtitle(purchasenumtitle);
		Map<String,AccountPurchaseDetail> map=new HashMap<String,AccountPurchaseDetail>();
		for (AccountPurchaseDetail accountPurchaseDetail : li) {
			accountPurchaseDetail.getSuppliercode();
			if(map.get(accountPurchaseDetail.getSuppliercode())==null){
				map.put(accountPurchaseDetail.getSuppliercode(), accountPurchaseDetail);
			}
			else{
		     Double  money=Double.parseDouble(map.get(accountPurchaseDetail.getSuppliercode()).getTotlemoney().trim()) ;
		     Double money2=Double.parseDouble(accountPurchaseDetail.getTotlemoney().trim()) ;
		     java.text.DecimalFormat   df   =new   java.text.DecimalFormat("#.00");  
		     map.get(accountPurchaseDetail.getSuppliercode()).setTotlemoney(String.valueOf(df.format(money+money2)));
			}
		}
		return map;
	}

	public  List<AccountPurchase> getAccountPurchaseTitle(){
		return accountPurchaseDao.getAccountPurchaseTitle();
	}
	
	@Transactional(readOnly = false)
	public void actEnd(AccountPurchase accountPurchase) {
		User user = UserUtils.getUser();
		AccountRequisitionAct now_act = new AccountRequisitionAct();
		now_act.setActindex(1);
		
		now_act.setCheckerName(user.getId());
		now_act.setRequisitionId(accountPurchase.getId());
		now_act = accountRequisitionActDao.getbyRequisitionIdAndChecknameAndState(now_act);
		now_act.setState(1);
		now_act.setConclusion(1);
		now_act.setRemarks("删除申请");
		now_act.setEndTime(new Date());
		accountRequisitionActDao.update(now_act);
		
		String inquirynum=accountPurchase.getInquirynum();
		AccountInquiry accountInquiry=new AccountInquiry();
		accountInquiry.setOrdernum(inquirynum);
		accountInquiry.setStatus("1");
		accountInquiryDao.setAccountInquiryStatus(accountInquiry);
		
		accountPurchase.setProcInsId("end");
		dao.update(accountPurchase);
	}
	
	@Transactional(readOnly = false)
	public void revoke(AccountPurchase accountPurchase){
		User user = UserUtils.getUser();
		accountPurchase.setProcInsId("start");
		dao.update(accountPurchase);
		//删除当前任务相关的所有流程
		accountRequisitionActDao.deleteByRequisitionId(accountPurchase.getId());
		//创建一个当前任务，并指定办理人为创建者
		AccountRequisitionAct now_act = new AccountRequisitionAct();
		
		now_act.setActindex(1);
		now_act.setRequisitionId(accountPurchase.getId());
		now_act.setCheckerName(user.getId());
		now_act.setRequisitionName(user.getId());
		now_act.setStartTime(new Date());
		now_act.setStep(0);
		now_act.setState(0);
		accountRequisitionActDao.insert(now_act);
		

		String inquirynum=accountPurchase.getInquirynum();
		AccountInquiry accountInquiry=new AccountInquiry();
		accountInquiry.setOrdernum(inquirynum);
		accountInquiry.setStatus("1");
		accountInquiryDao.setAccountInquiryStatus(accountInquiry);
	}
}