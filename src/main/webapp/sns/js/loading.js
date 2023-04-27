    /* ajax 실행시 로딩바 출력 기능 */    
    $( document ).ready(function() {
        $(document).ajaxStart(function () {
            $('#loading').show(); // ajax 시작 -> 로딩바 표출
        });

        $(document).ajaxStop(function () {
            $('#loading').hide(); // ajax 끝 -> 로딩바 히든
        });
    });
    
    