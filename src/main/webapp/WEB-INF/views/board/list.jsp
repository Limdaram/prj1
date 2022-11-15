<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html><%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<navBar>

</navBar>
<my:navBar active="list"></my:navBar>
<c:if test="${not empty message}">
    <div class="alert alert-success">
        ${message}
    </div>
</c:if>
<div class="container-md">
    <div class="row">
        <div class="col">

            <h1>게시물 목록</h1>
            <table class="table">
                <thread>
                    <tr>
                        <th>#</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일시</th>
                    </tr>
                </thread>
                <tbody>
                    <c:forEach items="${boardList}" var="board">
                        <tr>
                            <td>${board.id}</td>
                            <td>
                                <c:url value="/board/get" var="getLink">
                                    <c:param name="id" value="${board.id}" />

                                </c:url>
                                <a href="${getLink}">
                                    ${board.title}
                                </a>
                                <c:if test="${board.countReply > 0}">
                                    <span class="badge text-bg-dark">
                                        <i class="fa-regular fa-comment-dots"></i>
                                        ${board.countReply}
                                    </span>
                                </c:if>
                                <c:if test="${board.countFile > 0}">
                                    <span class="badge text-bg-secondary">
                                        <i class="fa-solid fa-file"></i>
                                        ${board.countFile}
                                    </span>
                                </c:if>
                            </td>
                            <td>${board.writer}</td>
                            <td>${board.inserted}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <nav class="mt-3" aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <c:if test="${pageInfo.currentPageNumber != 1}">
                        <c:url value="/board/list" var="firstListLink">
                            <c:param name="page" value="1"/>
                            <c:param name="q" value="${param.q}"/>
                            <c:param name="t" value="${param.t}"/>
                        </c:url>
                        <li class="page-item">
                            <a class="page-link" href="${firstListLink}">
                                <i class="fa-solid fa-angles-left"></i>
                            </a>
                        </li>
                        <c:url value="/board/list" var="listLink">
                            <c:param name="page" value="1" />
                            <c:param name="q" value="${param.q}"/>
                            <c:param name="t" value="${param.t}"/>
                        </c:url>
                    </c:if>
                    <c:if test="${pageInfo.hasPreviousButton}">
                        <c:url value="/board/list" var="previousListLink">
                            <c:param name="page" value="${pageInfo.previousPageNumber}"/>
                            <c:param name="q" value="${param.q}"/>
                            <c:param name="t" value="${param.t}"/>
                        </c:url>
                        <li class="page-item">
                            <a class="page-link" href="${previousListLink}">
                                <i class="fa-solid fa-angle-left"></i>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach begin="${pageInfo.leftPageNumber}" end="${pageInfo.rightPageNumber}" var="pageNumber">
                        <c:url value="/board/list" var="listLink">
                            <c:param name="page" value="${pageNumber}"/>
                            <c:param name="q" value="${param.q}"/>
                            <c:param name="t" value="${param.t}"/>
                        </c:url>
                        <li class="page-item
                            <%-- 현재 페이지에 active 클래스 추가 --%>
                            ${pageInfo.currentPageNumber eq pageNumber ? 'active' : ''}
                        "><a class="page-link" href="${listLink}">${pageNumber}</a></li>
                    </c:forEach>
                        <c:if test="${pageInfo.hasNextButton}">
                            <c:url value="/board/list" var="nextListLink">
                                <c:param name="page" value="${pageInfo.nextPageNumber}"/>
                                <c:param name="q" value="${param.q}"/>
                                <c:param name="t" value="${param.t}"/>
                            </c:url>
                            <li class="page-item">
                                <a class="page-link" href="${nextListLink}">
                                    <i class="fa-solid fa-angle-right"></i>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.currentPageNumber != pageInfo.lastPageNumber}">
                            <c:url value="/board/list" var="lastListLink">
                                <c:param name="page" value="${pageInfo.lastPageNumber}"/>
                                <c:param name="q" value="${param.q}"/>
                                <c:param name="t" value="${param.t}"/>
                            </c:url>
                            <li class="page-item">
                                <a class="page-link" href="${lastListLink}">
                                    <i class="fa-solid fa-angles-right"></i>
                                </a>
                            </li>
                        </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
</body>
</html>