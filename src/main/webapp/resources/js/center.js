$('#boardSearchForm').on('submit', function(event){
    event.preventDefault();
    const searchText = $(this).find('#boardKeyword');    
    const formCategory = $('#searchCategory').val();
   
    if(searchText.val().trim() === '') {
    		showModal('검색 확인!','검색내용을 입력해주세요.');

        return;
    }else{
    		showModal()
    		this.submit('검색 확인!', str);
    }

    let str = '검색하신 키워드입니다. <br>';
    str += '['+formCategory+': '+ searchText + ']\n';
   
});

/*
$('#boardWriteForm').submit(function(event){
    event.preventDefault();

    const memberName = $('#memberName');
    const productList = $('#productListForm');
    const productReview = $('#productReviewForm');
    const boardTitle = $('#boradTitleForm');
    const boardContent = $('#boradContentForm');
    const boardFile = $('#boardFileForm');

    if(!boardTitle.find('#title').val()) {
        alert('제목을 입력해 주세요.');
        return;
    } else if (!boardContent.find('#boardContent').val()) {
        alert('내용을 입력해 주세요!');
        return;
    }

    let str = '작성하신 내역입니다.\n';
    str += '작성자: ['+memberName.val()+']\n';
    productList.length != 0 && (
        str += '카테고리: ['
            + productList.find('#category option:selected').val()
            + '] & 상품명: ['
            + productList.find('#boardProductName option:selected').text().trim()
            +']\n'
    );
    productReview.length != 0 && (
        str += '리뷰: ['
            + productReview.find('#reviewProdName').text()
            + ' & '
            + productReview.find('#reviewProdPrice').text()
            + ']\n'
    );
    str += '제목 : ['+boardTitle.find('#title').val()+']\n';
    str += '비공개여부 : ['+boardTitle.find('#secretBorad').is(':checked')+']\n';
    str += '내용 : ['+boardContent.find('#boardContent').val()+']\n';
    boardFile.find('#attachment')[0].files.length > 0 ? 
        (str += '첨부파일 : ['+boardFile.find('#attachment')[0].files[0].name+']') : 
        (str += '첨부파일 : [첨부된 파일이 없음]');

    alert(str);
});
*/

$('#productListForm #category').change(function(event){
    const category = $('#productListForm #category option:selected');
    const target = $('#boardProductName');

    const data = [
        ['옥수수빵', '옥수수식빵', '생크림빵', '단팥빵', '메론빵'],
        ['옥수수케이크', '초코케이크', '딸기케이크', '바나나케이크', '메론케이크'],
        ['옥수수쿠키', '초코쿠키', '딸기쿠키', '바나나마들렌', '메론마들렌']
    ];
    
    const pid = [
    	[1, 2, 3, 4, 5],
    	[6, 7, 8, 9, 10],
    	[11, 12, 13, 14, 15]
    ]

    if(category.val() == 'bread') {
        target.empty();
        const listData = data[0];
        const listPid = pid[0];
        for(let i=0; i<listData.length; i++) {
            target.append(`
                <option value="${listPid[i]}">${listData[i]}</option>
            `);
        }
        
    } else if(category.val() == 'cake') {
        target.empty();
        const listData = data[1];
        const listPid = pid[1];
        for(let i=0; i<listData.length; i++) {
            target.append(`
                <option value="${listPid[i]}">${listData[i]}</option>
            `);
        }
    } else {
        target.empty();
        const listData = data[2];
        const listPid = pid[2];
        for(let i=0; i<listData.length; i++) {
            target.append(`
                <option value="${listPid[i]}">${listData[i]}</option>
            `);
        }
    }
});

$('#commentForm').submit(function(event){
    event.preventDefault();

    const memberId = $('#memberName').val();
    const commentContent = $('#commentCentent').val().replace(/\n/g, '<br>');
    const boardId = $('.text-muted.board-index').text();
    const boardType = $('#boardType').val();
    //let formattedDate = moment().format('YYYY-MM-DD HH:mm:ss');
    const requestData = {
    	memberId: memberId,
    	commentContent: commentContent,
    	boardType: boardType,
    	boardId: boardId
    	//commentDatetime: formattedDate
    }
    if(!commentContent) {
    	showModal('내용을 입력해 주세요.');
        return;
    }
    console.log(requestData);

    
    $.ajax({
    	url: "addComment",
    	type: "post",
    	data: requestData,
    	success: function(data) {
    		if(data.status === 'ok') {
    			console.log(data.commentData);
    			const date = moment(data.commentData.commentDatetime, "ddd MMM DD HH:mm:ss z YYYY").format('YYYY-MM-DD HH:mm:ss');
    			console.log(date);
    			const listTag = $('#commentList ul');
    		    listTag.append(`
    		        <li class="list-group-item">
    		            <div class="reply-author">
    		                <p>
    		                    <strong>${data.commentData.memberId}</strong><small class="text-muted">&nbsp;${date}</small>
    		                    <button class="btn btn-light btn-sm disabled commentDelete" id="commentId-${data.commentData.commentId}"><i class="fas fa-times"></i></button>
    		                </p>
    		            </div>
    		            <div class="reply-content">
    		                <p>${commentContent}</p>
    		            </div>
    		        </li>
    		    `);
    		    $('#commentCentent').val('');
    		}
    	},
    	error: function (xhr, status, error) {
            console.log('Error: ' + error);
        }
    });
    
    
});

$('#commentList').on('click', 'button.commentDelete', function(event){
	const commentTag = $(this).closest('li');
	const commentId = $(this).attr('id').split('-')[1];
    const memberId = commentTag.find('#memberId-'+commentId).text();
    const boardType = $('#boardType').val();
    const boardId = $('.text-muted.board-index').text();
    const form = {commentId, memberId, boardType, boardId};
    console.log(form);
    
    $.ajax({
    	url: 'deleteComment',
    	method: 'post',
    	data: form,
    	success: function(data) {
    		if(data.status === 'ok') {
    			commentTag.remove();
    		} else if(data.status === 'no-master') {
    			showModal('삭제 권한이 존재하지 않습니다.');
    		}
    	},
    	error: function (xhr, status, error) {
            console.log('Error: ' + error);
        }
    });
});

$('#removeBoardBotton').click(function(){
	const boardIndex = $('.text-muted.board-index').text();
	const boardType = $('#boardType').val();
	console.log(boardType);
	
	$.ajax({
		url: "removeBoard",
		method: "post",
		data: {boardIndex, boardType},
		success: function(data){
			console.log(data);
			if(data.status === 'ok') {
				showModal('게시글을 삭제하였습니다.');
				location.href='list';
			} else if(data.status === 'fail') {
				showModal('삭제 실패','이미 삭제된 게시글이거나, 게시글이 존재하지 않습니다.');
				location.href='list';
			} else if(data.status === 'no-authority') {
				showModal('권한 없음', '게시글 작성자만이 게시글 삭제가 가능합니다.');
			} else {
				showModal('서버와의 연결에 문제가 발생하였습니다.');
			}
		}
	});
});

$('#boardWriteForm').on('submit', function(event){
	const boardContent = $('#boardContent').val();
	$('#boardContent').val(boardContent.replace(/\n/g, "<br>"));
	console.log($('#boardContent').val());
	
	$('#timestamp').val(moment().format('YYYY-MM-DD HH:mm:ss'));
});

$('.deleteImage').on('click', function(event){
	const target = $(this).parent();
	const imageName = $(this).prev('span').text().trim();
	const boardId = $('#boardIdForDeleteImage').val();
	const boardType = $('#boardTypeForDeleteImage').val();
	
	$.ajax({
		url: 'removeImage',
		method: 'post',
		data: {imageName, boardId, boardType},
		success: function(response) {
			if(response.result === 'ok') {
				console.log('왜 작동 안하니');
				console.log(target);
				target.remove();
				
				const savedFileLength = $('.savedFiles').length;
				if(savedFileLength === 0) {
					$('#savedFileNamesRavel')
						.after(`<div id="notFoundAttachFiles" class="mb-1">현재 첨부된 파일이 존재하지 않습니다.</div>`);
				}
				
			} else if(response.result === 'notFoundImage') {
				showModal('삭제 실패','현재 이미지가 존재하지 않거나, 이미 삭제되었습니다.\n다시 확인해 주세요.');
			
			} else {
				showModal('불명확한 사유로 인해 처리가 실패하였습니다.\n고객센터에 문의해 주세요.');
			}
		}
	});
});

