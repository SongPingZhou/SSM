package com.spz.dao;

import java.util.List;

import com.spz.entity.RoleModules;

public interface RoleModulesMapper {
	
	/**
	 * ������ӽ�ɫ��ģ��
	 * @param roleModules ����Ҫ��ӵĽ�ɫid,�Լ�list��m_id
	 * @return
	 */
	Integer insertRoleModules(List<RoleModules> roleModules);
	
	/**
	 * ɾ����ɫ�µ�����ģ��
	 * @param r_id  ��ɫid
	 * @return
	 */
	Integer deleteRoleModules(Integer r_id); 
}
