<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发票管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountReceipt/">发票列表</a></li>
		<shiro:hasPermission name="erp:accountReceipt:edit"><li><a href="${ctx}/erp/accountReceipt/form">发票添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountReceipt" action="${ctx}/erp/accountReceipt/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>发票号码：</label>
				<form:input path="receiptnum" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>单据编号：</label>
				<form:input path="ordernum" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
			<li><label>开票日期：</label>
				<input name="billingdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${accountReceipt.billingdate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>发票类别：</label>
				<form:input path="category" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!-- <th>单据编号</th> -->
				<th>供应商名称</th>
				<th>开票日期</th>
				<th>物资名称</th>
				<th>规格型号</th>
				<th>含税单价</th>
				<th>不含税单价</th>
				<th>数量</th>
				<th>含税金额</th>
				<th>不含税金额</th>
				<th>制单人</th>
				<!-- <th>到货单号</th> -->
				<shiro:hasPermission name="erp:accountReceipt:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountReceipt">
			<tr>
<%-- 				<td><a href="${ctx}/erp/accountReceipt/form?id=${accountReceipt.id}">
					${accountReceipt.receiptnum}
				</a></td> --%>
				<%-- <td>
					${accountReceipt.ordernum}
				</td> --%>
				<td>
					${accountReceipt.supplier}
				</td>
				<td>
					<fmt:formatDate value="${accountReceipt.billingdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${accountReceipt.materialname}
				</td>
				<td>
					${accountReceipt.size}
				</td>
				<td>
					${accountReceipt.pricefee}
				</td>
				<td>
					${accountReceipt.pricenotfee}
				</td>
				<td>
					${accountReceipt.quantity}
				</td>
				<td>
					${accountReceipt.moneyfee}
				</td>
				<td>
					${accountReceipt.moneynotfee}
				</td>
				<td>
					${accountReceipt.maker}
				</td>
				<%-- <td>
					${accountReceipt.arrivalnum}
				</td> --%>
			
				<shiro:hasPermission name="erp:accountReceipt:edit"><td>
    				<a href="${ctx}/erp/accountReceipt/form?id=${accountReceipt.id}">修改</a>
					<a href="${ctx}/erp/accountReceipt/delete?id=${accountReceipt.id}" onclick="return confirmx('确认要删除该发票吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>