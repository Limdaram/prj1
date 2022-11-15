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
<my:navBar></my:navBar>
<div class="container-md">
    <div class="row">
        <div class="col">

            <c:if test="${not empty message }">
                <div class="alert alert-success">
                        ${message }
                </div>
            </c:if>

            <h1>${member.id}님의 회원 정보 수정하기</h1>

            <form id="form1" action="" method="post">
                <div class="mb-3">
                    <label for="" class="form-label">
                        아이디
                    </label>
                    <input class="form-control" type="text" value="${member.id }" readonly>
                </div>

                <div class="mb-3" class="form-label">
                    <label for="" class="form-label">
                        비밀번호
                    </label>
                    <input id="passwordInput1" class="form-control" type="password" value="${member.password}" name="password">
                    <div id="passwordText1" class="form-text"></div>
                </div>

                <div class="mb-3">
                    <label for="" class="form-label">
                        비밀번호 확인
                    </label>
                    <input id="passwordInput2" class="form-control" type="password">  <%-- 확인용이라 실제 값이 넘어갈 일이 없기 때문에 name 생략 --%>
                </div>

                <div class="mb-3">
                    <label for="" class="form-label">
                        이메일
                    </label>
                    <div class="input-group">
                        <input id="userEmailInput1" class="form-control" type="email" value="${member.email }" name="email" data-old-value="${member.email }">
                        <button disabled id="userEmailExistButton1" type="button" class="btn btn-outline-secondary">중복확인</button>
                    </div>
                    <div id="userEmailText1" class="form-text"></div>
                </div>

                <div class="mb-3" >
                    <label for="" class="form-label">
                        가입일시
                    </label>
                    <input class="form-control" type="text" value="${member.inserted}" readonly>
                </div>
                    <input type="hidden" name="oldPassword">
            </form>
            <button id="modifyButton1" disabled type="submit" class="btn btn-succeess" data-bs-toggle="modal" data-bs-target="#modifyModal">
                <i class="fa-solid fa-pen-to-square"></i>
            </button>

        </div>
    </div>
</div>

<!-- modify Modal -->
<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">기존 암호 입력</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input id="oldPasswordInput1" type="text" class="form-control">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="modalConfirmButton" type="button" class="btn btn-primary">수정</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
<script>
    const ctx = "${pageContext.request.contextPath}";

    document.querySelector("#modalConfirmButton").addEventListener("click", function() {
        const form = document.forms.form1;
        const modalInput = document.querySelector("#oldPasswordInput1");
        const formOldPasswordInput = document.querySelector(`#form1 input[name="oldPassword"]`)
        // 모달 암호 input 입력된 값을
        // form 안의 기존암호 input에 옮기고
        formOldPasswordInput.value = modalInput.value;

        // form을 submit
        form.submit();
    });

    // 패스워드 일치하는지 확인
    const passwordInput1 = document.querySelector("#passwordInput1");
    const passwordInput2 = document.querySelector("#passwordInput2");
    const passwordText1 = document.querySelector("#passwordText1");

    function matchPassword() {
        availablePassword = false;

        const value1 = passwordInput1.value;
        const value2 = passwordInput2.value;

        if (value1 == value2) {
            passwordText1.innerText = "패스워드가 일치합니다"
            availablePassword = true;
        } else {
            passwordText1.innerText = "패스워드가 일치하지 않습니다"
        }
        enableModifyButton();
    }
    document.querySelector("#passwordInput1").addEventListener("keyup", matchPassword)
    document.querySelector("#passwordInput2").addEventListener("keyup", matchPassword)

    // 이메일 중복확인
    const userEmailInput1 = document.querySelector("#userEmailInput1");
    const userEmailExistButton1 = document.querySelector("#userEmailExistButton1");
    const userEmailText1 = document.querySelector("#userEmailText1");

    // 이메일 중복확인 버튼 클릭하면
    userEmailExistButton1.addEventListener("click", function() {
        availableEmail = false;
        const userEmail = userEmailInput1.value;

        fetch(ctx + "/member/existEmail", {
            method : "post",
            headers : {
                "Content-Type" : "application/json"
            },
            body : JSON.stringify({userEmail})
        })
            .then(res => res.json())
            .then(data => {
                userEmailText1.innerText = data.message;

                if (data.status == "not exist") {
                    availableEmail = true;
                }
                enableModifyButton();
            });
    });

    // 이메일 input의 값이 변경되었을 때
    userEmailInput1.addEventListener("keyup", function() {
        const oldValue = userEmailInput1.dataset.oldValue;
        const newValue = userEmailInput1.value;
        if (oldValue == newValue) {
            // 기존 이메일과 같으면 아무일도 일어나지 않음
            userEmailText1.innerText = "";
            userEmailExistButton1.setAttribute("disabled", "disabled");
        } else {
            // 기존 이메일과 다르면 중복체크 요청
            userEmailText1.innerText = "이메일 중복확인을 해주세요.";
            userEmailExistButton1.removeAttribute("disabled");
        }
    });

    // 이메일 사용 가능
    let availableEmail = true;
    // 패스워드 사용 가능
    let availablePassword = true;

    function enableModifyButton() {
        const button = document.querySelector("#modifyButton1");
        if (availableEmail && availablePassword) {
            button.removeAttribute("disabled")
        } else {
            button.setAttribute("disabled", "");
        }
    }

    // 이메일 input 변경 시 submit 버튼 비활성화
    document.querySelector("#userEmailInput1").addEventListener("keyup", function () {
        availableEmail = false;
        enableModifyButton();
    })

</script>
</body>
</html>