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
					
					if('yes'==$('#conclusion').val()){
						/* 此处验证数据 */
						var _checker = $( '#checkerName' ),	//审核人
							  wokenstr = '<label for="receivedate" class="error">必填信息</label>';
						if ( _checker.val().replace( ' ' , '' ) == '' ) {
							_checker.parent().after( wokenstr );
							return;
						}
					}
					
					if('end'==$('#conclusion').val()){
						/* 此处验证数据 */
						var _inquiryId = $( '#inquiryId' ),	//询价人
							  wokenstr = '<label for="receivedate" class="error">必填信息</label>';
						if ( _inquiryId.val().replace( ' ' , '' ) == '' ) {
							_inquiryId.parent().after( wokenstr );
							return;
						}
					}
					
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
			$.ajax({
				url:"../accountMaterial/getMaterialByName",
				type:"post",
				data:{
					'materialname':$(this).val()
				},	
				success:function(data){
					$(thisselect).parent("td").siblings("td").eq(1).children(":text").val(data.materialnum);
					$(thisselect).parent("td").siblings("td").eq(2).children(":text").val(data.size);
	
				}
			});
		});
		
		function setreadlay(state){
			if(state==0){
				$("#checker_div").show();
				$("#inquiry_div").hide();
				$("#btns_0").show()//展示
				$("#btns_1").hide()//隐藏
			}else{
				$("#checker_div").hide();
				$("#inquiry_div").show();
				$("#btns_0").hide()//隐藏
				$("#btns_1").show()//展示
			}
		};
		
	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">申请单</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="accountRequisition" action="${ctx}/erp/accountRequisition/saveAudit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="conclusion" path="conclusion"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" readonly="true" htmlEscape="false" maxlength="60" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">期望到货日期：</label>
			<div class="controls">		
				<fmt:formatDate value="${accountRequisition.receivedate}" pattern="yyyy-MM-dd"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请原因：</label>
			<div class="controls">
				<form:input path="reason"  readonly="true" value="${accountRequisition.reason}" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请部门：</label>
			<div class="controls">
			<form:input path=""   value="${accountRequisition.office.name}" readonly="true" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				申请<input type="radio" name="state" value="0"  onclick="setreadlay(0)" class="required"/>
				询价<input type="radio" name="state" value="1" onclick="setreadlay(1)" class="required"/>
			</div>
		</div>
		<div class="control-group" id="checker_div">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<sys:treeselect id="checker" name="checker" value="" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			
		</div>
			<div class="control-group" id="inquiry_div" style="display:none">
			<label class="control-label">询价人：</label>
			<div class="controls">
				<sys:treeselect id="inquiry" checked="true" name="inquiry" value="" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			
		</div>
			<div class="control-group">
				<label class="control-label">申请单子表：</label>
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
								<input id="accountRequisitionDetailList{{idx}}_materialname"  readonly name="accountRequisitionDetailList[{{idx}}].materialname" type="text" value="{{row.materialname}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_size" readonly type="text"  maxlength="35" readonly class="input-small required"/>		
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_quantitiy" readonly name="accountRequisitionDetailList[{{idx}}].quantitiy" type="text" value="{{row.quantitiy}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_unit" readonly name="accountRequisitionDetailList[{{idx}}].unit" type="text" value="{{row.unit}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<textarea id="accountRequisitionDetailList{{idx}}_remarks" readonly name="accountRequisitionDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
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
										$("#accountRequisitionDetailList"+i+"_materialname").val(data_material.materialname);
									}
								}); 
								accountRequisitionDetailRowIdx = accountRequisitionDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">意见：</label>
				<div class="controls">
					<form:textarea path="comment" rows="5" maxlength="20" cssStyle="width:500px"/>		
					<span class="help-inline"><font color="red">(最多20个字)</font> </span>	
				</div>
			</div>
			
	
		
		<div class="form-actions" id="btns_0">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#conclusion').val('yes')"/>&nbsp;
				<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#conclusion').val('no')"/>&nbsp;	
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<div class="form-actions" id="btns_1" style="display:none">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="完成" onclick="$('#conclusion').val('end')"/>&nbsp;
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	<table class="table table-striped table-bordered table-condensed">
       <tr><th>申请人</th><th>审核人</th><th>开始时间</th><th>结束时间</th><th>结论</th><th>意见</th></tr>
        <c:forEach items="${actlist}" var="item">
            <tr>
            <td>${item.requisitionName}</td>
            <td>${item.checkerName}</td>
            <td><fmt:formatDate value="${item.start_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><fmt:formatDate value="${item.end_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
            	<c:if test="${item.conclusion==0}">不同意</c:if>
          		 <c:if test="${item.conclusion==1}">同意</c:if>
            </td>
            <td>${item.remarks}</td> 
            </tr>
        </c:forEach>
     </table>
	
</body>
</html>