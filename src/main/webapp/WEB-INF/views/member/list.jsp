<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
          integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<my:navBar active="memberList"></my:navBar>

<div class="container-md">
  <div class="row">
    <div class="col">

      <c:if test="${not empty message }">
        <div class="alert alert-success">
            ${message }
        </div>
      </c:if>

      <h1>회원 목록</h1>
      <table class="table">
        <thread>
          <tr>
            <th>#</th>
            <th>아이디</th>
            <th>닉네임</th>
            <th>암호</th>
            <th>이메일</th>
            <th>가입일시</th>
          </tr>
        </thread>
        <tbody>
        <c:forEach items="${memberList}" var="member">
          <c:set var="i" value="${i+1}"/>
          <tr>
            <td>${i}</td>
            <td>
              <c:url value="/member/info" var="infoLink">
                <c:param name="id" value="${member.id}" />

              </c:url>
              <a href="${infoLink}">
                  ${member.id}
              </a>
            </td>
            <td>${member.nickName}</td>
            <td>${member.password}</td>
            <td>${member.email}</td>
            <td>${member.inserted}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
</body>
</html>