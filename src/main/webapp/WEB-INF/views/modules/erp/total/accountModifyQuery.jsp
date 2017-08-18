<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商物资采购合同修改查询统计表</title>
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
	<form:form id="searchForm" modelAttribute="accuuntMaterialPurchasingModifyQuery" action="${ctx}/erp/accountMaterialPurchasingTotal/ModifyQuery" method="post" class="breadcrumb form-search">
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
				<th>合同编号</th>
				<th>合同名称</th>
				<!-- <th>物资编号</th> -->
				<th>物资名称</th>
				<th>规格型号</th>
				<!-- <th>总批次</th> -->
				<th>总金额（含税）</th>
			<!-- 	<th>制单人</th>
				<th>审核人</th> -->
			</tr>
		</thead>
		<tbody>
		 <c:forEach items="${page.list}" var="accuuntMaterialPurchasingModifyQuery">
			<tr>
				<td>
					${accuuntMaterialPurchasingModifyQuery.contractNum}
				</td>
				<td>
					${accuuntMaterialPurchasingModifyQuery.contracttitle}
				</td>
				<%-- <td>
					${accuuntMaterialPurchasingModifyQuery.materialcode}
				</td> --%>
				<td>
					${accuuntMaterialPurchasingModifyQuery.materialname}
				</td>
				<td>
					${accuuntMaterialPurchasingModifyQuery.size}
				</td>
				<%-- <td>
					${accuuntMaterialPurchasingModifyQuery.totalbatch}
				</td> --%>
				<td>
					${accuuntMaterialPurchasingModifyQuery.totalmoney}
				</td>
				<%-- 	<td>
					${accuuntMaterialPurchasingModifyQuery.maker}
				</td>
				<td>
					${accuuntMaterialPurchasingModifyQuery.checker}
				</td> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>