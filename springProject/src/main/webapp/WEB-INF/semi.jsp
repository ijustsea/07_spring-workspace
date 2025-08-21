<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH BANK - 로그인</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        /* 배경 애니메이션 요소들 */
        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        .bg-circle:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 20%;
            animation-delay: 0s;
        }

        .bg-circle:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 15%;
            animation-delay: 2s;
        }

        .bg-circle:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 10%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 0;
            width: 100%;
            max-width: 900px;
            min-height: 500px;
            position: relative;
            z-index: 10;
            animation: slideUp 0.8s ease-out;
            display: flex;
            overflow: hidden;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, #e4b6ec, #d196dd);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        .right-panel {
            flex: 1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .welcome-section {
            margin-bottom: 40px;
        }

        .welcome-title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 15px;
            opacity: 0;
            animation: fadeInUp 1s ease-out 0.5s forwards;
        }

        .welcome-subtitle {
            font-size: 18px;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 30px;
            opacity: 0;
            animation: fadeInUp 1s ease-out 0.7s forwards;
        }

        .features-list {
            text-align: left;
            max-width: 280px;
            opacity: 0;
            animation: fadeInUp 1s ease-out 0.9s forwards;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .feature-icon {
            width: 20px;
            height: 20px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo {
            display: inline-flex;
            align-items: center;
            gap: 15px;
            font-size: 28px;
            font-weight: bold;
            color: white;
            margin-bottom: 10px;
        }

        .logo-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background: white;
            padding: 8px;
        }

        .logo-icon img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-title {
            font-size: 28px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .logo-subtitle {
            color: #718096;
            font-size: 14px;
            margin-top: 5px;
        }

        .login-form {
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2d3748;
            font-size: 14px;
        }

        .form-input {
            width: 100%;
            padding: 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        .form-input:focus {
            outline: none;
            border-color: #e4b6ec;
            box-shadow: 0 0 0 3px rgba(228, 182, 236, 0.1);
            background-color: white;
        }

        .form-input::placeholder {
            color: #a0aec0;
        }

        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #718096;
            font-size: 18px;
            user-select: none;
        }

        .password-toggle:hover {
            color: #4a5568;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .checkbox-container input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #e4b6ec;
        }

        .checkbox-container label {
            font-size: 14px;
            color: #4a5568;
            cursor: pointer;
        }

        .forgot-password {
            color: #e4b6ec;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #e4b6ec, #d196dd);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(228, 182, 236, 0.3);
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(228, 182, 236, 0.4);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .security-notice {
            background: #f0f8ff;
            border: 1px solid #bee3f8;
            border-radius: 8px;
            padding: 15px;
            margin-top: 20px;
            font-size: 13px;
            color: #2c5282;
            line-height: 1.5;
        }

        .security-notice-title {
            font-weight: 600;
            color: #1e4a72;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            color: #718096;
            font-size: 12px;
            line-height: 1.5;
        }

        .footer a {
            color: #e4b6ec;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        /* 로딩 애니메이션 */
        .loading {
            position: relative;
            overflow: hidden;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
                max-width: 420px;
                margin: 20px;
            }

            .left-panel {
                padding: 40px 30px;
                min-height: 200px;
            }

            .right-panel {
                padding: 40px 30px;
            }

            .welcome-title {
                font-size: 24px;
            }

            .welcome-subtitle {
                font-size: 16px;
            }

            .features-list {
                display: none;
            }

            .logo {
                font-size: 24px;
            }

            .logo-icon {
                width: 50px;
                height: 50px;
            }

            .login-title {
                font-size: 24px;
            }
        }

        @media (max-width: 480px) {
            .form-input {
                padding: 14px;
                font-size: 16px; /* iOS 확대 방지 */
            }

            .login-btn {
                padding: 14px;
            }
        }

        /* 접근성 개선 */
        .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border: 0;
        }

        /* 다크모드 대응 */
        @media (prefers-color-scheme: dark) {
            .login-container {
                background: #1a202c;
                color: #e2e8f0;
            }

            .form-input {
                background-color: #2d3748;
                border-color: #4a5568;
                color: #e2e8f0;
            }

            .form-input:focus {
                background-color: #4a5568;
            }

            .form-label {
                color: #e2e8f0;
            }

            .security-notice {
                background: #2c5282;
                border-color: #3182ce;
                color: #e2e8f0;
            }

            .security-notice-title {
                color: #90cdf4;
            }
        }
    </style>
</head>
<body>
    <!-- 배경 애니메이션 -->
    <div class="bg-circle"></div>
    <div class="bg-circle"></div>
    <div class="bg-circle"></div>

    <div class="login-container">
        <!-- 왼쪽 -->
        <div class="left-panel">
            <div class="logo">
                <div class="logo-icon">
                    <img src="resources/images/logo.png" alt="KH Bank Logo">
                </div>
                <span>KH BANK</span>
            </div>
            <div class="welcome-section">
                <div class="welcome-title">환영합니다!</div>
                <div class="welcome-subtitle">
                    KH Bank ERP 시스템에 로그인하여<br>
                    효율적인 업무 환경을 경험하세요
                </div>
            </div>
        </div>

        <!-- 오른쪽 -->
        <div class="right-panel">
            <div class="login-header">
                <div class="login-title">시스템 로그인</div>
                <div class="logo-subtitle">Enterprise Resource Planning System</div>
            </div>

            <!-- 에러/로그아웃 메시지 (임시 더미) -->
            <div class="error-message show" style="display:none;">에러 메시지</div>
            <div class="error-message show" style="background-color:#d4edda; border-color:#c3e6cb; color:#155724; display:none;">
                로그아웃되었습니다.
            </div>

            <form class="login-form" action="#" method="post" id="loginForm">
                <div class="form-group">
                    <label class="form-label" for="userId">사용자 ID</label>
                    <input type="text" class="form-input" id="userId" name="userId" placeholder="사용자 ID 입력" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">비밀번호</label>
                    <div class="password-container">
                        <input type="password" class="form-input" id="password" name="password" placeholder="비밀번호 입력" required>
                        <span class="password-toggle" onclick="togglePassword()">👁️</span>
                    </div>
                </div>

                <div class="remember-forgot">
                    <div class="checkbox-container">
                        <input type="checkbox" id="rememberMe" name="rememberMe">
                        <label for="rememberMe">로그인 상태 유지</label>
                    </div>
                    <a href="#" class="forgot-password">비밀번호 찾기</a>
                </div>

                <button type="submit" class="login-btn" id="loginBtn">🔐 로그인</button>
            </form>

            <div class="footer">
                <div>© 2025 KH Bank. All rights reserved.</div>
            </div>
        </div>
    </div>

    <script>
        // (기존 JS 그대로 유지)
    </script>
</body>
</html>
