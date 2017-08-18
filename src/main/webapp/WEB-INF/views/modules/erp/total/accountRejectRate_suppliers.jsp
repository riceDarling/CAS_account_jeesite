<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商采购退货频率分析表</title>
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
		<li><a href="${ctx}/erp/accountRejectTotal/rejectRate">物资</a></li>
		<li class="active"><a href="${ctx}/erp/accountRejectTotal/rejectRateSuppliers">供应商</a></li>
	</ul><br/>
	<form:form id="searchForm" modelAttribute="accountRejectTotalRejectRateSuppliers" action="${ctx}/erp/accountRejectTotal/rejectRateSuppliers" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>供应商编号：</label>
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
				<th>供应商编码</th>
				<th>供应商名称</th>
				<th>退货次数</th>
				<th>采购次数</th>
				<th>退货频率（百分比）</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="entity">
			<tr>
				<td>
					${entity.suppliercode}
					<!--<fmt:formatDate value="${accountPurchase.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>-->
				</td>
				<td>
					${entity.supplier}
				</td>
				<td>
					${entity.receiptcount}
				</td>
				<td>
					${entity.purchasecount}
				</td>
				<td>
					<c:if test="${entity.receiptcount == 0}">
						0.0%
					</c:if>
					<c:if test="${entity.receiptcount != 0}">
						${100*(entity.receiptcount/entity.purchasecount)}%
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>