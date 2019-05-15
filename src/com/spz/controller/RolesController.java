package com.spz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.dao.RolesMapper;
import com.spz.entity.Roles;
import com.spz.service.RolesService;
import com.spz.util.Result;

@Controller
public class RolesController {

	@Autowired private RolesService rolesService;
	
	@RequestMapping(value="/selectAllRoles",method=RequestMethod.POST)
	@ResponseBody
	public String selectAllRoles(Roles roles) {
		return rolesService.selectRolesByRole(roles);
	}
	
	@RequestMapping(value="/addEditRoles",method=RequestMethod.POST)
	@ResponseBody
	public String addEditRoles(Roles roles) {
		Integer num=null;
		
		if(roles.getR_id()==null) {
			num=rolesService.insertRoles(roles);
			return Result.toClient(num>0 ? true : false, num>0 ? "添加成功" : "添加失败");
		}else {
			num=rolesService.updateRoles(roles);
			return Result.toClient(num>0 ? true : false, num>0 ? "修改成功" : "修改失败");
		}
	}
	
	@RequestMapping(value="/deleteRolesById",method=RequestMethod.POST)
	@ResponseBody
	public String deleteRolesById(Integer r_id) {
		Integer roles = rolesService.deleteRoles(r_id);
		return Result.toClient(roles>0 ? true :false, roles>0 ? "删除成功" : "删除失败");
	}
	
	
}
