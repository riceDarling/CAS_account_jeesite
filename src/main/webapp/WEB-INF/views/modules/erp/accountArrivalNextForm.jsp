<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>到货管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
	//获取采购订货单标题
	$.ajax({
		url:"${ctx}/erp/accountPurchase/getAccountPurchaseList",
		type:"post",
		success:function(data){
			var html;
			for(i in data){
				html+='<option value="'+data[i].purchasenumtitle+'">'+data[i].purchasenumtitle+'</option>';
			}
			$("#purchasenumtitle").html(html);
		   
		}
	});
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
		<li class="active"><a href="${ctx}/erp/accountArrival/nextForm">到货信息列表</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>合同名称</th>
				<th>供应商</th>
				<th>到货日期</th>
				<shiro:hasPermission name="erp:accountArrival:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		
		<c:forEach items="${nextForm}" var="accountArrival">
			<tr>
				<td>${accountArrival.contractTitle}</td>
				<td>${accountArrival.supplier}</td> 
				<td><fmt:formatDate value="${accountArrival.arrivalDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> 
				<shiro:hasPermission name="erp:accountContract:edit"><td>
    				<a href="${ctx}/erp/accountArrival/lastForm?contractId=${accountArrival.contractId}&arrivalDate=<fmt:formatDate value="${accountArrival.arrivalDate}" pattern="yyyy-MM-dd HH:mm:ss"/>">详情</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<form:form>	
	<div class="form-actions">
			<a href="${ctx}/erp/accountArrival"><input class="btn" type="button" value="返回"/></a>
			<input id="btnCancel" class="btn" type="button" value="上一步" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<div class="pagination">${page}</div>
	<div class="pagination">${page}</div>
</body>
</html>