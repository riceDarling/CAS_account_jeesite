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
		<li class="active"><a href="">送检单列表</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>合同</th>
				<th>送检日期</th>
				<th>商品</th>
				<th>规格型号</th>
				<shiro:hasPermission name="erp:accountInspection:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${accountInspection}" var="accountInspection">
			<tr>
				<td>
					${accountInspection.contractTitle}
				</td>
				<td>
					<fmt:formatDate value="${accountInspection.inspectiondate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${accountInspection.materialname}
				</td>
				<td>
					${accountInspection.size}
				</td>
				<shiro:hasPermission name="erp:accountInspection:edit"><td>
					<c:if test="${accountInspection.status == 0}">
    					<a href="${ctx}/erp/accountInspection/form?inspectionDetailId=${accountInspection.inspectionDetailId}&contractId=${accountInspection.contractId}&inspectiondate=<fmt:formatDate value="${accountInspection.inspectiondate}" pattern="yyyy-MM-dd"/>">填报</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<form:form>	
	<div class="form-actions">
			<a href="${ctx}/erp/accountInspection"><input class="btn" type="button" value="返回"/></a>
			<input id="btnCancel" class="btn" type="button" value="上一步" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>