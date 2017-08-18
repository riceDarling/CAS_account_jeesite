<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合同管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
	//获取采购订货单标题
	$.ajax({
		url:"${ctx}/erp/accountPurchase/getAccountPurchaseTitle",
		type:"post",
		success:function(data){
			var html='<option value=""></option>';
			for(i in data){
				html+='<option value="'+data[i].title+'">'+data[i].title+'</option>';
			}
			$("#purchasenumtitle").html(html);
		   
		}
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
		<li class="active"><a href="${ctx}/erp/accountContract/">合同列表</a></li>
		<shiro:hasPermission name="erp:accountContract:edit"><li><a href="${ctx}/erp/accountContract/form">合同添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="accountContract" action="${ctx}/erp/accountContract/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			 <li><label>采购标题：</label>
					<form:select path="title" class="input-xlarge required" id="purchasenumtitle">
				 <form:option value="">请选择</form:option>
				 </form:select>
			</li> 
			<li><label>合同名称：</label>
				<form:input path="contracttitle" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-small required" >
				<form:option value="">请选择</form:option>
				<form:option value="0">未完成</form:option>
				<form:option value="1">已完成</form:option>	
				 </form:select>
			</li>
		</ul>
		<ul class="ul-form">
			 <li><label>开始日期：</label><form:input  path="beginDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li><label>结束日期：</label><form:input   path="endDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				 onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
			</li> 
			<li class="btns"><input class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>采购标题</th>
				<th>供应商</th>
				<th>合同名称</th>
				<th>合同编号</th>
				 <th>合同金额</th> 
				<th>签订时间</th>
				<th>合同状态</th>
				<shiro:hasPermission name="erp:accountContract:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountContract">
			<tr>
			    <%-- <td>
					${accountContract.purchasenum}
				</td>
				<td>
				<a href="${ctx}/erp/accountContract/form2?id=${accountContract.id}">
					${accountContract.contractnum}
				</a></td> --%>
				<td>${accountContract.title}</td>
				<td>${accountContract.supplier}</td>
				 <td>
					${accountContract.contracttitle}
				</td> 
				 <td>
					${accountContract.contractnum}
				</td> 
				<td>
					${accountContract.money}
				</td>
				<td>
					<fmt:formatDate value="${accountContract.createDate}" pattern="yyyy-MM-dd "/>
				</td>
				 <td><c:choose><c:when test="${accountContract.status=='0'}">
				 未完成
				 </c:when>
					<c:otherwise>
				 已完成
				 </c:otherwise></c:choose>
				</td> 
				<shiro:hasPermission name="erp:accountContract:edit"><td>
				  <!--  <a href="#">合同打印</a>  -->
    				<a href="${ctx}/erp/accountContract/form2?id=${accountContract.id}">合同修改</a>
					<a href="${ctx}/erp/accountContract/delete?id=${accountContract.id}" onclick="return confirmx('确认要删除该合同吗？', this.href)">合同删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>