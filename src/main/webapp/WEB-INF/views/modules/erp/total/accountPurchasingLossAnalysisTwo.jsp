<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商采购损耗分析其二</title>
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
		<li><a href="${ctx}/erp/accountMaterialPurchasingTotal/PurchasingLossAnalysisOne">供应商采购损耗分析其一</a></li>
		<li class="active"><a href="${ctx}/erp/accountMaterialPurchasingTotal/PurchasingLossAnalysisTwo">供应商采购损耗分析其二</a></li>
	</ul><br/>
	<form:form id="searchForm" modelAttribute="accountMaterialPurchasingLossAnalysis" action="${ctx}/erp/accountMaterialPurchasingTotal/PurchasingLossAnalysisTwo" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>供应商编号：</label>
				<form:input path="suppliercode" htmlEscape="false" maxlength="16" class="input-medium" />
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
			<th>供应商编码</th>
				<th>供应商名称</th>
				<th>退货数量</th>
				<th>退货金额</th>
				<th>采购数量</th>
				<th>采购金额</th>
				<th>数量退货比（百分比）</th>
				<th>金额退货比（百分比）</th>
			</tr>
		</thead>
		<tbody>
		 <c:forEach items="${page.list}" var="accountMaterialPurchasingLossAnalysis">
			<tr>
				<td>
					${accountMaterialPurchasingLossAnalysis.suppliercode}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.supplier}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.rejectnum}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.rejectmoney}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.quantity}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.purchaseAmount}
				</td>
				<td>
					<fmt:formatNumber type="number" value="${100*accountMaterialPurchasingLossAnalysis.count}" pattern="0.00" maxFractionDigits="2"/>
					%
				</td>
				<td>
					<fmt:formatNumber type="number" value="${100*accountMaterialPurchasingLossAnalysis.money}" pattern="0.00" maxFractionDigits="2"/>
					%
				</td>
			</tr>
		</c:forEach> 
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>