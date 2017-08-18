<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入库单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/accountInput/">入库单列表</a></li>
		<shiro:hasPermission name="erp:accountInput:edit"><li><a href="${ctx}/erp/accountInput/form">待入库添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountInput" action="${ctx}/erp/accountInput/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>合同名称：</label>
				<form:input path="contracttitle" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			 <li><label>开始日期：</label><form:input  path="beginDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li><label>结束日期：</label><form:input   path="endDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				 onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
			</li> 
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>合同</th> 
				<th>入库时间</th>
				<th>备注信息</th>
		<shiro:hasPermission name="erp:accountInput:edit"><th>操作</th></shiro:hasPermission> 
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountInput">
			<tr>
				<td>${accountInput.contracttitle}</td>
				<td>
					<fmt:formatDate value="${accountInput.inputdate}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${accountInput.remarks}
				</td>
				<shiro:hasPermission name="erp:accountInput:edit"><td>
    		<a href="${ctx}/erp/accountInput/form2?id=${accountInput.id}&&inputnum=${accountInput.inputnum}&&inspectionnum=${accountInput.inspectionnum}">入库详细</a>
				 <a href="${ctx}/erp/accountInput/delete?id=${accountInput.id}" onclick="return confirmx('确认要删除该入库单吗？', this.href)">入库单删除</a> 
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>