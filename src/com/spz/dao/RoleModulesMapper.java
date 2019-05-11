package com.spz.dao;

import java.util.List;

import com.spz.entity.RoleModules;

public interface RoleModulesMapper {
	
	/**
	 * 批量添加角色的模块
	 * @param roleModules 包含要添加的角色id,以及list的m_id
	 * @return
	 */
	Integer insertRoleModules(List<RoleModules> roleModules);
	
	/**
	 * 删除角色下的所有模块
	 * @param r_id  角色id
	 * @return
	 */
	Integer deleteRoleModules(Integer r_id); 
}
