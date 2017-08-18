<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商明细账</title>
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
	<form:form id="searchForm" modelAttribute="accuuntMaterialPurchasingSubsidiaryLedger" action="${ctx}/erp/accountMaterialPurchasingTotal/SubsidiaryLedger" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>供应商编号：</label>
				<form:input path="suppliercode" htmlEscape="false" maxlength="16" class="input-medium"  />
			</li>
			<li><label>供应商名称：</label>
				<form:input path="supplier" htmlEscape="false" maxlength="16" class="input-medium" />
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
		<thead>
			<tr>
				<th colspan="3">发票</th>
				<th colspan="3">付款</th>
				<th rowspan="2">余额</th>
			</tr>
			<tr>
				<th>开票日期</th>
				<th>发票号码</th>
				<th>发票金额</th>
				<th>付款日期</th>
			    <th>付款单据号</th>  
				<th>付款金额</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accuuntMaterialPurchasingSubsidiaryLedger">
			 <tr>
				<td>
				<fmt:formatDate value="${accuuntMaterialPurchasingSubsidiaryLedger.billingdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> 
				<td>
					${accuuntMaterialPurchasingSubsidiaryLedger.receiptnum}
				</td>
				<td>
					${accuuntMaterialPurchasingSubsidiaryLedger.moneyfee}
				</td>
				<td>
				${accuuntMaterialPurchasingSubsidiaryLedger.paydate}
				</td>
				<td>
					${accuuntMaterialPurchasingSubsidiaryLedger.ordernum}
				</td>
				<td>
					${accuuntMaterialPurchasingSubsidiaryLedger.payamount}
				</td>
				<td>
					${accuuntMaterialPurchasingSubsidiaryLedger.balance}
				</td>
			</tr> 
		</c:forEach> 
		</tbody>
	</table>
	<div class="pagination">${page}</div> 
</body>
</html>