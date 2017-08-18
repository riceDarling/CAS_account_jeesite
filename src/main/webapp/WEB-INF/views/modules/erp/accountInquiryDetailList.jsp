<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>询价单子表管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountInquiryDetail/">询价单子表列表</a></li>
		<shiro:hasPermission name="erp:accountInquiryDetail:edit"><li><a href="${ctx}/erp/accountInquiryDetail/form">询价单子表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountInquiryDetail" action="${ctx}/erp/accountInquiryDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="erp:accountInquiryDetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountInquiryDetail">
			<tr>
				<td><a href="${ctx}/erp/accountInquiryDetail/form?id=${accountInquiryDetail.id}">
					<fmt:formatDate value="${accountInquiryDetail.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${accountInquiryDetail.remarks}
				</td>
				<shiro:hasPermission name="erp:accountInquiryDetail:edit"><td>
    				<a href="${ctx}/erp/accountInquiryDetail/form?id=${accountInquiryDetail.id}">修改</a>
					<a href="${ctx}/erp/accountInquiryDetail/delete?id=${accountInquiryDetail.id}" onclick="return confirmx('确认要删除该询价单子表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>