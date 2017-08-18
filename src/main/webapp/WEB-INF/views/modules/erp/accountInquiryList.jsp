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
		<li class="active"><a href="${ctx}/erp/accountInquiry/">询价单列表</a></li>
	</ul>
	<%-- <form:form id="searchForm" modelAttribute="accountInquiry" action="${ctx}/erp/accountInquiry/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns">开始时间：
			<input name="beginDate" path ="beginDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountInquiry.beginDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			
			<!--  <input id="" class="btn btn-default" type="date" name="createDate"/></li> -->
			<li class="btns">结束时间：
			<input name="endDate" path="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountInquiry.endDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					
			<!--  <input id="" class="btn btn-default" type="date" name="endDate"/></li> -->
			<li class="btns">选项：
			 <select name="status" path="status">
				<option value="0">进行中</option>
				<option value="1">已提交</option>
				<option value="2">已完成</option>
				<option value="-1">全部</option>
			</select></li>
			<li class="btns"><input id="" class="btn btn-primary" type="submit" value="搜索"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form> --%>
	<form:form id="searchForm" modelAttribute="accountInquiry" action="${ctx}/erp/accountInquiry" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			 <li><label>开始日期：</label><form:input  path="beginDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li><label>结束日期：</label><form:input   path="endDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
				 onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
			</li> 
			<li><label>状态：</label>
				<form:select path="status" class="input-small required" >
				<form:option value="">全部</form:option>
				<form:option value="0">进行中</form:option>
				<form:option value="1">已提交</form:option>	
				<form:option value="2">已完成</form:option>	
				 </form:select>
			</li>
			<li class="btns"><input class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 75%;" >
		<thead>
			<tr>
				<th>序号</th>
				<th>标题</th>
				<th>申请人</th>
				<th>部门</th>
				<th>状态</th>
				<th>发起时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody >
			<c:forEach items="${accountInquiryPage.list }" var="accountInquiry" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>
					${accountInquiry.title}
				</td>
				<td>
					${accountInquiry.maker }
				</td>
				<td>
					${accountInquiry.department }
				</td>
				<td>
					<c:if test="${accountInquiry.status == 0 }">进行中</c:if>
					<c:if test="${accountInquiry.status == 1 }">已提交</c:if>
					<c:if test="${accountInquiry.status == 2 }">已完成</c:if>
				</td>
				<td>
					<fmt:formatDate value="${accountInquiry.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="erp:accountInquiry:edit"><td>
					<a href="${ctx}/erp/accountInquiry/requisition/${accountInquiry.requisition }">申请单明细</a>
					<a href="${ctx}/erp/accountInquiry/detail/${accountInquiry.ordernum}">询价记录</a>
					
					<c:if test="${accountInquiry.status == 0 }">
						<a href="${ctx}/erp/accountInquiry/add/${accountInquiry.ordernum}">添加询价</a>					
					</c:if>
					
					<c:if test="${accountInquiry.status == 0 }">
						<a href="${ctx}/erp/accountInquiry/commit1/${accountInquiry.ordernum} ">提交</a>
					</c:if>
					
				</td></shiro:hasPermission>
					
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${accountInquiryPage}</div>
</body>
</html>