<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商采购退货原因分析</title>
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
	<form:form id="searchForm" modelAttribute="accountMaterialPurchaseReturnReason" action="${ctx}/erp/accountMaterialPurchasingTotal/PurchaseReturnReason" method="post" class="breadcrumb form-search">
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
				<th>物资编码</th>
				<th>物资名称</th>
				<th>物资型号</th>
				<th>退货数量</th>
				<th>退货金额</th>
				<th>退货批次</th>
				<th>退货原因</th>
				<th>退货原因(数量比重)</th>
				<th>退货原因(金额比重)</th>
				<th>退货原因(次数比重)</th>
			</tr>
		</thead>
		<tbody>
		   <c:forEach items="${page.list}" var="accountMaterialPurchaseReturnReason">
			<tr>
				<td>
					${accountMaterialPurchaseReturnReason.materialcode}
				</td>
				<td>
					${accountMaterialPurchaseReturnReason.materialname}
				</td>
				<td>
					${accountMaterialPurchaseReturnReason.size}
				</td>
				<td>
					${accountMaterialPurchaseReturnReason.quantity}
				</td>
				<td>
					${(accountMaterialPurchaseReturnReason.quantity)*(accountMaterialPurchaseReturnReason.unitPrice)}
				</td>
				<td>
					${accountMaterialPurchaseReturnReason.batch}
				</td>
				<td>
					
				</td>
				<td>
				<fmt:formatNumber type="number" value="${100*(accountMaterialPurchaseReturnReason.quantity/accountMaterialPurchaseReturnReason.purnum)}" pattern="0.00" maxFractionDigits="2"/>
					%
				</td>
				<td>
				<fmt:formatNumber type="number" value="${100*((accountMaterialPurchaseReturnReason.quantity*accountMaterialPurchaseReturnReason.unitPrice)/(accountMaterialPurchaseReturnReason.purnum*accountMaterialPurchaseReturnReason.unitPrice)) }" pattern="0.00" maxFractionDigits="2"/>
					%
				</td>
					<td>
				</td>
			</tr>
		</c:forEach> 
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>