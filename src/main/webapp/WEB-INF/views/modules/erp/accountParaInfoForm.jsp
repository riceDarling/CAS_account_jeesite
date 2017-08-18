<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>参数项管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
			
			
			$.ajax({
				url:"../accountParaInfo/getAccountPara",
				type:"post",
				success:function(data){
					for(i in data){
						$("#inputForm select").append('<option value="'+data[i].id+'">'+data[i].name+'</option>');
					}
					
				}
			}); 
			
			 $("#inputForm select").select2();
		});
		
		$(document).on("change","#inputForm select",function(){
			//alert($(this).val());
			$("#pId").val($(this).val());
		});
		
		$(document).on("click","#btnSubmit",function(){
			var json_data={
					'pId':$('#pId').val(),
					'name':$('#name').val()
			};
			$.ajax({
				url:"../accountParaInfo/save",
				type:"post",
				data:json_data,
				success:function(data){
					alert(data);
				}
			})
		});
		
		
	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
			<li class="active">添加参数项</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="accountParaInfo" action="${ctx}/erp/accountParaInfo/save" method="post" class="form-horizontal">
		<div hidden="true"><input id="pId" name="pId" type="text" value="" /></div>
			
		<div class="control-group">
			<label class="control-label">参数名：</label>
			<div class="controls">
				<select  style="width:265px" class="required">
					<option value="">请选择</option>
				</select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			
		</div>	
		
		<div class="control-group">
			<label class="control-label">参数项：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			
		</div>				
						
	<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>