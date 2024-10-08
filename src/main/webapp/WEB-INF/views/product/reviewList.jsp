<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/center.css">
<body>

<hr class="hr" />

<section class="page-container" style="max-width: 1200px;">
    <!-- Breadcrumbs 영역 시작-->
    <nav class="breadcrumb-container">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i></a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product">상품</a></li>
            <li class="breadcrumb-item active" aria-current="page">상품후기</li>
        </ol>
    </nav>
    <!-- Breadcrumbs 영역 종료-->
    
    <!-- 메인 컨테이너 -->
    <div class="list-container mb-5">

        <!-- 게시글 검색 컴포넌트 시작 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="table-row-counter">총 ${boardAllCount}개의 게시물이 있습니다.</div>
            <form class="form-inline" id="boardSearchForm">
                <div class="form-group mr-2">
                    <select class="form-control" id="searchCategory">
                        <option value="이름">이름</option>
                        <option value="제목">제목</option>
                        <option value="내용">내용</option>
                    </select>
                </div>
                <div class="input-group">
                    <label for="boardSearch" class="sr-only">검색</label>
                    <input type="text" class="form-control" id="boardSearch" placeholder="검색어를 입력해 주세요.">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-primary" style="border-color: transparent; padding-bottom: 5px;"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </form>
        </div>
        <!-- 게시글 검색 컴포넌트 종료 -->

        <!-- 게시판 리스트 시작-->
        <table class="table table-hover mb-5">
            <thead class="thead-light">
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">작성일</th>
                    <th scope="col">조회</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${boardList}" var="element">
                    <tr>
                        <th scope="row">${element.productReviewId}</th>
                        <td>
                            <a href="${pageContext.request.contextPath}/product/review/detail?reviewId=${element.productReviewId}" class="d-inline">
                                ${element.reviewTitle}&ensp;
                            </a>
                            <span class="badge badge-info">NEW</span>
                        </td>
                        <td>${element.memberId}</td>
                        <td><fmt:formatDate value="${element.reviewDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${element.reviewViews}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- 게시판 리스트 종료-->

        <!-- 게시판 묶음 네비게이터 바 시작 -->
        <div class="paging-wrapper">
            <ul class="pagination">
                <li class="page-item disabled">
                    <c:if test="${pager.groupNo>1}">
                        <a class="page-link" href="${pageContext.request.contextPath}/product/review/list?pageNo=${pager.startPageNo-1}" >&laquo;</a>
                    </c:if>
                    <c:if test="${pager.groupNo<=1}">
                        <a class="page-link" href="javascript:void(0);" >&laquo;</a>
                    </c:if>
                </li>
                
                <c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" var="i">
                    <c:if test="${pager.pageNo == i}">
                        <li class="page-item active">
                            <a class="page-link" href="${pageContext.request.contextPath}/product/review/list?pageNo=${i}">${i}</a>
                        </li>
                    </c:if>
                        
                    <c:if test="${pager.pageNo != i}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/product/review/list?pageNo=${i}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>

                <li class="page-item">
                    <c:if test="${pager.groupNo<pager.totalGroupNo}">
                        <a class="page-link" href="${pageContext.request.contextPath}/product/review/list?pageNo=${pager.endPageNo+1}">&raquo;</a>
                    </c:if>
                    <c:if test="${pager.groupNo>=pager.totalGroupNo}">
                        <a class="page-link" href="javascript:void(0)">&raquo;</a>
                    </c:if>
                </li>
            </ul>
        </div>
          <!-- 게시판 묶음 네비게이터 바 종료 -->

        <a class="btn btn-secondary float-right btn-bottom" href="${pageContext.request.contextPath}/product/review/addReviewForm">글쓰기</a>
    </div>
</section>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
