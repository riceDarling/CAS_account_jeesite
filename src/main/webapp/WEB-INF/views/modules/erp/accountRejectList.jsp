<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退货单管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountReject/">退货单列表</a></li>
		<shiro:hasPermission name="erp:accountReject:edit"><li><a href="${ctx}/erp/accountReject/form">退货单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountReject" action="${ctx}/erp/accountReject/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>单据编号：</label>
				<form:input path="ordernum" htmlEscape="false" maxlength="17" class="input-medium"/>
			</li>
			<li><label>仓库：</label>
				<form:input path="warehouse" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
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
				<th>单据编号</th>
				<th>仓库</th>
				<th>物资名称</th>
				<th>规格型号</th>
				<th>成分含量</th>
				<th>退货数量</th>
				<th>货位编码</th>
				<th>批次</th>
				<th>供应商名称</th>
				<th>采购订货编号</th>
				<th>到货单号</th>
				<th>制单人</th>
				
				<shiro:hasPermission name="erp:accountReject:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountReject">
			<tr>
				<td><a href="${ctx}/erp/accountReject/form2?id=${accountReject.id}">
					${accountReject.ordernum}</a>
				</td>
				<td>
					${accountReject.warehouse}
				</td>
				<td>
					${accountReject.materialname}
				</td>
				<td>
					${accountReject.size}
				</td>
				<td>
					${accountReject.ingredient}
				</td>
				<td>
					${accountReject.quantity}
				</td>
				<td>
					${accountReject.locationcode}
				</td>
				<td>
					${accountReject.batch}
				</td>
				<td>
					${accountReject.supplier}
				</td>
				<td>
					${accountReject.purchasenum}
				</td>
				<td>
					${accountReject.arrivalnum}
				</td>
				<td>
					${accountReject.maker}
				</td>
				
				<shiro:hasPermission name="erp:accountReject:edit"><td>
    				<a href="${ctx}/erp/accountReject/form2?id=${accountReject.id}">修改</a>
					<a href="${ctx}/erp/accountReject/delete?id=${accountReject.id}" onclick="return confirmx('确认要删除该退货单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>