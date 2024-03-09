<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:eval var="kakaoKey" expression="@environment.getProperty('kakao.api.key')" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>editpost</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/WritePost.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
<script>
/* 로그인 세션 값 확인 */
if (${isSession}==false){
	alert("로그인하세요");
	location.href = "/";
}
</script>
</head>

<body>
<main>
	<div class="post">
			<form action="/api/post/isupdate" id="wirtePostForm" method="post" enctype="multipart/form-data">
			<input type="number" name="postIdx" value="${readPostOne.postInfo.postIdx}" style="display:none">
				<select name="category" id="categoryPost" required>
				    <option id='categoryOpt' value="" selected disabled>카테고리</option>
				    <option id='foodOpt' value="맛집">맛집</option>
				    <option id='cafeOpt' value="카페">카페</option>
				    <option id='hotelOpt' value="숙소">숙소</option>
				    <option id='playOpt' value="놀거리">놀거리</option>
				</select>
				&nbsp;&nbsp;
				<select name="grade" id="point" required>
				    <option id='pointOpt' value="" selected disabled>평점</option>
				    <option value="1.0">1</option>
				    <option value="1.5">1.5</option>
				    <option value="2.0">2</option>
				    <option value="2.5">2.5</option>
				    <option value="3.0">3</option>
				    <option value="3.5">3.5</option>
				    <option value="4.0">4</option>
				    <option value="4.5">4.5</option>
				    <option value="5.0">5</option>
				</select>
				<br><br>
				<div>
					<input type="text" id="writePostTitle" name="title" placeholder="제목" value="" required><br><br>
					<hr><br>
					<textarea id="writePostContent" name="content" rows="4" placeholder="내용" value="" required></textarea>
					<br><br>
				    <input type="text" id="tagInput" placeholder="#해시태그#입력" value="" onkeypress="handleKeyPress(event)">&nbsp;
				    <button type="button" id="tagAddBtn" onclick="addTag()">추가</button>
				    <div id="tagList"></div>
					<br>
					
					<input type="text" id="selectedAddressShow" value="" placeholder="가게주소" readonly >
					<input type="text" id="selectedAddressReal" name="address" value="" placeholder="가게주소" required>
					&nbsp;<input type="button" id="addressBtn" onclick="openModal()" value="주소검색">
					<br><br>
					
			
					
					<button type="button" id="imageAddBtn" class="btn" onclick="addImage()"><img id="addImageIcon" src="<%=request.getContextPath()%>/image/icon/fileupload.png">&nbsp;사진추가</button><br>
					<span class="photoBoxs" id= "photoBoxs">	
					</span>
					<br><br>
					<div id="garo_btns">
			    		<input type="submit" id="finishBtn" class="btn" value="작성완료">
			    		&nbsp;&nbsp;&nbsp;&nbsp;
			    		<input type="button" id="cancelBtn" class="btn" onclick = "cancelMove()" value="취소">
					</div>
				</div>
			</form>
			<div id="modal">
				<div class="pop">
					<div class=modal-header>
						<input id="inputStoreName" placeholder="장소, 주소" type="text" >&nbsp;
						<button id ="searchAddressBtn" type="button" onclick="searchAddress()">검색</button>&nbsp;
						<button id ="closeModalBtn" type="button" onclick="closeModal()">창닫기</button>
						<div class="labels"></div>
					</div>
				</div>
			</div>
		</div>
</main>
</body>
<%@ include file="/WEB-INF/views/Footer.jsp" %>
<script>
let language = <%=session.getAttribute("language")%>; 

if(language.value == "en") {

	enVersion();
}

function enVersion(){
	$('#categoryOpt').html('Category');
	$('#foodOpt').html('Restaurant');
	$('#cafeOpt').html('Cafe');
	$('#hotelOpt').html('Hotel');
	$('#playOpt').html('Play');
	$('#pointOpt').html('Rating');
	document.getElementById('writePostTitle').placeholder = 'Title';
	document.getElementById('writePostContent').placeholder = 'Content';
	document.getElementById('tagInput').placeholder = '#Hash#Tag';
	document.getElementById('writePostTitle').placeholder = 'Title';
	document.getElementById('writePostTitle').placeholder = 'title';
	$('#tagAddBtn').html('To Add');
	document.getElementById('selectedAddressShow').placeholder = 'Address';
	$("#addressBtn").val("Look Up");
	$("#imageAddBtn").html(`<img id="addImageIcon" src="<%=request.getContextPath()%>/image/icon/fileupload.png">&nbsp;Image Attached</button>`);
	$("#imageAddBtn").attr("style", "width:165px");
	document.getElementById('finishBtn').value = 'Completed';
	document.getElementById('cancelBtn').value = 'Cancel';
	document.getElementById('inputStoreName').placeholder = 'place name, address';
	$('#searchAddressBtn').html('Search');
	$('#closeModalBtn').html('Close');
	
};
	
	showPostData();
	
	function showPostData(){
		$("#categoryPost").val("${readPostOne.postInfo.category}").attr("selected", "selected");
		$("#point").val("${readPostOne.postInfo.grade}").attr("selected", "selected");
		$("#writePostTitle").attr("value", "${readPostOne.postInfo.title}");
		$("#writePostContent").val("${readPostOne.postInfo.content}");
		
		$("#selectedAddressShow").val("${readPostOne.postInfo.address}");
		$("#selectedAddressReal").val("${readPostOne.postInfo.address}");
		var tagListElement = document.getElementById('tagList');
		var tagValue = "${readPostOne.postTags}";
		tagValue = tagValue.substring(1);
	    tagValue = tagValue.substring(0, tagValue.length-1);
		if(tagValue!==""){
	      var tagValues = tagValue.split(", ");

			for (var i = 0; i < tagValues.length; i++) {
			    var tagValue = tagValues[i];
			    var inputHidden = document.createElement('input');
			    inputHidden.name = "postTags";
			    inputHidden.value = tagValue;
			    inputHidden.hidden=true;
			
			    var tagElement = document.createElement('div');
			    tagElement.className = 'tag';
			    tagElement.textContent = tagValue;
			
			    // 태그를 클릭하면 지워지도록 이벤트 핸들러 추가
			    tagElement.onclick = function (tagDiv, tagInput) {
			        return function () {
			            tagListElement.removeChild(tagDiv);
			            tagInput.parentNode.removeChild(tagInput); // 숨겨진 input 요소도 함께 제거
			        };
			    }(tagElement, inputHidden);
			
			    // 태그를 목록에 추가
			    tagListElement.appendChild(tagElement);
			    tagListElement.appendChild(inputHidden); // 숨겨진 input 요소도 함께 추가
			}
		}
	}
		var container = document.getElementById("photoBoxs");
		var oldcontainer = document.createElement("div");
        oldcontainer.className="oldcontainer";
	
		var postIdx = "${readPostOne.postInfo.postIdx}";
		var imageSrc = "${readPostOne.postImages}";
		imageSrc = imageSrc.substring(1);
		imageSrc = imageSrc.substring(0, imageSrc.length-1);
		var imageSrcs = imageSrc.split(", ");
		var imageSrcsLength = imageSrcs.length;
		if(imageSrcs == ""){
			imageSrcsLength = 0;
		}

		
		for (var i = 0; i < imageSrcsLength; i++) {
			var btnIndex = i;
			var imageName = imageSrcs[i];
		    var imageSrc = "/image/db/" + imageSrcs[i];
		    // 이미지 생성
		    var inputImage = document.createElement("img");
		    inputImage.type = "image";
		    inputImage.name = "alreadySaveImage";
		    inputImage.id = "alreadySaveImage"+ btnIndex;
		    inputImage.src = imageSrc;
		    inputImage.width = "200";
		    inputImage.height = "200";
		    

		    // 삭제 버튼 생성
		   var deleteImageBtn = document.createElement("button");
		    deleteImageBtn.type = "button";
		    deleteImageBtn.id = "deleteBtn_" + btnIndex;
		    deleteImageBtn.innerHTML = '<img id="deleteImageIcon" src="<%=request.getContextPath()%>/image/icon/x.png">';
		    deleteImageBtn.style.backgroundColor = "transparent"; // 배경색 없애기
		    deleteImageBtn.style.border = "none"; 
		    
		    // 버튼 onclick 속성 정의
		    deleteImageBtn.onclick = function () {
		    	let imgsrc = this.parentNode.firstChild.src.split("/");  
			    imagename = imgsrc[imgsrc.length-1];
			    imagename = decodeURI(imagename);
		        deleteImageFunction(this.id, imagename, postIdx, language);
		    };

		    // 이미지, 버튼 담는 부모 div 생성
		    var imageContainer = document.createElement("div");
		    imageContainer.className="imageContainer";
		    imageContainer.appendChild(inputImage);
		    imageContainer.appendChild(deleteImageBtn);
		    
		    //이미지, 버튼 한 쌍 담은 div를 부모 div에 추가
		    oldcontainer.appendChild(imageContainer);
		    container.appendChild(oldcontainer);
		}
		
		
	function deleteImageFunction(index, imageName, postIdx, language) {
	    var containerToDelete = document.getElementById(index);
	   	console.log(containerToDelete.parentNode.tagName +":"+index);
	   
	    console.log("Delete image with imageName: " + imageName);
	    console.log("Delete image with postIdx: " + postIdx);
	  	if(language.value == "en") {
	  		if(confirm("Are you sure you want to delete the image?\n(Image deletion cannot be undone even if you click the cancel button.)")) {
			    containerToDelete.parentNode.remove();
			    $.ajax({
			        url: "<%=request.getContextPath()%>/api/post/image/isdelete",
			        type: 'post',
			        data: {
			            imageSrc: imageName,
			            postIdx: postIdx
			        },
			        success:function(){},
			        error: function (error) {
			            console.log(error);
			        }
			    });
		    }//if
	  	}
	  	else {
		    if(confirm("사진을 삭제하시겠습니까?\n(사진 삭제는 취소 버튼을 눌러도 되돌릴 수 없습니다.)")) {
			    containerToDelete.parentNode.remove();
			    $.ajax({
			        url: "<%=request.getContextPath()%>/api/post/image/isdelete",
			        type: 'post',
			        data: {
			            imageSrc: imageName,
			            postIdx: postIdx
			        },
			        success:function(){},
			        error: function (error) {
			            console.log(error);
			        }
			    });
		    }//if
	  	}//if-else
	}

/* 주소검색 api */
document.getElementById("inputStoreName").addEventListener("keypress", function(event) {
       // 엔터키를 눌렀을 때
       if (event.key === "Enter") {
           // 주소 검색 함수 호출
           searchAddress();
       }
   });	

function searchAddress(){
	var parentElement = $('.labels')[0];
	parentElement.innerHTML='';

	
	var searching = $("#inputStoreName").val();
	
	headers = {
	"Authorization": "KakaoAK "+'${kakaoKey}'
	}
	
	
	$.ajax({
	url: 'https://dapi.kakao.com/v2/local/search/keyword.json?query='+searching,
	headers: headers,
	type: 'get',
	dataType: 'json',
	success: function (places) {
			console.log(places);
		
			for(var i=0; i < places.documents.length; i++){
				var label = document.createElement('label');
			
				// 라벨의 id를 설정
				label.id = 'label' + i;
				label.className = 'label';
				
				
				// 라벨의 내용을 설정
				label.innerHTML = places.documents[i].address_name+'   '+'( '+places.documents[i].place_name+' )';
				
				// 라벨 누를 때 이벤트 추가
				label.onclick = function (place) {
				return function () {
				 	$('#selectedAddressShow').val(place.address_name+" "+place.place_name);
                 	$('#selectedAddressReal').val(place.address_name+" "+place.place_name);
                 	$('#inputStoreName').val('');
               		$('.labels').remove();
                 	
                 	closeModal();
				};
			}(places.documents[i]); // 클로저를 이용하여 현재 반복된 항목의 정보를 전달합니다.
			
			parentElement.appendChild(document.createElement('br'));
			parentElement.appendChild(label);
			parentElement.appendChild(document.createElement('br'));
			
			}//for
		}//success
	});//ajax
} 
	
function openModal(){
	$("#modal").show();
}
function closeModal(){
	document.getElementById("modal").scrollTop = 0;
	$("#modal").hide();
}

	
var i = 0;
function addImage() {
	var container = document.getElementById("photoBoxs");
    var newcontainer = document.createElement("div");
    newcontainer.className="newcontainer";
           
    // 새로운 파일 첨부 input 태그 생성
	var newInput = document.createElement("input");
	var idx=i;
	newInput.type = "file";
	newInput.name = "imagePost";
	newInput.id = "files"+idx;
	newInput.accept = "image/*";
	newInput.addEventListener("change", function(){
      	checkFileNameLength(idx);
   	});
		
	i+=1;
		
	// 새로운 이미지 아이콘 생성
	var newIcon = document.createElement("img");
	newIcon.src = "<%=request.getContextPath()%>/image/icon/x.png";  // 이미지 소스 경로에 실제 이미지 파일 경로를 지정
	newIcon.alt = "Delete";
	newIcon.style.cursor = "pointer";
	
	// 이미지와 버튼을 감싸는 컨테이너 생성
	var containerDiv = document.createElement("div");
	containerDiv.id="image-container";
	containerDiv.style.marginBottom = '10px';
	containerDiv.classList.add("image-container");
	
	var newBr = document.createElement("br");
	
	// 이미지와 버튼을 컨테이너에 추가
	
	containerDiv.appendChild(newInput);
	containerDiv.appendChild(newIcon);
	
	// 클릭한 이미지를 포함한 부모 요소를 삭제
	newIcon.onclick = function () {
	    newcontainer.removeChild(containerDiv);
	    newcontainer.removeChild(newBr);
	};
	
	
	newcontainer.appendChild(containerDiv);
	newcontainer.appendChild(newBr);
	container.appendChild(newcontainer);
       
}
 
function checkFileNameLength(idx) {
    var fileInput = document.getElementById('files'+idx);
    console.log(fileInput);
    console.log(fileInput.files[0].name);
    var fileName = fileInput.files[0].name;
    
    if (fileName.length > 100) {
    	if(language.value == "en") {
         	alert("The file name is too long. Please enter 100 characters or less.");
        }else {
           	alert("파일 이름이 너무 깁니다. 100자 이하로 입력해주세요.");
        }
       
        // 파일 선택 취소
        fileInput.value = '';
	}
}
 
/* 태그 구현 */
	
function handleKeyPress(event) {
    if (event.key === 'Enter') {
        event.preventDefault();
        addTag();
    }
}
	
function addTag() {
    var inputElement = document.getElementById('tagInput');
    var tagListElement = document.getElementById('tagList');

    var tagValues = inputElement.value.trim().split(/#| /).filter(Boolean);

    for (var i = 0; i < tagValues.length; i++) {
        var tagValue = tagValues[i];

   	// 새로운 태그를 생성
    var inputHidden = document.createElement('input');
    inputHidden.name = "postTags";
    inputHidden.value = tagValue;
    inputHidden.hidden = true;

    var tagElement = document.createElement('div');
    tagElement.className = 'tag';
    tagElement.textContent = tagValue;

    // 태그를 클릭하면 지워지도록 이벤트 핸들러 추가
    tagElement.onclick = function (tagDiv, tagInput) {
       	return function () {
           	tagListElement.removeChild(tagDiv);
           	tagInput.parentNode.removeChild(tagInput); // 숨겨진 input 요소도 함께 제거
       	};
	    }(tagElement, inputHidden);
		
		    // 태그를 목록에 추가
	    tagListElement.appendChild(tagElement);
	    tagListElement.appendChild(inputHidden); // 숨겨진 input 요소도 함께 추가
	}

    // 입력창 초기화
    inputElement.value = '';
}

function cancelMove(){
	location.href="<%=request.getContextPath()%>/api/post/"+"${readPostOne.postInfo.postIdx}";
}

</script>
</html>