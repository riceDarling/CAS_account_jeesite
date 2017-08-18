<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商期初余额录入管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountSupplierInput/">供应商期初余额录入列表</a></li>
		<shiro:hasPermission name="erp:accountSupplierInput:edit"><li><a href="${ctx}/erp/accountSupplierInput/form">供应商期初余额录入添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountSupplierInput" action="${ctx}/erp/accountSupplierInput/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
		<%-- 	<li><label>供应商编号：</label>
				<form:input path="suppliernum" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li> --%>
			<li><label>供应商名称：</label>
				<form:input path="supplier" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!-- <th>供应商编号</th> -->
				<th>供应商名称</th>
				<th>期初日期</th>
				<th>期初余额</th>
				<th>制单人</th>
				<th>更新时间</th>
				<shiro:hasPermission name="erp:accountSupplierInput:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountSupplierInput">
			<tr>
				<%-- <td><a href="${ctx}/erp/accountSupplierInput/form?id=${accountSupplierInput.id}">
					${accountSupplierInput.suppliernum}
				</a></td> --%>
				<td>
					${accountSupplierInput.supplier}
				</td>
				<td>
					<fmt:formatDate value="${accountSupplierInput.begindate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${accountSupplierInput.beginmoney}
				</td>
				<td>
					${accountSupplierInput.maker}
				</td>
				<td>
					<fmt:formatDate value="${accountSupplierInput.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="erp:accountSupplierInput:edit"><td>
    				<a href="${ctx}/erp/accountSupplierInput/form?id=${accountSupplierInput.id}">修改</a>
					<a href="${ctx}/erp/accountSupplierInput/delete?id=${accountSupplierInput.id}" onclick="return confirmx('确认要删除该供应商期初余额录入吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>