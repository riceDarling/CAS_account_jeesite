<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		
		
		$(document).ready(function() {
			//$("#name").focus();
			
			$("#inputForm").validate({
				submitHandler: function(form){
					if('no'!=$('#conclusion').val()){
						/* 此处验证数据 */
						var _checker = $( '#checkerName' ),	//审核人
							  wokenstr = '<label for="receivedate" class="error">必填信息</label>';
						if ( _checker.val().replace( ' ' , '' ) == '' ) {
							_checker.parent().after( wokenstr );
							return;
						}
						
						var sontablebody = $( '#accountRequisitionDetailList' );
						if ( sontablebody.children().length < 1 ) {
							$( '#contentTable' ).after( wokenstr );
							return;
						}
					}
						
					$("#btnSubmit").attr("disabled", true); 	
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
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
			
			// $("#accountRequisitionDetailList"+idx+"_materialname").select2();
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
		
		$(document).on("change",".materialname_select",function(){
			var thisselect =$(this);
			//alert($(this).val());
			//alert($(this).children("option:selected").attr("materialnum"));
			$(thisselect).parent("td").siblings("td").eq(1).children(":text").val($(this).children("option:selected").attr("materialnum"));
			$(thisselect).parent("td").siblings("td").eq(2).children(":text").val($(this).children("option:selected").attr("materialsize"));
			/*$.ajax({
				url:"../accountMaterial/getMaterialByName",
				type:"post",
				data:{
					'materialname':$(this).val()
				},	
				success:function(data){
					$(thisselect).parent("td").siblings("td").eq(1).children(":text").val(data.materialnum);
					$(thisselect).parent("td").siblings("td").eq(2).children(":text").val(data.size);
	
				}
			});*/
		});
	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountRequisition/">申请单列表</a></li>
		<li class="active"><a href="${ctx}/erp/accountRequisition/form?id=${accountRequisition.id}">申请单<shiro:hasPermission name="erp:accountRequisition:edit">${not empty accountRequisition.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:accountRequisition:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="accountRequisition" action="${ctx}/erp/accountRequisition/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="conclusion" path="conclusion"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="60" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">期望到货日期：</label>
			<div class="controls">
				<input name="receivedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountRequisition.receivedate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请原因：</label>
			<div class="controls">
				<form:input path="reason" htmlEscape="false" value="${accountRequisition.reason}" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">申请部门：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${accountRequisition.office.id}" labelName="office.name" labelValue="${accountRequisition.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<sys:treeselect id="checker"  name="checker" value="" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			<span class="help-inline"><font color="red">*</font> </span>
			</div>
			
		</div>
			<div class="control-group">
				<label class="control-label">申请单子表 ：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th class="hide">物资编码</th>
								<th>物资名称</th>
								<th>规格型号</th>
								<th>申请数量</th>
								<th>计量单位</th>
								<th>备注信息</th>
								<shiro:hasPermission name="erp:accountRequisition:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="accountRequisitionDetailList">
						</tbody>
						<shiro:hasPermission name="erp:accountRequisition:edit"><tfoot>
							<tr><td colspan="5"><a href="javascript:" onclick="addRow('#accountRequisitionDetailList', accountRequisitionDetailRowIdx, accountRequisitionDetailTpl);accountRequisitionDetailRowIdx = accountRequisitionDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="accountRequisitionDetailTpl">//<!--
						<tr id="accountRequisitionDetailList{{idx}}">
							<td class="hide">
								<input id="accountRequisitionDetailList{{idx}}_id" name="accountRequisitionDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="accountRequisitionDetailList{{idx}}_delFlag" name="accountRequisitionDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td class="hide">
								<input id="accountRequisitionDetailList{{idx}}_materialcode" name="accountRequisitionDetailList[{{idx}}].materialcode" type="text" value="{{row.materialcode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<select id="accountRequisitionDetailList{{idx}}_materialname" type="text" maxlength="35" class="input-small required materialname_select" >
										<option value=''>请选择</opption>
										<c:forEach items="${materials}" var="material">
												
												<c:choose>
													<c:when test="${material.materialnum==row.materialcode}">
														<option  selected='true' value='${material.materialname}' materialnum='${material.materialnum}' materialsize='${material.size}'>${material.materialname}</opption>
													</c:when>
													<c:otherwise>
														 <option value='${material.materialname}' materialnum='${material.materialnum}' materialsize='${material.size}'>${material.materialname}</opption>
													</c:otherwise>
												</c:choose>

											
										
										</c:forEach>
								</select>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_size" type="text"  maxlength="35" readonly class="input-small required"/>		
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_quantitiy" name="accountRequisitionDetailList[{{idx}}].quantitiy" type="text" value="{{row.quantitiy}}" maxlength="11" class="input-small required number"/>
							</td>
							<td>
								<select id="accountRequisitionDetailList{{idx}}_units" name="accountRequisitionDetailList[{{idx}}].units" value="{{row.units}}"  type="text" maxlength="35" class="input-small required " >
										<option value=''>请选择</opption>
										<c:forEach items="${units}" var="unit">
												
												<c:choose>
													<c:when test="${unit.id==row.units}">
														<option  selected='true' value='${unit.id}'>${unit.name}</opption>
													</c:when>
													<c:otherwise>
														 <option value='${unit.id}' >${unit.name}</opption>
													</c:otherwise>
												</c:choose>

											
										
										</c:forEach>
								</select>
							</td>
							<td>
								<textarea id="accountRequisitionDetailList{{idx}}_remarks" name="accountRequisitionDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="erp:accountRequisition:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#accountRequisitionDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var accountRequisitionDetailRowIdx = 0, accountRequisitionDetailTpl = $("#accountRequisitionDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(accountRequisition.accountRequisitionDetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#accountRequisitionDetailList', accountRequisitionDetailRowIdx, accountRequisitionDetailTpl, data[i]);
							 	$.ajax({
									url:"../accountMaterial/getMaterialBymaterialcode",
									type:"post",
									data:{
										'materialcode':data[i].materialcode
									},
									async:false,
									success:function(data_material){
										$("#accountRequisitionDetailList"+i+"_materialcode").val(data_material.materialnum);
										$("#accountRequisitionDetailList"+i+"_size").val(data_material.size);
										$("#accountRequisitionDetailList"+i+"_materialname option").each(function(){
											// alert($(this).val());
											 if(data_material.materialname==$(this).val()){
												 $(this).attr("selected",true);
											} 
										}); 
									}
								}); 
							 	
							 	$("#accountRequisitionDetailList"+i+"_units option").each(function(){
									// alert($(this).val());
									 if(data[i].units==$(this).val()){
										 $(this).attr("selected",true);
									} 
								}); 
								
								accountRequisitionDetailRowIdx = accountRequisitionDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			<input id="btnSubmit" class="btn btn-inverse" type="submit" value="销毁" onclick="$('#conclusion').val('no')"/>&nbsp;	
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>