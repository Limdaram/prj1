<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="active" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
    #searchTypeSelect {
        width : auto;
    }
</style>

<%--authorize tag--%>
<%--spring security expressions--%>

<%--
<sec:authorize access="isAuthenticated()">
    로그인 됨
</sec:authorize>

<sec:authorize access="not isAuthenticated()">
    로그인 안됨
</sec:authorize>
--%>

<sec:authorize access="isAuthenticated()" var="loggedIn" />


<c:url value="/board/list" var="listLink" />
<c:url value="/board/register" var="registerLink" />
<c:url value="/member/signup" var="signupLink" />
<c:url value="/member/list" var="memberListLink" />
<c:url value="/member/login" var="loginLink" />
<c:url value="/member/logout" var="logoutLink" />
<sec:authentication property="name" var="username"/>
<c:url value="/member/info" var="memberInfoLink">
    <c:param name="id" value="${username}"/>
</c:url>


<nav class="navbar navbar-expand-lg bg-light mb-3">
    <div class="container-fluid">
        <a class="navbar-brand" href="${listLink}">
            <c:url value="/daram.jpg" var="logoLink"/>
            <img src="${logoLink}" alt="" style="height: 48px">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
                <li class="nav-item">
                    <c:url value="/board/list" var="listLink" />
                    <a class="nav-link ${active eq 'list' ? 'active' : ''}" href="${listLink}">목록</a>
                </li>
                <c:if test="${loggedIn}">
                    <li class="nav-item">
                        <c:url value="/board/register" var="registerLink" />
                        <a class="nav-link ${active eq 'register' ? 'active' : ''}" href="${registerLink}">작성</a>
                    </li>
                </c:if>
                <sec:authorize access="hasAuthority('admin')">
                    <li class="nav-item">
                        <c:url value="/board/register" var="registerLink" />
                        <a class="nav-link ${active eq 'memberList' ? 'active' : ''}" href="${memberListLink}">회원목록</a>
                    </li>
                </sec:authorize>
                <c:if test="${loggedIn}">
                    <li class="nav-item">
                        <a href="${memberInfoLink}" class="nav-link">회원정보</a>
                    </li>
                    <li class="nav-item">
                        <a href="${logoutLink}" class="nav-link">로그아웃</a>
                    </li>
                </c:if>

                <c:if test="${not loggedIn}">
                    <li class="nav-item">
                        <c:url value="/board/register" var="registerLink" />
                        <a class="nav-link ${active eq 'signup' ? 'active' : ''}" href="${signupLink}">회원가입</a>
                    </li>

                    <li class="nav-item">
                        <a href="${loginLink}" class="nav-link">로그인</a>
                    </li>
                </c:if>
            </ul>
            <form action="${listLink}" class="d-flex" role="search">
                <select name="t" id="searchTypeSelect" class="form-select">
                    <option value="all">전체</option>
                    <option value="title" ${param.t == 'title' ? 'selected' : ''}>제목</option>
                    <option value="content" ${param.t == 'content' ? 'selected' : ''}>본문</option>
                    <option value="writer" ${param.t == 'writer' ? 'selected' : ''}>작성자</option>
                </select>
                <input value="${param.q}" class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="q">
                <button class="btn btn-outline-success" type="submit">
                    <i class="fa-sharp fa-solid fa-magnifying-glass"></i>
                </button>
            </form>
        </div>
    </div>
</nav>