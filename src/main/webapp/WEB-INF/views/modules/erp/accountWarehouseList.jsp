<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>仓库信息管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountWarehouse/">仓库信息列表</a></li>
		<shiro:hasPermission name="erp:accountWarehouse:edit"><li><a href="${ctx}/erp/accountWarehouse/form">仓库信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountWarehouse" action="${ctx}/erp/accountWarehouse/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<%-- <ul class="ul-form">
			<li><label>仓库名称：</label>
				<form:input path="housename" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul> --%>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>仓库名称</th>
				<th>仓库面积</th>
				<th>仓库地址</th>
				<th>创建时间</th>
				<th>更新者</th>
				<shiro:hasPermission name="erp:accountWarehouse:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountWarehouse">
			<tr>
				<td><a href="${ctx}/erp/accountWarehouse/form?id=${accountWarehouse.id}">
					${accountWarehouse.housename}
				</a></td>
				<td>
					${accountWarehouse.size}
				</td>
				<td>
					${accountWarehouse.address}
				</td>
				<td>
					<fmt:formatDate value="${accountWarehouse.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${accountWarehouse.updateBy.id}
				</td>
				<shiro:hasPermission name="erp:accountWarehouse:edit"><td>
    				<a href="${ctx}/erp/accountWarehouse/form?id=${accountWarehouse.id}">修改</a>
					<a href="${ctx}/erp/accountWarehouse/delete?id=${accountWarehouse.id}" onclick="return confirmx('确认要删除该仓库信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>