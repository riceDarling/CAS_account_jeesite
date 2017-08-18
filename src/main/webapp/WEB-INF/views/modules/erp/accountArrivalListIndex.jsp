<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>到货管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
	//获取采购订货单标题
	/* $.ajax({
		url:"${ctx}/erp/accountArrival/getAccountPurchaseList",
		type:"post",
		success:function(data){
			var html;
			for(i in data){
				html+='<option value="'+data[i].purchasenumtitle+'">'+data[i].purchasenumtitle+'</option>';
			}
			$("#purchasenumtitle").html(html);
		   
		}
	}); */
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
		<li class="active"><a href="${ctx}/erp/accountArrival/">到货合同列表</a></li>
		<shiro:hasPermission name="erp:accountInspection:edit"><li><a href="${ctx}/erp/accountArrival/form">到货添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountArrival" action="${ctx}/erp/accountArrival/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>合同名称：</label>
				<form:input path="contractTitle" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</li>
			<li><label>供应商：</label>
				<form:input path="supplier" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</li>
			<li><label>合同状态：</label>
				<form:select path="status" class="input-small required" >
					<form:option value="">请选择</form:option>
					<form:option value="0">未完成</form:option>
					<form:option value="1">已完成</form:option>
				 </form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>合同名称</th>
				<th>供应商</th>
				<th>合同状态</th>
				<shiro:hasPermission name="erp:accountContract:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:set value="${(page.pageNo-1)*page.pageSize}" var="i" scope="page"/> 
		<c:forEach items="${page.list}" var="accountContract" varStatus="status">
		<c:set value="${pageScope.i + 1}" var="i" scope="page"/> 
			<tr>
			    <%-- <td>
					${accountContract.purchasenum}
				</td>
				<td>
				<a href="${ctx}/erp/accountContract/form2?id=${accountContract.id}">
					${accountContract.contractnum}
				</a></td> --%>
				<td>${pageScope.i}</td>
				<td>${accountContract.contractTitle }</td>
				<td>${accountContract.supplier }</td> 
				<c:if test="${accountContract.status == 0}">
				   <td>未完成</td>
				</c:if>
				<c:if test="${accountContract.status == 1}">
				   <td>已完成</td>
				</c:if>
				<shiro:hasPermission name="erp:accountContract:edit"><td>
    				<a href="${ctx}/erp/accountArrival/nextForm?contractId=${accountContract.contractId}">到货列表</a>
					<%-- <a href="${ctx}/erp/accountArrival/form">到货添加</a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>