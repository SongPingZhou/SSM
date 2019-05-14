package com.spz.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spz.dao.ConsultingManagerMapper;
import com.spz.entity.Fenye;
import com.spz.entity.Student;
import com.spz.service.ConsultingManagerService;
@Service
public class ConsultingManagerServiceImpl implements ConsultingManagerService{

	@Autowired
	private ConsultingManagerMapper consultingManagerMapper;
	@Override
	public String selectStuAll(Student student) {
		// TODO Auto-generated method stub
		Fenye<Student> fenye=new Fenye<Student>();
		student.setPage((student.getPage()-1)*student.getRows());
		fenye.setRows(consultingManagerMapper.selectStuAll(student));
		fenye.setTotal(consultingManagerMapper.selectStuCount(student));
		return new Gson().toJson(fenye);
	}

	@Override
	public Integer deleteStu(Integer s_id) {
		// TODO Auto-generated method stub
		return consultingManagerMapper.deleteStu(s_id);
	}

	@Override
	public Integer updateStu(Student student) {
		// TODO Auto-generated method stub
		return consultingManagerMapper.updateStu(student);
	}

	@Override
	public Integer insertStu(Student student) {
		// TODO Auto-generated method stub
		return consultingManagerMapper.insertStu(student);
	}

	@Override
	public Student selectStuByid(Integer s_id) {
		// TODO Auto-generated method stub
		return consultingManagerMapper.selectStuByid(s_id);
	}

}
