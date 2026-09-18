<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS - University Management System</title>
    <meta name="description" content="Empowering education with UniTRS. The modern University Management System for students, professors, and administrators.">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-bg: #0d1b2a;
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
            --text-main: #ffffff;
            --text-muted: #a0aec0;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-main);
            overflow-x: hidden;
            background-image: 
                radial-gradient(circle at 15% 50%, rgba(79, 172, 254, 0.15), transparent 25%),
                radial-gradient(circle at 85% 30%, rgba(0, 242, 254, 0.15), transparent 25%);
        }

        /* --- Custom Navbar --- */
        .navbar-custom {
            background: rgba(13, 27, 42, 0.8);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--glass-border);
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: #ffffff !important;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar-brand i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-link-custom {
            color: var(--text-main);
            font-weight: 600;
            margin-left: 1rem;
            transition: color 0.3s ease;
        }

        .nav-link-custom:hover {
            color: #00f2fe;
        }

        .btn-glass {
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            color: #ffffff;
            padding: 0.5rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-glass:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 242, 254, 0.3);
            color: #ffffff;
        }

        .btn-gradient {
            background: var(--primary-gradient);
            border: none;
            color: #ffffff;
            padding: 0.5rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.4);
            color: #ffffff;
        }

        /* --- Hero Section --- */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding-top: 80px; /* offset navbar */
            position: relative;
        }

        .hero h1 {
            font-size: clamp(3rem, 8vw, 5rem);
            font-weight: 800;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #ffffff 0%, #a0aec0 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: fadeInUp 1s ease-out;
        }

        .hero p {
            font-size: clamp(1.1rem, 2.5vw, 1.4rem);
            color: var(--text-muted);
            max-width: 700px;
            margin: 0 auto 2.5rem;
            animation: fadeInUp 1s ease-out 0.2s both;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            animation: fadeInUp 1s ease-out 0.4s both;
        }

        .hero-buttons .btn {
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
        }

        /* --- Floating Shapes Animation --- */
        .shape {
            position: absolute;
            filter: blur(60px);
            z-index: -1;
            border-radius: 50%;
            animation: float 10s infinite alternate ease-in-out;
        }
        
        .shape-1 {
            width: 300px; height: 300px;
            background: rgba(79, 172, 254, 0.3);
            top: 20%; left: 10%;
        }

        .shape-2 {
            width: 400px; height: 400px;
            background: rgba(0, 242, 254, 0.2);
            bottom: 10%; right: 5%;
            animation-delay: -5s;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes float {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(30px, -50px) scale(1.1); }
        }

        /* --- Features Section --- */
        .features {
            padding: 5rem 2rem;
            background: rgba(0,0,0,0.2);
            border-top: 1px solid var(--glass-border);
        }

        .feature-card {
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2.5rem;
            height: 100%;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0, 242, 254, 0.1);
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: inline-block;
        }

        .feature-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .feature-text {
            color: var(--text-muted);
            line-height: 1.6;
        }

        /* --- Footer --- */
        .footer {
            padding: 2rem;
            text-align: center;
            border-top: 1px solid var(--glass-border);
            color: var(--text-muted);
            font-size: 0.9rem;
        }

    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-custom d-flex justify-content-between align-items-center">
        <a class="navbar-brand text-decoration-none" href="#">
            <i class="bi bi-mortarboard-fill"></i> UniTRS
        </a>
        <div class="d-flex align-items-center gap-3">
            <button id="pwaInstallBtn" class="btn btn-outline-info rounded-pill px-3 py-2 text-decoration-none" style="display: none;" onclick="window.promptPwaInstall()">
                <i class="bi bi-download me-1"></i> Install App
            </button>
            <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none nav-link-custom d-none d-md-block">Sign In</a>
            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-gradient text-decoration-none">Get Started</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        
        <div class="container">
            <h1>Empower Your Education</h1>
            <p>Welcome to UniTRS, the next-generation University Management System designed to seamlessly connect students, professors, and administrators.</p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-gradient rounded-pill text-decoration-none">Join Now</a>
                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-glass rounded-pill text-decoration-none">Sign In</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold" style="font-size: 2.5rem;">Why Choose UniTRS?</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="bi bi-shield-lock feature-icon"></i>
                        <h3 class="feature-title">Secure Platform</h3>
                        <p class="feature-text">Enterprise-grade security with robust authentication, role-based access control, and encrypted data protection.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="bi bi-speedometer2 feature-icon"></i>
                        <h3 class="feature-title">Real-time Insights</h3>
                        <p class="feature-text">Track academic progress, manage enrollments, and view performance analytics instantly through dynamic dashboards.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="bi bi-people feature-icon"></i>
                        <h3 class="feature-title">Unified Community</h3>
                        <p class="feature-text">A centralized hub that bridges the gap between students and faculty, streamlining communication and course management.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            &copy; 2026 UniTRS - University Management System. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
