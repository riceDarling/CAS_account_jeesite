/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erp.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.erp.entity.AccountRequisition;

/**
 * 申请单DAO接口
 * @author admin
 * @version 2017-07-24
 */
@MyBatisDao
public interface AccountRequisitionDao extends CrudDao<AccountRequisition> {
	
}