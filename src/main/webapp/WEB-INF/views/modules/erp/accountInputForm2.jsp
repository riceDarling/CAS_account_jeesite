<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入库单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#inputForm").validate({
			submitHandler: function(form){
				loading('正在提交，请稍等...');
				form.submit();
			},
			errorContainer: "#messageBox",
			errorPlacement: function(error, element) {
				$("#messageBox").text("输入有误，请先更正。");
				if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
					error.appendTo(element.parent().parent());
				} else {
					error.insertAfter(element);
				}
			}
		});
		//获取仓库列表
	/*  $.ajax({
			url:"../accountWarehouse/getWarehouselList",
			type:"post",
			success:function(data){
				var html='<option value="">请选择</option>';
				for(i in data){
						html+='<option  value="'+data[i].housename+'">'+data[i].housename+'</option>';
				}
				$("select[name='warehouse']").html(html);
			}
			});
	}); */
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountInput/">入库单列表</a></li>
		<shiro:hasPermission name="erp:accountInput:edit"><li><a href="${ctx}/erp/accountInput/form">待入库添加</a></li></shiro:hasPermission>
		<li class="active"><a href="${ctx}/erp/accountInput/form2?id=${accountInput.id}">入库详细</a></li>
	</ul>
		<h4 style="text-align:center;background:#f1f1f1;">入库详细信息</h4>
		<table id="contentTable2" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>物资名称</th>
				<th>规格型号</th>
				<th>入库数量</th>
				 <th>仓库</th>
				<th>货位编码</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page3}" var="accountInputDetail">
			<tr>
				<td>
					${accountInputDetail.materialname}
				</td>
				<td>
					${accountInputDetail.size}
				</td>
				<td>${accountInputDetail.quantity}</td>
				<td>${accountInputDetail.warehouse}</td>
				<td>${accountInputDetail.location}</td>
				<td>
					${accountInputDetail.inputremarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		
	<form:form id="inputForm" modelAttribute="accountInput" action="${ctx}/erp/accountInput/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group" hidden="true">
			<label class="control-label">入库单号：</label>
			<div class="controls">
				<form:input path="inputnum" htmlEscape="false" readonly="true" maxlength="37" class="input-xlarge required" id="inputnum"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入库日期：</label>
			<div class="controls">
			 <input name="inputdate" id="inputdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${accountInput.inputdate}" pattern="yyyy-MM-dd HH:mm"/>"
					/>  
			</div>
		</div>
		<div class="control-group" hidden="true">
			<label class="control-label">入库类别：</label>
			<div class="controls">
				<form:input path="category" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group" hidden="true">
			<label class="control-label">送检单号：</label>
			<div class="controls">
				<form:input path="inspectionnum" htmlEscape="false" maxlength="37" class="input-xlarge required" id="inspectionnum"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
			<form:textarea path="remarks" readonly="true" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " id="remarks"/> 
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="erp:accountInput:edit"><input class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>