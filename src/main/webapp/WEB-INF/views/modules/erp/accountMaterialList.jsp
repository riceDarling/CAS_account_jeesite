<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>物资管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountMaterial/">物资列表</a></li>
		<shiro:hasPermission name="erp:accountMaterial:edit"><li><a href="${ctx}/erp/accountMaterial/form">物资添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountMaterial" action="${ctx}/erp/accountMaterial/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>物资名称：</label>
				<form:input path="materialname" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>物资名称</th>
				<th>规格型号</th>
				<th>计量单位</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="erp:accountMaterial:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountMaterial">
			<tr>
				<td><a href="${ctx}/erp/accountMaterial/form?id=${accountMaterial.id}">
					${accountMaterial.materialname}
				</a></td>
				<td>
					${accountMaterial.size}
				</td>
				<td>
					${accountMaterial.unit}
				</td>
				<td>
					<fmt:formatDate value="${accountMaterial.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${accountMaterial.remarks}
				</td>
				<shiro:hasPermission name="erp:accountMaterial:edit"><td>
    				<a href="${ctx}/erp/accountMaterial/form?id=${accountMaterial.id}">修改</a>
					<a href="${ctx}/erp/accountMaterial/delete?id=${accountMaterial.id}" onclick="return confirmx('确认要删除该物资吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>