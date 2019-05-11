package com.spz.dao;

import java.util.List;

import com.spz.entity.Modules;

public interface ModulesMapper {
	
	/**
	 * ���ģ��
	 * @param modules
	 * @return
	 */
	Integer insertModules(Modules modules);
	
	/**
	 * �޸�ģ��
	 * @param modules
	 * @return
	 */
	Integer updateModules(Modules modules);
	
	/**
	 * ɾ��ģ��
	 * @param m_id ģ��id
	 * @return
	 */
	Integer deleteModules(Integer m_id);

	/**
	 * ��ѯ����ģ��
	 * @return
	 */
	List<Modules> selectModulesAll();
	
}
