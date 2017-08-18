<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商物资采购综合分析表</title>
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
	<form:form id="searchForm" modelAttribute="AccountSupplierTotalBalance" action="${ctx}/erp/accountPurchaseTotal/comprehensive" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>供应商编码：</label>
				<form:input path="suppliercode" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>供应商名称：</label>
				<form:input path="supplier" htmlEscape="false" maxlength="16" class="input-medium"/>
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
				<th colspan="2" style="width: 100px;">供应商编码</th>
				<th colspan="2" style="width: 100px;">供应商名称</th>
				<th colspan="2" style="width: 100px;">期初金额</th>
				<th colspan="2" style="width: 100px;">付款金额</th>
				<th colspan="2" style="width: 100px;">发票金额</th>
				<th colspan="2" style="width: 100px;">余额</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${page.list}" var="balance">
			<tr>
				<td colspan="2">
					${balance.suppliernum} 
				</td>
				<td colspan="2">
					${balance.supplier} 
				</td>
				<td colspan="2">
					${balance.beginmoney} 
				</td>
				<td colspan="2">
					${balance.payamount} 
				</td>
				<td colspan="2">
					${balance.moneyfee} 
				</td>
				<td colspan="2">
					${balance.beginmoney + balance.moneyfee - balance.payamount} 
				</td>
				
			</tr>
		</c:forEach>
		
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>