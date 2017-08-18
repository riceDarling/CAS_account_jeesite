<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>询价单管理</title>
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
			
			
						
		});
		
		$(document).on("change","#materialname",function(){
			//$("#supplier").html("<option value="" selected='true'>请选择</option>");
			var materialnum=$(this).children("option:selected").attr("m_num");
			$("#materialcode").val(materialnum);
			$("#s2id_supplier a span:eq(0)").text('请选择');
			var thisselect =$(this);
			//alert($(this).val());
			//alert($(this).children("option:selected").attr("materialnum"));
			$("#size").val($(this).children("option:selected").attr("m_size"));
			$("#unit").val($(this).children("option:selected").attr("m_unit"));
			/* $.ajax({
				url:"/jeesite/a/erp/accountSupplier/getAccountSuppliersListByMaterialnum",
				type:"post",
				data:{
					'materialnum':materialnum
				},	
				success:function(data){
					//$(thisselect).parent("td").siblings("td").eq(1).children(":text").val(data.materialnum);
					//$(thisselect).parent("td").siblings("td").eq(2).children(":text").val(data.size);
					var html='<option value="">请选择</option>';
					for(i in data){
						html+='<option value="'+data[i].supplier+'">'+data[i].supplier+'</option>';
					}
					$("#supplier").html(html);
				}
			}); */
		});
		
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		
	</ul><br/>
	<form:form id="inputForm" modelAttribute="accountInquiry" action="${ctx}/erp/accountInquiry/saveDetail" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input id="h_supplier" type="hidden" value="${accountInquiry.supplier}"/>
		<input id="h_ordernum" type="hidden" value="${accountInquiry.requisition}"/>
		<input id="h_materialname" type="hidden" value="${accountInquiry.materialname}"/>
		<sys:message content="${message}"/>	
		
		<input name="ordernum" type="hidden" value="${orderNum}"/>
		
		<input name="materialcode" type="hidden" value="" id="materialcode"/>
		
		<div class="control-group">
			<label class="control-label">物资名称：</label>
			<div class="controls">
				<form:select path="materialname" class="input-xlarge required" id="materialname">
				<option value="" > 请选择</option>
				 <c:forEach items="${accountMaterials}" var="accountMaterial">
				 	 <option value="${accountMaterial.materialname }" m_num="${accountMaterial.materialnum }" m_size="${accountMaterial.size }" m_unit="${accountMaterial.unit }" label=""> ${accountMaterial.materialname }</option>
				 </c:forEach>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">供应商名称：</label>
			<div class="controls">
			<form:select path="supplier" class="input-medium required" id="supplier" name="supplier">
				<option value="" > 请选择</option>
				 <c:forEach items="${accountSupplier}" var="accountSupplier">
				 	 <option value="${accountSupplier.supplier }"  >${accountSupplier.supplier }</option>
				 </c:forEach>
			</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">商标：</label>
			<div class="controls">
				<input type="text" name="brand"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">询价有效期限：</label>
			<div class="controls">
				<input name="validdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountInquiry.validdate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">询价时间：</label>
			<div class="controls">
				<input name="inquiryTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountInquiry.validdate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>	
		
		<div class="control-group">
			<label class="control-label">规格型号：</label>
			<div class="controls">
				<form:input path="size" readonly="true" htmlEscape="false" maxlength="35" class="input-xlarge required" id="size"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计量单位：</label>
			<div class="controls">
				<form:input path="unit" readonly="true" htmlEscape="false" maxlength="35" class="input-xlarge required" id="unit"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单价(保留两位)：</label>
			<div class="controls">
				<form:input path="unitprice"  htmlEscape="false" maxlength="35" class="input-xlarge number required" id="unit"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	<%-- 	<div class="control-group">
			<label class="control-label">付款方式：</label>
			<div class="controls">
				<form:select path="payway" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('payway')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:input path="remarks" htmlEscape="false" class="" id="pricefee"/>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="erp:accountInquiry:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
</body>
</html>