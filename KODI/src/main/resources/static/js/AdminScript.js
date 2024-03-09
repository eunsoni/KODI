$(document).ready(function () {
    

	
    
    
     function updateMenuContentPosition() {
     var menuOffset = $(".menu").offset();
     $(".menu-content").css({ 'left': menuOffset.left });
     }

     //관리자 메뉴버튼
     $("#menubtn").on("click", function () {
         updateMenuContentPosition();
         $(".menu-content").slideToggle(); // 
     });

     $(window).on('resize', function () {
         if ($(".menu-content").is(":visible")) {
             updateMenuContentPosition();
         }
     });
     
     let topBtn = document.getElementById("topBtn");

    function topFunction() {
        document.body.scrollTop = 0; // Safari 용
        document.documentElement.scrollTop = 0; // Chrome, Firefox, IE 및 Opera 용
    }

    topBtn.addEventListener("click", topFunction);

    window.onscroll = function() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            topBtn.style.display = "block";
        } else {
            topBtn.style.display = "none";
        }
    };
    
    
    


});//ready