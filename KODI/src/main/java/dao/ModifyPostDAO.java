package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository("modifypostdao")
@Mapper
public interface ModifyPostDAO {
	
	//게시글 내용 업데이트
	public void updatePost(HashMap<String, Object> map);
	
	public List<Integer> selectTag(int postIdx);
	
	public int selectTagNum(int postIdx);
	
	public void updateTag(HashMap<String, Object> map);
	
	public void insertTag(HashMap<String, Object> map);
	
	public void deleteTag(HashMap<String, Object> map);
	
	public List<Integer> selectImage(int postIdx);
	
	public int selectImageNum(int postIdx);
	
	public void insertImages(HashMap<String, Object> map);
	
	public void deleteImageSrc(HashMap<String, Object> map);
}
