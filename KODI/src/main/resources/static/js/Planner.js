/*플래너 구현*/
let newlanguage = language.value;
									
const daysTag = document.querySelector(".days"),
  currentDate = document.querySelector(".current-date"),
  prevNextIcon = document.querySelectorAll(".icons span");

let date = new Date(),
  currYear = date.getFullYear(),
  currMonth = date.getMonth();

let selectedDates = [];

const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
  "Aug", "Sep", "Oct", "Nov", "Dec"];

const renderCalendar = () => {
  	let firstDayofMonth = new Date(currYear, currMonth, 1).getDay(),
    lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate(),
    lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay(),
    lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate();
  	let liTag = "";

  	for (let i = firstDayofMonth; i > 0; i--) {
    	liTag += `<li class="inactive">${lastDateofLastMonth - i + 1}</li>`;
  	}

  	for (let i = 1; i <= lastDateofMonth; i++) {
    	let isToday = i === date.getDate() && currMonth === new Date().getMonth() &&
      	currYear === new Date().getFullYear() ? "active" : "";
    	liTag += `<li class="${isToday}" data-date="${currYear}-${currMonth + 1}-${i}">${i}</li>`;
	}

  	for (let i = lastDayofMonth; i < 6; i++) {
    	liTag += `<li class="inactive">${i - lastDayofMonth + 1}</li>`;
  	}
  	currentDate.innerText = `${currYear} ${months[currMonth]}`;
  	daysTag.innerHTML = liTag;
  
  
  	document.querySelectorAll('.days li').forEach(day => {
	  	day.addEventListener('click', () => {
		    const clickedDate = day.getAttribute('data-date');
		    handleDateSelection(clickedDate);
		
		    // 클릭된 날짜에 대한 스타일 처리
		    document.querySelectorAll('.days li').forEach(dayElement => {
		      dayElement.classList.remove('selected');
		    });
		
		    day.classList.add('selected');
	  	});
	});
}

const modal = document.querySelector(".modal");
let map = null //controller에서 받아오기

const handleDateSelection = (clickedDate) => {
  // 두 날짜가 이미 선택되어 있다면 선택을 초기화
  if (selectedDates.length === 2 || 
      (selectedDates.length === 1 && clickedDate < selectedDates[0])) {
    selectedDates = [];
    document.querySelectorAll('.days li.selected').forEach(dayElement => {
      dayElement.classList.remove('selected');
    });
}
  // 클릭한 날짜를 선택 목록에 추가
  selectedDates.push(clickedDate);

  // 선택된 날짜를 콘솔에 표시
  console.log('선택된 날짜:', selectedDates);

  // 두 날짜가 선택된 경우, 선택된 날짜 사이의 모든 날짜를 콘솔에 표시
  if (selectedDates.length === 2) {
    const startDate = new Date(selectedDates[0]);
    const endDate = new Date(selectedDates[1]);
    startDate.setDate(startDate.getDate()+1);
    endDate.setDate(endDate.getDate()+1);
    const dateRange = getDateRange(startDate, endDate);
    
    let contextUrl;
    
    if(contextPath == "null") {
		contextUrl = "/api/planner/schedule";
	} else {
		contextUrl = contextPath + "/api/planner/schedule";
	}
    
    $.ajax({
      url: contextUrl,
      type:"post",
      data:{
         day1:dateRange[0],
         day2:dateRange[dateRange.length-1]   
      },
      
      success:function(response){
         console.log(response)
         var schedulelist = response.schedulelist;
     	 makeModal(dateRange, schedulelist, newlanguage);
      },
      error:function(error){
         console.log(error);
      }
      
      
   });
    console.log('선택된 날짜 사이의 모든 날짜:', dateRange); 
  }
    if (selectedDates.length === 2 && clickedDate < selectedDates[0]) {
    document.querySelectorAll('.days li.selected').forEach(dayElement => {
      dayElement.classList.remove('selected');
    });
    selectedDates = [];
  }
  
}

function makeModal(dateList, schedulelist, newlanguage){
   	document.querySelector('.modal').style.display ='block';
   	var container = document.querySelector('.pop-planner');
	removeOneScheduleElements(container);
	for (var i = 0; i < dateList.length; i++) {
		var modalDiv = document.createElement('div');
		modalDiv.className = 'oneSchedule';
		modalDiv.innerHTML += dateList[i];
		dateList[i] = "\'" + dateList[i] + "\'"; 
		if(schedulelist[i]==null){
			schedulelist[i]='';
		}
		
		if(newlanguage == "en") {
			modalDiv.innerHTML +=
			'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="modalBtn" id="insertBtn" onclick="saveDiv(' + dateList[i] + ',' + i + ',' + newlanguage + ')">Save</button>&nbsp;'
			+'<button class="modalBtn" id="deleteBtn" onclick="deleteDiv(' + i+','+dateList[i] + ',' + newlanguage+')">Del</button><br>'
			+'<textarea class="scheduleContent" cols="25" rows="7">'+schedulelist[i]+'</textarea><br>';
		}
		else {
			modalDiv.innerHTML +=
			'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="modalBtn" id="insertBtn" onclick="saveDiv(' + dateList[i] + ',' + i + ',' + newlanguage + ')">저장</button>&nbsp;'
			+'<button class="modalBtn" id="deleteBtn" onclick="deleteDiv(' + i+','+dateList[i] + ',' + newlanguage+')">삭제</button><br>'
			+'<textarea class="scheduleContent" cols="25" rows="7">'+schedulelist[i]+'</textarea><br>';
		}

		document.querySelector('.pop-planner').appendChild(modalDiv);
   } 
}
function removeOneScheduleElements(container) {
    var oneScheduleElements = container.getElementsByClassName('oneSchedule');
    if (oneScheduleElements.length > 0) {
        while (oneScheduleElements.length > 0) {
            oneScheduleElements[0].parentNode.removeChild(oneScheduleElements[0]);
        }
    }
}


function deleteAllChildren(element) {
    // element의 모든 자식을 삭제
    while (element.firstChild) {
        element.removeChild(element.firstChild);
    }
}

function deleteDiv(index, date, newlanguage) {
    var container = document.querySelector('.pop-planner');
    console.log(container.tagName);
    console.log(container.children.length +":" + index);
    console.log(container.children[index]);
    // 지정된 div 내의 input 요소 가져오기
    var inputElement = container.children[index].querySelector('textarea');
    inputElement.value="";
    console.log(inputElement);
    
    let contextUrl;
    
    if(contextPath == "null") {
		contextUrl = "/api/planner/schedule/isdelete";
	} else {
		contextUrl = contextPath + "/api/planner/schedule/isdelete";
	}
    
    if(newlanguage.value == "ko") {
	    if(confirm("해당 일정을 삭제하시겠습니까?")) {
		    $.ajax({
			  	url: contextUrl,
			  	type:'post',
			  	data:{ 
			     	date:date,
			 	},
			 	success: function(){
					 
				 },
				error : function(error) {  
		        	console.log(error);
				}
		      
		   });
		}
	}
	else {
		if(confirm("Are you sure you want to delete this schedule?")) {
		    $.ajax({
			  	url: contextUrl,
			  	type:'post',
			  	data:{ 
			     	date:date,
			 	},
			 	success: function(){
					 
				 },
				error : function(error) {  
		        	console.log(error);
				}
		      
		   });
		}
	}
}

function saveDiv(target, index, newlanguage) {
	var container = document.querySelector('.pop-planner');
    
 	var inputElement = container.children[index].querySelector('textarea');

    // input 요소의 값을 빈 문자열로 설정
    var date = target;
    console.log(inputElement);
  	var content=inputElement.value;
  	
  	let contextUrl;
    
    if(contextPath == "null") {
		contextUrl = "/api/planner/schedule/issave";
	} else {
		contextUrl = contextPath + "/api/planner/schedule/issave";
	}
  	
    $.ajax({
	  	url: contextUrl,
	  	type:'post',
	  	data:{ 
	     	date:date,
	     	content:content
	 	},
	 	success: function(){
			 
		 }, 
		error : function(error) {  
        	console.log(error);
		}
      
   });
   if(newlanguage.value == "ko") {
	   alert("저장되었습니다");
   }
   else {
	   alert("Schedule has been saved.");
   }
}

const getDateRange = (start, end) => {
  const dateRange = [];
  let currentDate = new Date(start);
  
  while (currentDate <= end) {
    dateRange.push(new Date(currentDate).toISOString().split('T')[0]);
    currentDate.setDate(currentDate.getDate() + 1);
  }
  return dateRange;
}


renderCalendar();

prevNextIcon.forEach(icon => {
  icon.addEventListener("click", () => {
    currMonth = icon.id === "prev" ? currMonth - 1 : currMonth + 1;

    if (currMonth < 0 || currMonth > 11) {
      date = new Date(currYear, currMonth, new Date().getDate());
      currYear = date.getFullYear();
      currMonth = date.getMonth();
    } else {
      date = new Date();
    }
    renderCalendar();
  });
});

function closePlannerModal(){
	$(".modal").hide();
	
	document.querySelectorAll('.days li').forEach(dayElement => {
    dayElement.classList.remove('selected');
  });
}

