<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KH Bank 프로젝트 관리</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .header {
            background: linear-gradient(135deg, #e4b6ec, #d196dd);
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 10px rgba(228, 182, 236, 0.3);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 24px;
            font-weight: bold;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e4b6ec;
            font-weight: bold;
        }

        .logo-icon img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .nav-menu {
            display: flex;
            gap: 30px;
            align-items: center;
        }

        .nav-item {
            padding: 10px 20px;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.1);
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
            position: relative;
        }

        .nav-item:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .nav-item.active {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2);
        }

        .nav-item.has-dropdown:hover .dropdown-menu {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            left: 0;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(228, 182, 236, 0.3);
            min-width: 200px;
            padding: 15px 0;
            margin-top: 10px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.4s ease;
            z-index: 1000;
        }

        .dropdown-item {
            display: block;
            padding: 12px 20px;
            color: #2d3748;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .dropdown-item:hover {
            background: #f8f4ff;
            color: #e4b6ec;
            border-left-color: #e4b6ec;
            transform: translateX(5px);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ff6b6b, #ffd93d);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .notification-badge {
            background: #ff4757;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            margin-left: 10px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
        }

        .page-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #2d3748;
        }

        .project-tabs {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            border-bottom: 2px solid #e2e8f0;
        }

        .tab {
            padding: 15px 25px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            font-weight: 600;
            color: #718096;
            transition: all 0.3s ease;
        }

        .tab.active {
            color: #e4b6ec;
            border-bottom-color: #e4b6ec;
        }

        .tab:hover {
            color: #e4b6ec;
        }

        .project-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .project-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .project-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(228, 182, 236, 0.15);
        }

        .project-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #e4b6ec, #d196dd);
        }

        .project-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .project-title {
            font-size: 18px;
            font-weight: bold;
            color: #2d3748;
            line-height: 1.4;
            flex: 1;
        }

        .project-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: #e6fffa;
            color: #00a085;
        }

        .status-planning {
            background: #e6f3ff;
            color: #0080ff;
        }

        .status-completed {
            background: #f0f4f8;
            color: #718096;
        }

        .project-info {
            margin-bottom: 20px;
        }

        .project-date {
            color: #718096;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .project-description {
            color: #4a5568;
            font-size: 14px;
            line-height: 1.5;
        }

        .project-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }

        .project-tech {
            display: flex;
            gap: 8px;
        }

        .tech-tag {
            background: #f7fafc;
            color: #4a5568;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .project-team {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .team-avatars {
            display: flex;
            margin-left: -8px;
        }

        .team-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 2px solid white;
            margin-left: -8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
        }

        .avatar-1 { background: linear-gradient(135deg, #667eea, #764ba2); }
        .avatar-2 { background: linear-gradient(135deg, #f093fb, #f5576c); }
        .avatar-3 { background: linear-gradient(135deg, #4facfe, #00f2fe); }
        .avatar-4 { background: linear-gradient(135deg, #43e97b, #38f9d7); }

        .add-project-card {
            background: linear-gradient(135deg, #f7fafc, #edf2f7);
            border: 2px dashed #cbd5e0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .add-project-card:hover {
            border-color: #e4b6ec;
            background: linear-gradient(135deg, #faf5ff, #f3e8ff);
            transform: translateY(-5px);
        }

        .add-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e4b6ec, #d196dd);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .add-text {
            color: #718096;
            font-weight: 600;
        }

        .search-bar {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 25px;
            padding: 12px 20px;
            width: 300px;
            font-size: 14px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .search-bar:focus {
            outline: none;
            border-color: #e4b6ec;
            box-shadow: 0 0 0 3px rgba(228, 182, 236, 0.1);
        }

        .stats-bar {
            display: flex;
            gap: 30px;
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: #e4b6ec;
        }

        .stat-label {
            color: #718096;
            font-size: 14px;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .nav-menu {
                display: none;
            }
            
            .project-grid {
                grid-template-columns: 1fr;
            }
            
            .header-content {
                flex-direction: column;
                gap: 20px;
            }
            
            .stats-bar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="logo">
                <div class="logo-icon">
                    <img src="https://media.discordapp.net/attachments/1399659042581774446/1404743980914184255/Logo2.png?ex=68a19347&is=68a041c7&hm=e6f891d93f66bbeda7edae1d7703054f3f8a663662bd6086427886d6f0f4ed14&=&format=webp&quality=lossless&width=646&height=646" alt="KH Bank Logo">
                </div>
                <span>KH BANK</span>
            </div>
            <nav class="nav-menu">
                <div class="nav-item active has-dropdown">
                    프로젝트 관리
                    <div class="dropdown-menu">
                        <a href="#" class="dropdown-item">📋 프로젝트 목록</a>
                        <a href="#" class="dropdown-item">✨ 프로젝트 생성</a>
                        <a href="#" class="dropdown-item">✏️ 프로젝트 수정/삭제</a>
                    </div>
                </div>
                <div class="nav-item">사내 일정</div>
                <div class="nav-item">고객 관리</div>
                <div class="nav-item">조직도</div>
                <div class="nav-item">결재 내역</div>
                <div class="nav-item">마이페이지</div>
            </nav>
            <div class="user-profile">
                <div class="notification-badge">3</div>
                <div class="profile-avatar">조</div>
                <span>조인순 부장</span>
            </div>
        </div>
    </header>

    <div class="container">
        <h1 class="page-title">>> 최근 프로젝트 목록</h1>
        
        <div class="stats-bar">
            <div class="stat-item">
                <div class="stat-number">12</div>
                <div class="stat-label">전체 프로젝트</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">5</div>
                <div class="stat-label">진행중</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">3</div>
                <div class="stat-label">계획중</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">4</div>
                <div class="stat-label">완료</div>
            </div>
        </div>

        <input type="text" class="search-bar" placeholder="프로젝트 검색...">

        <div class="project-tabs">
            <div class="tab active">전체 프로젝트</div>
            <div class="tab">진행 프로젝트</div>
            <div class="tab">완료 프로젝트</div>
        </div>

        <div class="project-grid">
            <div class="project-card">
                <div class="project-header">
                    <h3 class="project-title">KH BANK 뱅킹앱 모바일 UX, UI 최적화 개선</h3>
                    <span class="project-status status-active">진행</span>
                </div>
                <div class="project-info">
                    <div class="project-date">작업일: 8.11, 2025</div>
                    <div class="project-description">작성자: 개발팀 조인순 부장</div>
                </div>
                <div class="project-footer">
                    <div class="project-tech">
                        <span class="tech-tag">Java</span>
                        <span class="tech-tag">Oracle</span>
                        <span class="tech-tag">CSS</span>
                    </div>
                    <div class="project-team">
                        <div class="team-avatars">
                            <div class="team-avatar avatar-1">조</div>
                            <div class="team-avatar avatar-2">김</div>
                            <div class="team-avatar avatar-3">이</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="project-card">
                <div class="project-header">
                    <h3 class="project-title">8월 신규기업 카카오포토 재크카드 발급 프로모션</h3>
                    <span class="project-status status-planning">기획</span>
                </div>
                <div class="project-info">
                    <div class="project-date">작성일: 7.17, 2025</div>
                    <div class="project-description">작성자: 영업팀 김경식 과장</div>
                </div>
                <div class="project-footer">
                    <div class="project-tech">
                        <span class="tech-tag">HTML</span>
                        <span class="tech-tag">CSS</span>
                        <span class="tech-tag">Java</span>
                    </div>
                    <div class="project-team">
                        <div class="team-avatars">
                            <div class="team-avatar avatar-2">김</div>
                            <div class="team-avatar avatar-4">박</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="project-card">
                <div class="project-header">
                    <h3 class="project-title">8월 신규기업 카카오포토 재크카드 발급 프로모션</h3>
                    <span class="project-status status-planning">기획</span>
                </div>
                <div class="project-info">
                    <div class="project-date">작성일: 7.17, 2025</div>
                    <div class="project-description">작성자: 영업팀 김경식 과장</div>
                </div>
                <div class="project-footer">
                    <div class="project-tech">
                        <span class="tech-tag">Oracle</span>
                        <span class="tech-tag">Java</span>
                    </div>
                    <div class="project-team">
                        <div class="team-avatars">
                            <div class="team-avatar avatar-3">이</div>
                            <div class="team-avatar avatar-1">조</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="project-card">
                <div class="project-header">
                    <h3 class="project-title">모바일 가계부 앱 쉬움을 런칭 신바 개발</h3>
                    <span class="project-status status-active">진행</span>
                </div>
                <div class="project-info">
                    <div class="project-date">작성일: 8.11, 2025</div>
                    <div class="project-description">작성자: 개발팀 조인순 부장</div>
                </div>
                <div class="project-footer">
                    <div class="project-tech">
                        <span class="tech-tag">HTML</span>
                        <span class="tech-tag">CSS</span>
                        <span class="tech-tag">Java</span>
                        <span class="tech-tag">Oracle</span>
                    </div>
                    <div class="project-team">
                        <div class="team-avatars">
                            <div class="team-avatar avatar-1">조</div>
                            <div class="team-avatar avatar-2">김</div>
                            <div class="team-avatar avatar-3">이</div>
                            <div class="team-avatar avatar-4">박</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="project-card">
                <div class="project-header">
                    <h3 class="project-title">KH BANK 인솔금 DB 데이터 최적화</h3>
                    <span class="project-status status-completed">완료</span>
                </div>
                <div class="project-info">
                    <div class="project-date">작성일: 8.5, 2025</div>
                    <div class="project-description">작성자: 개발팀 조인순 부장</div>
                </div>
                <div class="project-footer">
                    <div class="project-tech">
                        <span class="tech-tag">Oracle</span>
                        <span class="tech-tag">Java</span>
                        <span class="tech-tag">SQL</span>
                    </div>
                    <div class="project-team">
                        <div class="team-avatars">
                            <div class="team-avatar avatar-2">김</div>
                            <div class="team-avatar avatar-3">이</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="project-card">
                <div class="project-header">
                    <h3 class="project-title">고객 관리 시스템 업그레이드</h3>
                    <span class="project-status status-active">진행</span>
                </div>
                <div class="project-info">
                    <div class="project-date">작업일: 7.20, 2025</div>
                    <div class="project-description">작성자: 영업팀 김경식 과장</div>
                </div>
                <div class="project-footer">
                    <div class="project-tech">
                        <span class="tech-tag">Java</span>
                        <span class="tech-tag">Oracle</span>
                        <span class="tech-tag">HTML</span>
                    </div>
                    <div class="project-team">
                        <div class="team-avatars">
                            <div class="team-avatar avatar-1">조</div>
                            <div class="team-avatar avatar-4">박</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="add-project-card project-card">
                <div class="add-icon">+</div>
                <div class="add-text">새 프로젝트 추가</div>
            </div>
        </div>
    </div>

    <script>
        // 탭 클릭 이벤트
        document.querySelectorAll('.tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // 검색 기능
        document.querySelector('.search-bar').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            document.querySelectorAll('.project-card').forEach(card => {
                if (!card.classList.contains('add-project-card')) {
                    const title = card.querySelector('.project-title').textContent.toLowerCase();
                    const description = card.querySelector('.project-description').textContent.toLowerCase();
                    
                    if (title.includes(searchTerm) || description.includes(searchTerm)) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                }
            });
        });

        // 새 프로젝트 추가 클릭
        document.querySelector('.add-project-card').addEventListener('click', function() {
            alert('새 프로젝트 추가 기능');
        });

        // 프로젝트 카드 클릭
        document.querySelectorAll('.project-card:not(.add-project-card)').forEach(card => {
            card.addEventListener('click', function() {
                const title = this.querySelector('.project-title').textContent;
                alert(`${title} 프로젝트 상세 페이지로 이동`);
            });
        });
    </script>
</body>
</html>