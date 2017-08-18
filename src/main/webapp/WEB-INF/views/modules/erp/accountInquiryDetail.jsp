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
		<li class="active"><a href="#!">询价记录</a></li>
	</ul>
	
	<sys:message content="${message}"/>
	<table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 75%;" >
		<thead>
			<tr>
				<th>序号</th>
				<th>询价时间</th>
				<th>物资名称</th>
				<th>商标</th>
				<th>供应商名称</th>
				<th>规格型号</th>
				<!-- <th>计量单位</th> -->
				<th>单价</th>
			
				<th>备注</th>
			</tr>
		</thead>
		<tbody id="abcd_xk">
			<c:forEach items="${accountRequisitionDetail }" var="accountInquiryDetail" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>
					<fmt:formatDate value="${accountInquiryDetail.inquiryTime }"/>
				</td>
				<td>${accountInquiryDetail.materialname }</td>
				<td>${accountInquiryDetail.brand }</td>
				<td>${accountInquiryDetail.supplier }</td>
				<td>${accountInquiryDetail.size }</td>
				<%-- <td>
					${fns:getDictLabel(accountInquiryDetail.unit, 'unit', 0)}
				</td> --%>
				<td>${accountInquiryDetail.unitprice }</td>
				
				<td>${accountInquiryDetail.remarks }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
	<a href="${ctx}/erp/accountInquiry/add/${ordernum}" class="btn btn-default" style="margin-left: 10px;">新增</a>
	<a href="${ctx}/erp/accountInquiry/list" class="btn btn-default" style="margin-left: 10px;">返回</a>
	
</body>
</html>