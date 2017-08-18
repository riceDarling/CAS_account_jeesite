<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商采购损耗分析其一</title>
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
		<li  class="active"><a href="${ctx}/erp/accountMaterialPurchasingTotal/PurchasingLossAnalysisOne">供应商采购损耗分析其一</a></li>
		<li><a href="${ctx}/erp/accountMaterialPurchasingTotal/PurchasingLossAnalysisTwo">供应商采购损耗分析其二</a></li>
	</ul><br/>
	<form:form id="searchForm" modelAttribute="accountMaterialPurchasingLossAnalysis" action="${ctx}/erp/accountMaterialPurchasingTotal/PurchasingLossAnalysisOne" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>物资编码：</label>
				<form:input path="materialcode" htmlEscape="false" maxlength="16" class="input-medium" />
			</li>
			<li><label>物资名称：</label>
				<form:input path="materialname" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>物资型号：</label>
				<form:input path="size" htmlEscape="false" maxlength="16" class="input-medium"/>
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
				<th>损耗数量</th>
				<th>损耗金额</th>
				<th>采购数量</th>
				<th>采购金额</th>
				<th>数量损耗比</th>
				<th>金额损耗比</th>
			</tr>
		</thead>
		<tbody>
		 <c:forEach items="${page.list}" var="accountMaterialPurchasingLossAnalysis">
			<tr>
				<td>
					${accountMaterialPurchasingLossAnalysis.materialcode}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.materialname}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.size}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.loss}
				</td>
				<td>
					${accountMaterialPurchasingLossAnalysis.lossmoney}
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