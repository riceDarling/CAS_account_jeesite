<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商到货发票统计表</title>
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
	<form:form id="searchForm" modelAttribute="accuuntPurchaseTotalinvoice" action="${ctx}/erp/accountPurchaseTotal/invoice" method="post" class="breadcrumb form-search">
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
		<thead>
			<tr>
				<th colspan="2">入库</th>
				<th colspan="2">发票</th>
				<!-- <th colspan="2">期末</th> -->
			</tr>
			<tr>
				<!-- <th>入库单号</th> -->
				<th>数量</th>
				<th>金额</th>
				<th>发票号码</th>
				<!-- <th>数量</th> -->
				<th>金额</th>
				<!-- <th>数量</th>
				<th>金额</th> -->
			</tr>
		</thead>
		<tbody>
		 <c:forEach items="${page.list}" var="totalInvoice">
			<tr>
				<%-- <td>
					${totalInvoice.inputcode}
				</td> --%>
				<td>
					${totalInvoice.inputcount}
				</td>
				<td>
					${totalInvoice.inputmoney}
				</td>
				<td>
					${totalInvoice.receiptcode}
				</td>
				<%-- <td>
					${totalInvoice.receiptcount}
				</td> --%>
				<td>
					${totalInvoice.receiptmoney}
				</td>
				
				<%-- <td>
					${totalInvoice.losscount}
				</td>
				<td>
					${totalInvoice.lossmoney}
				</td> --%>	
			</tr>
		</c:forEach> 
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>