<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订货单管理</title>
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
		
		function setreadlay(state){
			if(state==0){
				$("#checker_div").show();
				$("#btns_0").show()//展示
				$("#btns_1").hide()//隐藏
			}else{
				$("#checker_div").hide();
				$("#btns_0").hide()//隐藏
				$("#btns_1").show()//展示
			}
		};
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">订货单详情</li>
	</ul><br/>
	
	
	<form:form id="inputForm" modelAttribute="accountPurchase" action="${ctx}/erp/accountPurchase/saveAudit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="conclusion" path="conclusion"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group hide">
			<label class="control-label">询价单号：</label>
			<div class="controls">
				<form:input path="inquirynum"  readonly="true" htmlEscape="false" maxlength="37" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				申请<input type="radio" name="state" value="0"  onclick="setreadlay(0)" class="required"/>
				完成<input type="radio" name="state" value="1" onclick="setreadlay(1)" class="required"/>
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
	
			<div class="control-group">
				<label class="control-label">订货单详细：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th  class="hide">供应商编号</th>
								<th  class="hide">物资编号</th>
								<th>供应商名称</th>
								<th>物资名称</th>
								<th>包装方式</th>
								<th>运输方式</th>
								<th>运费金额</th>
								<th>单价</th>
								<th>数量</th>
								<th>预计到货日期</th>
								<th>总价</th>
								<th>备注信息</th>
							</tr>
						</thead>
						<tbody id="accountPurchaseDetailList">
						</tbody>
					</table>
					<script type="text/template" id="accountPurchaseDetailTpl">//<!--
						<tr id="accountPurchaseDetailList{{idx}}">
							<td class="hide">
								<input id="accountPurchaseDetailList{{idx}}_id" name="accountPurchaseDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="accountPurchaseDetailList{{idx}}_delFlag" name="accountPurchaseDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td  class="hide">
								<input id="accountPurchaseDetailList{{idx}}_suppliercode" name="accountPurchaseDetailList[{{idx}}].suppliercode" type="text" value="{{row.suppliercode}}" maxlength="35" class="input-small required"/>
							</td>
							<td  class="hide">
								<input id="accountPurchaseDetailList{{idx}}_materialcode" name="accountPurchaseDetailList[{{idx}}].materialcode" type="text" value="{{row.materialcode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_supplier"  readonly type="text"  maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_materialname" readonly type="text"  maxlength="35" class="input-small required"/>				
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_packways" value="{{row.packways}}" readonly type="text"  maxlength="35" class="input-small required"/>				
							
								
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_transports" value="{{row.transports}}" readonly type="text"  maxlength="35" class="input-small required"/>				
							
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_freightfee" readonly name="accountPurchaseDetailList[{{idx}}].freightfee" type="text" value="{{row.freightfee}}" class="input-small "/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_unitprice" readonly name="accountPurchaseDetailList[{{idx}}].unitprice" type="text" value="{{row.unitprice}}" class="input-small "/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_quantity" readonly name="accountPurchaseDetailList[{{idx}}].quantity" type="text" value="{{row.quantity}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_receivedate" readonly type="text" value="{{row.receivedate}}" maxlength="11" class="input-small required"/>
							
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_totlemoney"  readonly name="accountPurchaseDetailList[{{idx}}].totlemoney" type="text" value="{{row.totlemoney}}" class="input-small "/>
							</td>
							<td>
								<textarea id="accountPurchaseDetailList{{idx}}_remarks" readonly  name="accountPurchaseDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var accountPurchaseDetailRowIdx = 0, accountPurchaseDetailTpl = $("#accountPurchaseDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(accountPurchase.accountPurchaseDetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#accountPurchaseDetailList', accountPurchaseDetailRowIdx, accountPurchaseDetailTpl, data[i]);
								
									
								
								$.ajax({
									url:"../accountMaterial/getMaterialBymaterialcode",
									type:"post",
									data:{
										'materialcode':data[i].materialcode
									},
									async:false,
									success:function(data_material){
										$("#accountPurchaseDetailList"+i+"_materialname").val(data_material.materialname);
									}
								}); 
								$.ajax({
									url:"../accountSupplier/getAccountSupplierBysupplierNum",
									type:"post",
									data:{
										'supplierNum':data[i].suppliercode
									},
									async:false,
									success:function(data_supplier){
										$("#accountPurchaseDetailList"+i+"_supplier").val(data_supplier.supplier);
									}
								}); 
								accountPurchaseDetailRowIdx = accountPurchaseDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label">供应商详细：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th class="hide">供应商编号</th>
								<th>供应商名称</th>
								<th>付款期限</th>
								<th>付款方式</th>
							</tr>
						</thead>
						<tbody id="supplierList">
							<c:forEach items="${accountPurchaseSuppliers }" var="accountPurchaseSupplier" varStatus="status">
								<tr>			
									<td>
										${accountPurchaseSupplier.supplier}
									</td>
									<td>	
										
										<fmt:formatDate value="${accountPurchaseSupplier.deadline }" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										${accountPurchaseSupplier.payways}
							
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label">意见：</label>
				<div class="controls">
					<form:textarea path="comment"  rows="5" maxlength="20" cssStyle="width:500px"/>	
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