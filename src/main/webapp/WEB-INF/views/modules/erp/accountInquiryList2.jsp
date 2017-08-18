<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>询价单管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountInquiry/">询价单列表</a></li>
		<shiro:hasPermission name="erp:accountInquiry:edit"><li><a href="${ctx}/erp/accountInquiry/form">询价单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountInquiry" action="${ctx}/erp/accountInquiry/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>单据编号：</label>
				<form:input path="ordernum" htmlEscape="false" maxlength="17" class="input-medium"/>
			</li>
		<%-- 	<li><label>供应商名称：</label>
				<form:select path="supplier" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('supplier')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>物资名称：</label>
				<form:select path="materialname" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('materialname')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>付款方式：</label>
				<form:select path="payway" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('payway')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li> --%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 75%;" >
		<thead>
			<tr>
				<th>询价单号</th> 
				<th>申请单号</th>
				<!-- <th>制单人</th> -->
				<th>价有效期限 </th>
				 <th>操作</th>
			</tr>
		</thead>
		<tbody id="abcd_xk">
			<c:forEach items="${accountInquiryPage.list }" var="accountInquiry"  >
			<tr>
				<td>
					${accountInquiry.id}
				</td>
				<td>
					${accountInquiry.ordernum}
				</td>
				<td>
					<fmt:formatDate value="${accountInquiry.validdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<%-- <td>
					${accountInquiry.supplier }
				</td>
				<td>
					${accountInquiry.materialname }
				</td>
				<td>
					${accountInquiry.size }
				</td>
				<td>
					${accountInquiry.unitprice}
				</td>
				<td>
					${fns:getDictLabel(accountInquiry.payway, 'payway', '')}
				</td> --%>
				<shiro:hasPermission name="erp:accountInquiry:edit"><td>
    				<%-- <a href="${ctx}/erp/accountInquiry/form2?id=${accountInquiry.id}">修改</a> --%>
					<a href="${ctx}/erp/accountInquiry/delete?id=${accountInquiry.id}" onclick="return confirmx('确认要删除该询价单吗？', this.href)">申请单明细</a>
					<a href="${ctx}/erp/accountInquiry/delete?id=${accountInquiry.id}" onclick="return confirmx('确认要删除该询价单吗？', this.href)">询价记录</a>
					<a href="${ctx}/erp/accountInquiry/delete?id=${accountInquiry.id}" onclick="return confirmx('确认要删除该询价单吗？', this.href)">添加询价</a>
				</td></shiro:hasPermission>
				
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>