/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erp.entity.AccountInquiry;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisition;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisitionAct;
import com.thinkgem.jeesite.modules.erp.dao.AccountInquiryDao;
import com.thinkgem.jeesite.modules.erp.dao.AccountRequisitionActDao;
import com.thinkgem.jeesite.modules.erp.dao.AccountRequisitionDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisitionDetail;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.utils.FormatDateUtils;
import com.thinkgem.jeesite.modules.utils.RandomUtils;
import com.thinkgem.jeesite.modules.erp.dao.AccountRequisitionDetailDao;

/**
 * 申请单Service
 * 
 * @author admin
 * @version 2017-07-24
 */
@Service
@Transactional(readOnly = true)
public class AccountRequisitionService extends CrudService<AccountRequisitionDao, AccountRequisition> {

	@Autowired
	private AccountRequisitionDetailDao accountRequisitionDetailDao;

	@Autowired
	private AccountRequisitionActDao accountRequisitionActDao;
	
	@Autowired
	private SystemService systemService;

	@Autowired
	private AccountInquiryDao accountInquiryDao;

	public AccountRequisition get(String id) {
		AccountRequisition accountRequisition = super.get(id);
		accountRequisition.setAccountRequisitionDetailList(
				accountRequisitionDetailDao.findList(new AccountRequisitionDetail(accountRequisition)));
		return accountRequisition;
	}

	public List<AccountRequisition> findList(AccountRequisition accountRequisition) {
		return super.findList(accountRequisition);
	}

	public Page<AccountRequisition> findPage(Page<AccountRequisition> page, AccountRequisition accountRequisition) {
		return super.findPage(page, accountRequisition);
	}

	@Transactional(readOnly = false)
	public void save(AccountRequisition accountRequisition) {
		User user = UserUtils.getUser();
		if (accountRequisition.getIsNewRecord()) {
			// 生成17位单据编号 04-20170203-00001
			String ordernum = "04-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
			accountRequisition.setOrdernum(ordernum);
		} else {
			AccountRequisitionAct now_act = new AccountRequisitionAct();
			now_act.setActindex(0);
			
			now_act.setCheckerName(user.getId());
			now_act.setRequisitionId(accountRequisition.getId());
			now_act = accountRequisitionActDao.getbyRequisitionIdAndChecknameAndState(now_act);
			now_act.setState(1);
			now_act.setConclusion(1);
			now_act.setRemarks("重申");
			now_act.setEndTime(new Date());
			accountRequisitionActDao.update(now_act);
		}
		accountRequisition.setOffice(user.getOffice());
		accountRequisition.setProcInsId("start");
		super.save(accountRequisition);
		for (AccountRequisitionDetail accountRequisitionDetail : accountRequisition.getAccountRequisitionDetailList()) {
			if (accountRequisitionDetail.getId() == null) {
				continue;
			}
			if (AccountRequisitionDetail.DEL_FLAG_NORMAL.equals(accountRequisitionDetail.getDelFlag())) {
				accountRequisitionDetail.setParent(accountRequisition);
				if (StringUtils.isBlank(accountRequisitionDetail.getId())) {
					accountRequisitionDetail.setParent(accountRequisition);
					accountRequisitionDetail.preInsert();
					accountRequisitionDetailDao.insert(accountRequisitionDetail);
				} else {
					accountRequisitionDetail.preUpdate();
					accountRequisitionDetailDao.update(accountRequisitionDetail);
				}
			} else {
				accountRequisitionDetailDao.delete(accountRequisitionDetail);
			}
		}
		AccountRequisitionAct act = new AccountRequisitionAct();
		act.setActindex(0);
		act.setRequisitionId(accountRequisition.getId());
	
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
		next_act.setActindex(0);
		next_act.setRequisitionId(accountRequisition.getId());
		next_act.setRequisitionName(user.getId());
		next_act.setStartTime(new Date());
		next_act.setStep(1);
		next_act.setState(0);
		next_act.setCheckerName(accountRequisition.getChecker());	
		accountRequisitionActDao.insert(next_act);
	}

	@Transactional(readOnly = false)
	public void saveAudit(AccountRequisition accountRequisition) {
		AccountRequisitionAct now_act = new AccountRequisitionAct();
		now_act.setActindex(0);
		User user = UserUtils.getUser();
		now_act.setCheckerName(user.getId());
		now_act.setRequisitionId(accountRequisition.getId());
		now_act = accountRequisitionActDao.getbyRequisitionIdAndChecknameAndState(now_act);

		now_act.setState(1);
		now_act.setConclusion("yes".equals(accountRequisition.getConclusion()) || "end".equals(accountRequisition.getConclusion()) ? 1: 0);
		now_act.setRemarks(accountRequisition.getComment());
		now_act.setEndTime(new Date());
		accountRequisitionActDao.update(now_act);
		if ("yes".equals(accountRequisition.getConclusion())) {
			//如果有人进行审核并且通过，修改主表状态为"examine"，表示当前这个任务无法撤回了
			accountRequisition.setProcInsId("examine");
			dao.update(accountRequisition);
			// 如果同意则，进入下一个节点
			AccountRequisitionAct next_act = new AccountRequisitionAct();
			next_act.setActindex(0);
			next_act.setRequisitionId(accountRequisition.getId());
			next_act.setRequisitionName(user.getId());
			next_act.setStartTime(new Date());
			next_act.setStep(now_act.getStep() + 1);
			next_act.setState(0);
			next_act.setCheckerName(accountRequisition.getChecker());		
			accountRequisitionActDao.insert(next_act);
		} else if ("end".equals(accountRequisition.getConclusion())) {
			// 结束标识
			accountRequisition.setProcInsId("end");
			dao.update(accountRequisition);
			// 添加数据到询价单主表
			AccountInquiry entity = new AccountInquiry();

			// 生成17位单据编号 04-20170203-00001
			String ordernum = "13-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();
			// 生成37位入库单号
			String inquirynum = "xj-" + FormatDateUtils.dateToString(new Date()) + "-" + RandomUtils.random();

			entity.setOrdernum(ordernum);
			entity.setInquirynum(inquirynum);
			entity.setRequisition(accountRequisition.getId());
			entity.setStatus("0");
			entity.setDepartment(accountRequisition.getOffice().getName());
			entity.setTitle(accountRequisition.getTitle());
			
			//询价人
			entity.setInquiry(accountRequisition.getInquiry());
			
			//创建人所属公司
			User createUser=systemService.getUser(accountRequisition.getCreateBy().getId());
			String company=createUser.getCompany().getName();
			entity.setCreateDate(new Date());
			entity.setUpdateDate(new Date());
			entity.setCompany(company);
			entity.setValiddate(new Date());
			entity.setMaker(user.getName());
			entity.setDelFlag("0");
			entity.setId(IdGen.uuid());
			accountInquiryDao.insert(entity);
		} else {
			// 返回上一个节点驳回目标人为上一节点（逐级驳回）
			AccountRequisitionAct next_act = new AccountRequisitionAct();
			next_act.setActindex(0);
			next_act.setRequisitionId(accountRequisition.getId());
			next_act.setRequisitionName(user.getId());
			next_act.setStartTime(new Date());
			next_act.setStep(now_act.getStep() - 1);
			next_act.setState(0);
			next_act.setCheckerName(now_act.getRequisitionName());		
			accountRequisitionActDao.insert(next_act);
		}

	}

	@Transactional(readOnly = false)
	public void delete(AccountRequisition accountRequisition) {
		super.delete(accountRequisition);
		accountRequisitionDetailDao.delete(new AccountRequisitionDetail(accountRequisition));
	}

	public List<AccountRequisitionDetail> getAccountRequisitionDetailsByid(String parentid) {
		return accountRequisitionDetailDao.getAccountRequisitionDetailsByid(parentid);
	}

	public AccountRequisition getRequisitionByOrdernum(String ordernum) {
		return dao.selectRequisitionByOrdernum(ordernum);
	}

	public List<AccountRequisitionDetail> getDetailById(String id) {
		return accountRequisitionDetailDao.getAccountRequisitionDetailsByid(id);
	}

	@Transactional(readOnly = false)
	public void actEnd(AccountRequisition accountRequisition) {
		User user = UserUtils.getUser();
		AccountRequisitionAct now_act = new AccountRequisitionAct();
		now_act.setActindex(0);
		
		now_act.setCheckerName(user.getId());
		now_act.setRequisitionId(accountRequisition.getId());
		now_act = accountRequisitionActDao.getbyRequisitionIdAndChecknameAndState(now_act);
		now_act.setState(1);
		now_act.setConclusion(1);
		now_act.setRemarks("删除申请");
		now_act.setEndTime(new Date());
		accountRequisitionActDao.update(now_act);
		
		accountRequisition.setProcInsId("end");
		dao.update(accountRequisition);
	}
	
	@Transactional(readOnly = false)
	public void revoke(AccountRequisition accountRequisition){
		User user = UserUtils.getUser();
		accountRequisition.setProcInsId("start");
		dao.update(accountRequisition);
		//删除当前任务相关的所有流程
		accountRequisitionActDao.deleteByRequisitionId(accountRequisition.getId());
		//创建一个当前任务，并指定办理人为创建者
		AccountRequisitionAct now_act = new AccountRequisitionAct();
		
		now_act.setActindex(0);
		now_act.setRequisitionId(accountRequisition.getId());
		now_act.setCheckerName(user.getId());
		now_act.setRequisitionName(user.getId());
		now_act.setStartTime(new Date());
		now_act.setStep(0);
		now_act.setState(0);
		accountRequisitionActDao.insert(now_act);
	}
}