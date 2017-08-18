<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>送检单管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountInspection/">送检单列表</a></li>
		<shiro:hasPermission name="erp:accountInspection:edit"><li><a href="${ctx}/erp/accountInspection/formSec">送检单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountInspection" action="${ctx}/erp/accountInspection/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>合同名称：</label>
				<form:input path="contractTitle" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>送检日期：</label>
				<input name="beginInspectiondate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${accountInspection.beginInspectiondate}" pattern="yyyy-MM-dd "/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',isShowClear:false});"/> - 
				<input name="endInspectiondate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${accountInspection.endInspectiondate}" pattern="yyyy-MM-dd "/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<th>合同</th>
				<th>送检日期</th>
				<!-- <th>状态</th> -->
				<th>备注信息</th>
				<shiro:hasPermission name="erp:accountInspection:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountInspection">
			<tr>
				<td>
					${accountInspection.title}
				</td>
				<td>
					${accountInspection.contractTitle}
				</td>
				<td>
					<fmt:formatDate value="${accountInspection.inspectiondate}" pattern="yyyy-MM-dd "/>
				</td>
				<%-- <c:if test="${accountInspection.status == 0}">
				   <td>未完成</td>
				</c:if>
				<c:if test="${accountInspection.status == 1}">
				   <td>已完成</td>
				</c:if> --%>
				<td>
					${accountInspection.remarks}
				</td>
				<shiro:hasPermission name="erp:accountInspection:edit"><td>
    				<a href="${ctx}/erp/accountInspection/nextForm?contractId=${accountInspection.contractId}&inspectiondate=<fmt:formatDate value="${accountInspection.inspectiondate}" pattern="yyyy-MM-dd "/>">明细</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>