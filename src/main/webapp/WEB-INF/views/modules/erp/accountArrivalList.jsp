<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>到货单管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountArrival/lastForm">到货详细信息</a></li>
	</ul>
	<%-- <form:form id="searchForm" modelAttribute="accountArrival" action="${ctx}/erp/accountArrival/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>到货日期：</label>
				<input name="beginArrivalDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${accountArrival.beginArrivalDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endArrivalDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${accountArrival.endArrivalDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form> --%>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>合同名称</th>
				<th>物资名称</th>
				<th>到货日期</th>
				<th>规格型号</th>
				<th>应到数量</th>
				<th>实到数量</th>
				<!-- <th>更新时间</th> -->
				<!-- <th>备注信息</th> -->
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${lastForm}" var="accountArrival">
			<tr>
				<td>
					${accountArrival.contractTitle}
				</td>
				<td>
					${accountArrival.materialName}
				</td>
				<td><%-- <a href="${ctx}/erp/accountArrival/form?id=${accountArrival.id}"> --%>
					<fmt:formatDate value="${accountArrival.arrivalDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<!-- </a> --></td>
				<td>
					${accountArrival.size}
				</td>
				<td>
					${accountArrival.tobeNum}
				</td>
				<td>
					${accountArrival.arrivalNum}
				</td>
				<%-- <td>
					<fmt:formatDate value="${accountArrival.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> --%>
				<%-- <td>
					${accountArrival.remarks}
				</td> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<form:form>	
	<div class="form-actions">
			<a href="${ctx}/erp/accountArrival"><input class="btn" type="button" value="返回"/></a>
			<input id="btnCancel" class="btn" type="button" value="上一步" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<div class="pagination">${page}</div>
</body>
</html>