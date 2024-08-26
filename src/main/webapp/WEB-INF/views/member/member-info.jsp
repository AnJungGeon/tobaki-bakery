<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="../resources/css/member-style.css">
    <div class="container">
        <!-- 네비게이션 시작 -->
        <nav class="breadcrumb">
            <a class="breadcrumb-item" href="../"><i class="fas fa-home"></i></a>
            <a class="breadcrumb-item" href="../member/member">회원가입</a>
        </nav>
        <!-- 네비게이션 끝 -->

        <br>

        <!-- 회원가입 섹션 시작 -->
        <div class="signup-section">
            <h1><b>회원가입</b></h1>
            <br>
            <br>
            <form id="signupForm" action="../" method="post" onsubmit="return validateForm()">

                <!-- 회원정보 입력 헤더 시작 -->
                <div class="signup-header">
                    <h2><b>회원정보입력</b></h2>
                    <p>* 표시는 필수입력항목입니다.</p>
                </div>
                <!-- 회원정보 입력 헤더 끝 -->

                <br>

                <!-- 회원정보 입력 테이블 시작 -->
                <table class="table table-bordered" style="width: 900px; margin: 0 auto;">
                    <tbody>
                        <!-- 이름 입력 필드 시작 -->
                        <tr>
                            <td>* 이름</td>
                            <td><input type="text" class="form-control input-small" name="name" id="name" required></td>
                        </tr>
                        <!-- 이름 입력 필드 끝 -->

                        <!-- 아이디 입력 필드 시작 -->
                        <tr>
                            <td>* 아이디</td>
                            <td>
                                <div class="input-group-append">
                                    <input type="text" class="form-control input-small" name="username" id="username" required>
                                    &nbsp;
                                    <button class="btn btn-secondary" type="button" onclick="checkUsername()">중복확인</button>
                                </div>
                            </td>
                        </tr>
                        <!-- 아이디 입력 필드 끝 -->

                        <!-- 비밀번호 입력 필드 시작 -->
                        <tr>
                            <td>* 비밀번호</td>
                            <td>
                                <input type="password" class="form-control input-small" name="password" id="password" required>
                                <small class="form-text text-muted">영문 대소문자/숫자/특수문자를 혼용하여 3종류 10-16자</small>
                            </td>
                        </tr>
                        <!-- 비밀번호 입력 필드 끝 -->

                        <!-- 비밀번호 확인 입력 필드 시작 -->
                        <tr>
                            <td>* 비밀번호 확인</td>
                            <td><input type="password" class="form-control input-small" name="password_confirm" id="password_confirm" required></td>
                        </tr>
                        <!-- 비밀번호 확인 입력 필드 끝 -->

                        <!-- 생일 및 성별 입력 필드 시작 -->
                        <tr>
                            <td>* 생일/성별</td>
                            <td>
                                <div class="d-flex align-items-center birthday-gender-row">
                                    <select class="form-control input-tiny" name="birth_year" required>
                                        <option>선택</option>
                                        <script>
                                            for (let i = new Date().getFullYear(); i >= 1900; i--) {
                                                document.write('<option value="'+i+'">'+i+'</option>');
                                            }
                                        </script>
                                    </select>
                                    <h6> 년 </h6>
                                    <select class="form-control input-tiny" name="birth_month" required>
                                        <option>선택</option>
                                        <script>
                                            for (let i = 1; i <= 12; i++) {
                                                document.write('<option value="'+i+'">'+i+'</option>');
                                            }
                                        </script>
                                    </select>
                                    <h6> 월 </h6>
                                    <select class="form-control input-tiny" name="birth_day" required>
                                        <option>선택</option>
                                        <script>
                                            for (let i = 1; i <= 31; i++) {
                                                document.write('<option value="'+i+'">'+i+'</option>');
                                            }
                                        </script>
                                    </select>
                                    <h6> 일 </h6>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" value="M" required>
                                        <label class="form-check-label">남</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" value="F" required>
                                        <label class="form-check-label">여</label>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <!-- 생일 및 성별 입력 필드 끝 -->

                        <!-- 주소 입력 필드 시작 -->
                        <tr>
                            <td>* 주소</td>
                            <td>
                                <div class="input-group-append">
                                    <input type="text" class="form-control input-small-postcode" id="postcode" name="postcode" placeholder="우편번호" readonly required>
                                    &nbsp;
                                    <button class="btn btn-secondary" type="button" onclick="execDaumPostcode()">우편번호검색</button>
                                </div>
                                <input type="text" class="form-control mt-2" id="address" name="address" placeholder="주소" style="width: 500px;" readonly>
                                <input type="text" class="form-control mt-2" id="address_detail" name="address_detail" placeholder="상세주소" style="width: 500px;">
                            </td>
                        </tr>
                        <!-- 주소 입력 필드 끝 -->

                        <!-- 휴대폰 입력 필드 시작 -->
                        <tr>
                            <td>* 휴대폰</td>
                            <td>
                                <div class="form-row">
                                    <div class="col">
                                        <select class="form-control" name="phone_prefix" required>
                                            <option>선택</option>
                                            <option>010</option>
                                            <option>011</option>
                                            <option>012</option>
                                            <option>017</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <input type="text" class="form-control" name="phone_middle_number" required>
                                    </div>
                                    <div class="col">
                                        <input type="text" class="form-control" name="phone_last_number" required>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <!-- 휴대폰 입력 필드 끝 -->

                        <!-- 이메일 입력 필드 시작 -->
                        <tr>
                            <td>* 이메일</td>
                            <td>
                                <div class="input-group-append">
                                    <input type="text" class="form-control" name="email_local" style="width: 150px;" required>
                                    <span class="input-group-text">@</span>
                                    <input type="text" class="form-control" name="email_domain" id="email_domain" style="width: 150px;" required>
                                    <div class="input-group-append">
                                        <select class="form-control" name="email_select" id="email_select" required onchange="setEmailDomain()">
                                            <option value="">직접입력</option>
                                            <option value="naver.com">naver.com</option>
                                            <option value="daum.net">daum.net</option>
                                            <option value="gmail.com">gmail.com</option>
                                        </select>
                                    </div>
                                    &nbsp;
                                    <button class="btn btn-secondary" type="button" onclick="showEmailAlert()">이메일 중복확인</button>
                                </div>
                            </td>
                        </tr>
                        <!-- 이메일 입력 필드 끝 -->

                        <!-- 본인확인 질문 및 답변 필드 시작 -->
                        <tr>
                            <td>* 본인확인 질문</td>
                            <td>
                                <div>
                                    <select class="form-control input-small" name="question" required>
                                        <option>가장 좋아하는 색깔은?</option>
                                        <option>가장 좋아하는 동물은?</option>
                                        <option>내가 다녔던 초등학교는?</option>
                                        <option>어렸을때의 별명은?</option>
                                        <option>현재 거주하고 있는 주소는?</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>* 본인확인 답변</td>
                            <td><input type="text" class="form-control input-small" name="answer" required></td>
                        </tr>
                        <!-- 본인확인 질문 및 답변 필드 끝 -->

                    </tbody>
                </table>
                <!-- 회원정보 입력 테이블 끝 -->

                <br>
                <br>

                <!-- 가입 완료 및 이전 버튼 시작 -->
                <div class="form-group text-center">
                    <button type="submit-join" class="btn btn-dark" onclick="showJoinAlert()">회원가입</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">이전으로</button>
                </div>
                <!-- 가입 완료 및 이전 버튼 끝 -->

            </form>
        </div>
        <!-- 회원가입 섹션 끝 -->
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <script src="../js/member.js"></script>
    <!-- 스크립트 파일 포함 끝 -->