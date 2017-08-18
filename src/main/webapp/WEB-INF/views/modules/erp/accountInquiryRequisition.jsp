<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>询价单管理</title>
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
		<li class="active"><a href="${ctx}/erp/accountInquiry/">申请单明细</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 75%;" >
		<thead>
			<tr>
				<th>序号</th>
				<th>物资名称</th>
				<th>申请数量</th>
			</tr>
		</thead>
		<tbody id="abcd_xk">
			<c:forEach items="${detail }" var="d" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${materialNames[status.index] }</td>
				<td>${d.quantitiy }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
	<a href="${ctx}/erp/accountInquiry/list" class="btn btn-default" style="margin-left: 10px;">返回</a>

	
</body>
</html>