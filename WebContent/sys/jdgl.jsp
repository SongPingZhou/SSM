<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<script src="../js/global.js"></script>
<script type="text/javascript">
	$(function() {
		$("#rolesDg").datagrid({
			url: globalData.server+"GetRolesAll",
			queryParams: { //要发送的参数列表
				token: globalData.token
			}
		});
	});
 
	function addRoles() {
		$("#addRole_window").window("open");
	}

	function submitRoleForms() {
		var data = $("#addRoleForm").serialize();
		if($("#addRoleForm").form("validate")) {
			$.ajax({
				url: globalData.server+'CreateRole',
				method: 'post',
				dataType: 'json',
				data: data + "&token="+globalData.token,
				success: function(res) {
					if(res.success) {
						$.messager.alert("提示信息", "添加成功", "info");
						$("#addRole_window").window("close");
						$("#rolesDg").datagrid("reload")
					} else {
						$.messager.alert("提示信息", "添加失败", "info");
					}
				}
			})
		} else {
			$.messager.alert("提示信息", "请填写信息", "info");
		}
	}//操作角色
	function formatterOPUser(value, row, index) {
		return "<a style='cursor: pointer;' onclick='updateRoleInfo(" + index + ")'>编辑</a> <a style='cursor: pointer;' onclick='deleteRoleInfo(" + index + ")'>删除</a>";
	}
	function updateRoleInfo(index){
		//将当前数据填入表单
		var data=$("#rolesDg").datagrid("getData");
		var row=data.rows[index];
		$("#updateRole_window").form("load",row);
		$("#updateRole_window").window("open");
	}
	function updatesubmitRoleForms(){
		var Id=$("#Id").val();
		var Name=$("#Name").val();
		$.ajax({
			type:"post",
			url:globalData.server+"UpdateRole",
			dataType:'json',
			data:{"roleId":Id,"name":Name,"token":globalData.token},
			success:function(res){
				if(res.success){
					$.messager.alert("提示信息","修改成功","info");
					$("#updateRole_window").window("close");
					$("#rolesDg").datagrid("reload");
				}else
				$.messager.alert("错误信息","修改失败","info");
			}
		});
	}
	function deleteRoleInfo(index){
		var data = $("#rolesDg").datagrid("getData");
		var row = data.rows[index];
		$.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
		    if (r){ // 用户点击了确认按钮
		        $.ajax({
					method:'post',
					url:globalData.server+'DeleteRole',
					data:{"roleId":row.Id,"token":globalData.token},
					success:function(data){
						var d=eval("("+data+")");
						if(d.success){
							$("#rolesDg").datagrid("reload");
							$.messager.alert("提示信息","成功删除","info");
						}else
						$.messager.alert("错误信息","删除失败","info");
					}
				}) 
		    }    
		});
	}
	function formatterSetRole(value, row, index) {
		return "<a style='cursor: pointer;' onclick='showRoles(" + index + ")'>设置</a>";
	}
	var yhna;
	var uid;
	function showRoles(index){
		var nodes=$("#rolesDg").datagrid("getData");
		var row = nodes.rows[index];
			yhna=row.Name;
			uid=row.Id;
		$("#opentreemenu").dialog({
			title:'您正在设置--'+yhna+'--的权限',
			toolbar:'#tas'
		})
		$("#treemenu").tree({
			url: globalData.server+'GetModulesByRoleId',
			checkbox:true,
			lines: true,
			queryParams: {
				roleId:row.Id,
				token: globalData.token
			}
		})
		$("#opentreemenu").window("open");
	}
	function baocun(){
		alert(uid)
		var nodes=$("#treemenu").tree("getChecked",['checked','indeterminate']);
		var str="";
		for(var i=0;i<nodes.length;i++){
			if(nodes[i].checked){
				str+=","+nodes[i].id;
			}
		}
		$.ajax({
			url:globalData.server+'SetSysRights',
			data:{"parentIds":str.substr(1),"rId":uid,"token":globalData.token},
			method:'post',
			dataType:'json',
			success:function(res){
				$("#opentreemenu").window("close");
				$.messager.alert("提示信息","设置成功需要手动刷新才能看效果");
			}
		})
	}
</script>
<table name="center" class="easyui-datagrid" id="rolesDg" title="角色列表" data-options="rownumbers:true,singleSelect:true,pagination:true,method:'post',toolbar:'#tb',pageSize:10">
	<thead>
		<tr>
			<th data-options="field:'Id',width:80,hidden:true">角色id</th>
			<th data-options="field:'Name',width:180">角色名称</th>
			<th data-options="field:'sss',width:60,align:'center',formatter:formatterSetRole">角色</th>
			<th data-options="field:'setRoleAction',width:120,align:'center',formatter:formatterOPUser">操作</th>
		</tr>
	</thead>
</table>

<div id="tb" style="padding: 5px; height: auto;">
	<div style="margin-bottom: 5px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plan="true" onclick="addRoles()">新增</a>
	</div>
</div>

<!--新增角色-->
<div id="addRole_window" class="easyui-window" title="新增员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px; top: 200px;">
	<form id="addRoleForm">
		<table cellpadding="5">
			<tr>
				<td>角色名:</td>
				<td><input class="easyui-textbox" type="text" name="name" id="name" data-options="required:true"></input>
				</td>
			</tr>
		</table>
		
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="submitRoleForms()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearRoleForm()">取消</a>
	</div>
</div>

<!--修改角色-->
<div id="updateRole_window" class="easyui-window" title="修改员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px; top: 200px;">
	<form id="updateRoleForm">
		<table cellpadding="5">
			<tr>
				<td>角色名:</td>
				<input type="hidden" name="Id" id="Id" data-options="required:true"></input>
				<td><input class="easyui-textbox" type="text" name="Name" id="Name" data-options="required:true"></input></td>
			</tr>
		</table>
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="updatesubmitRoleForms()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateclearRoleForm()">取消</a>
	</div>
</div>
<div id="opentreemenu" class="easyui-window" data-options="modal:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true" style="width: auto;height: auto;top: 30px;">
	<div id="moduleDiv" title="请选择模块" style="width: 300px; height: 400px; background: #eee;">
		<ul id="treemenu"></ul>
	</div>
	<div id="tas" style="margin-bottom: 5px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="baocun()">提交</a>
	</div>
</div>
 
	

