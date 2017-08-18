<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请单管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountRequisition/">申请单列表</a></li>
		<shiro:hasPermission name="erp:accountRequisition:edit"><li><a href="${ctx}/erp/accountRequisition/form">申请单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountRequisition" action="${ctx}/erp/accountRequisition/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>单据编号：</label>
				<form:input path="ordernum" htmlEscape="false" maxlength="17" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>单据编号</th>
				<th>仓库</th>
				<th>需要到货日期</th>
				<th>备注信息</th>
				<shiro:hasPermission name="erp:accountRequisition:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountRequisition">
			<tr>
				<td><a href="${ctx}/erp/accountRequisition/form?id=${accountRequisition.id}">
					${accountRequisition.ordernum}
				</a></td>
				<td>
					${accountRequisition.warehouse}
				</td>
				<td>
					<fmt:formatDate value="${accountRequisition.receivedate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${accountRequisition.remarks}
				</td>
				<shiro:hasPermission name="erp:accountRequisition:edit"><td>
    				<a href="${ctx}/erp/accountRequisition/form?id=${accountRequisition.id}">修改</a>
					<a href="${ctx}/erp/accountRequisition/delete?id=${accountRequisition.id}" onclick="return confirmx('确认要删除该申请单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>