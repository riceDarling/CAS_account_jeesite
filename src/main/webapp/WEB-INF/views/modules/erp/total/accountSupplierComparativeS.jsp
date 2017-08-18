<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<html>
<head>
	<title>供应商采购物资对比分析表</title>
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
		<li><a href="${ctx}/erp/accountPurchaseComparative/comparative">物资</a></li>
		<li class="active"><a href="${ctx}/erp/accountPurchaseComparative/supplierComparative">供应商</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="accountSupplierComparative" action="${ctx}/erp/accountPurchaseComparative/supplierComparative" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>物资编码：</label>
				<form:input path="materialcode" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>物资型号：</label>
				<form:input path="size" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>物资名称：</label>
				<form:input path="materialname" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>开始日期：</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				value="${paramMap.beginDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li><label>结束日期：</label><input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				value="${paramMap.endDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead >
			<tr>
				<th rowspan="2">供应商编码</th>
				<th colspan="2">供应商名称</th>
				<th colspan="2">采购数量</th>
				<th colspan="2">采购金额</th>
				<th colspan="2">运输费用</th>
				<th colspan="2">采购总成本</th>
				<th colspan="2">单价</th>
				<th colspan="2">采购金额比重分析</th>
			</tr>
			
		</thead>
		<tbody>
		<c:set var="quantityTotal" value="0"></c:set>
		<c:set var="freightfeeTotal" value="0"></c:set>
		<c:set var="totalmoneyTotal" value="0"></c:set>
		<c:set var="total" value="0"></c:set>
		<c:set var="unitpriceTotal" value="0"></c:set>
		<c:set var="t" value="0"></c:set>
		<c:forEach items="${page.list}" var="comparative">
			<tr>
				<td colspan="2"> 
					<!--<fmt:formatDate value="${accountPurchase.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>-->
					${comparative.suppliercode} 
				</td>
				<td >
					${comparative.supplier} 
				</td>
				<td colspan="2">
					${comparative.quantity} 
					<c:set var="quantityTotal" value="${quantityTotal + comparative.quantity }"></c:set>
				</td>
				<td colspan="2">
					${comparative.totalmoney} 
					<c:set var="totalmoneyTotal" value="${totalmoneyTotal + comparative.totalmoney }"></c:set>
				</td>
				<td colspan="2">
					${comparative.freightfee} 
					<c:set var="freightfeeTotal" value="${freightfeeTotal + comparative.freightfee }"></c:set>
				</td>
				<td colspan="2">
					${comparative.totalmoney+comparative.freightfee} 
					<c:set var="total" value="${total + comparative.freightfee }"></c:set>
				</td>
				<td colspan="2">
					${comparative.unitprice} 
					<c:set var="unitpriceTotal" value="${unitpriceTotal + comparative.unitprice }"></c:set>
				</td>
				<td colspan="2">
					<fmt:formatNumber type="number" value="${comparative.totalmoney/(comparative.totalmoney+comparative.freightfee)}" maxFractionDigits="2"/>
				</td>
				<c:set var="t" value="${t + comparative.totalmoney/(comparative.totalmoney+comparative.freightfee) }"></c:set>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="3">合计</td>
			<td colspan="2">${quantityTotal }</td>
			<td colspan="2">${totalmoneyTotal }</td>
			<td colspan="2">${freightfeeTotal }</td>
			<td colspan="2">${total }</td>
			<td colspan="2">${unitpriceTotal }</td>
			<td colspan="2"><fmt:formatNumber type="number" value="${t }" maxFractionDigits="2"/></td>
		</tr>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>