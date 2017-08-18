<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>付款单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("input[name='img']").click(function(){
	           var id=$(this).attr("id").substring(1);//获取图片的id;
	          window.open(id,"","toolbar=no,scrollbars=no,menubar=no");//打开一个新的窗口，在新的窗口显示图片的本来大小
	          });
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
		<li class="active"><a href="${ctx}/erp/accountPayment/">付款单列表</a></li>
		<shiro:hasPermission name="erp:accountPayment:edit"><li><a href="${ctx}/erp/accountPayment/form">付款单添加</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="accountPayment" action="${ctx}/erp/accountPayment/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
		<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
			<li><label>发票号：</label>
				<form:input path="receiptnum" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>标题</th>
				<th>合同名称</th>
				<!-- <th>公司名称</th> -->
				<th>应付金额</th>
				<th>实付金额</th>
				<th>付款方式</th>
				<th>付款期限</th>
				<th>发票号</th>
				<th>发票</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountPayment" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>
					${accountPayment.title}
				</td>
				<td>
					${contractList[status.index].contractTitle }
				</td>
				<%-- <td>
					${contractList[status.index].company }
				</td> --%>
				<td>
					${contractList[status.index].money }
				</td>
				<td>
					${accountPayment.payamount}
				</td>
				<td>
					${accountPayment.payways}
				</td>
				<td>
					${accountPayment.paydate }
				</td>
				<td>${accountPayment.receiptnum}</td>
				<td>
				 <input type="image" name="img" id="${accountPayment.receiptAddress}" value="发票"/> 
				</td>

				<shiro:hasPermission name="erp:accountPayment:edit"><td>
    				<a href="${ctx}/erp/accountPayment/form?id=${accountPayment.id}&&contracttitle=${contractList[status.index].contractTitle }">修改</a>
					<a href="${ctx}/erp/accountPayment/delete?id=${accountPayment.id}" onclick="return confirmx('确认要删除该退货单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>