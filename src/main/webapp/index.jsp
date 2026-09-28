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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;700;800&display=swap" rel="stylesheet">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />

    <style>
        :root {
            /* Brightened gradients for perfect contrast against dark backgrounds */
            --primary-gradient: linear-gradient(135deg, #00f2fe 0%, #4facfe 100%);
            --secondary-gradient: linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%);
            --dark-bg: #0b1423; /* Slightly deeper for better text contrast */
            --section-bg: #111c30;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.12);
            --text-main: #f8fafc; /* Brighter white */
            --text-muted: #cbd5e1; /* Brighter gray for readability */
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-main);
            overflow-x: hidden;
        }

        /* Ambient Background Animations */
        .ambient-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: -1;
            background: radial-gradient(circle at 15% 50%, rgba(79, 172, 254, 0.08), transparent 40%),
                        radial-gradient(circle at 85% 30%, rgba(0, 242, 254, 0.08), transparent 40%);
            pointer-events: none;
        }

        /* Typography Tools */
        .text-gradient {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: inline-block; /* Prevents clipping bugs on wrapping */
        }
        .text-gradient-alt {
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: inline-block;
        }

        /* --- Custom Navbar --- */
        .navbar-custom {
            background: rgba(11, 20, 35, 0.9);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-bottom: 1px solid var(--glass-border);
            padding: 1rem 0;
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

        .nav-link-custom {
            color: var(--text-main) !important;
            font-weight: 500;
            margin: 0 0.5rem;
            transition: color 0.3s ease;
        }

        .nav-link-custom:hover {
            color: #00f2fe !important;
        }

        /* Mobile Navbar adjustments */
        @media (max-width: 991px) {
            .navbar-collapse {
                background: var(--section-bg);
                padding: 1.5rem;
                border-radius: 12px;
                margin-top: 1rem;
                border: 1px solid var(--glass-border);
                box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            }
            .nav-link-custom {
                margin: 0.5rem 0;
                font-size: 1.1rem;
            }
        }

        /* Buttons */
        .btn-glass {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid var(--glass-border);
            color: #ffffff !important;
            padding: 0.6rem 1.8rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-glass:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
            color: #ffffff;
        }

        .btn-gradient {
            background: var(--primary-gradient);
            border: none;
            color: #111c30 !important; /* Dark text for high contrast on bright gradient */
            padding: 0.6rem 1.8rem;
            border-radius: 50px;
            font-weight: 700;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 242, 254, 0.2);
        }
        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 242, 254, 0.4);
            color: #111c30 !important;
        }

        /* --- Hero Section 1 (Main) --- */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding-top: 100px;
            position: relative;
        }

        .hero h1 {
            font-size: clamp(2.5rem, 7vw, 4.5rem); /* Better mobile scaling */
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            color: #ffffff;
        }

        .hero p {
            font-size: clamp(1.1rem, 2vw, 1.25rem);
            color: var(--text-muted);
            max-width: 600px;
            margin-bottom: 2.5rem;
            line-height: 1.7;
        }

        .hero-img-wrapper {
            position: relative;
            z-index: 1;
            margin-top: 2rem;
        }
        .hero-img-wrapper::before {
            content: '';
            position: absolute;
            top: -10%; left: -10%; right: -10%; bottom: -10%;
            background: radial-gradient(circle, rgba(0,242,254,0.15) 0%, transparent 60%);
            z-index: -1;
        }
        .hero-dashboard-mock {
            background: rgba(17, 34, 64, 0.9);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
            backdrop-filter: blur(10px);
            transform: perspective(1000px) rotateY(-5deg) rotateX(5deg);
            transition: transform 0.5s ease;
        }
        .hero-dashboard-mock:hover {
            transform: perspective(1000px) rotateY(0deg) rotateX(0deg);
        }

        @media (max-width: 991px) {
            .hero-dashboard-mock {
                transform: none; /* Disable 3D on mobile for better visibility */
            }
            .hero {
                padding-top: 120px;
                padding-bottom: 4rem;
                text-align: center;
            }
            .hero p { margin: 0 auto 2.5rem; }
            .hero .d-flex { justify-content: center; }
        }

        /* --- Hero Section 2 (Vision) --- */
        .vision-section {
            padding: 6rem 0;
            background: var(--section-bg);
            position: relative;
            border-top: 1px solid var(--glass-border);
            border-bottom: 1px solid var(--glass-border);
        }
        .vision-section h2 {
            font-size: clamp(2rem, 5vw, 3.5rem);
            font-weight: 800;
            margin-bottom: 1.5rem;
            color: #ffffff;
        }

        /* --- Roles Showcase --- */
        .showcase-section {
            padding: 6rem 0;
            position: relative;
        }
        .showcase-block {
            margin-bottom: 5rem;
            display: flex;
            align-items: center;
            gap: 4rem;
        }
        .showcase-block:nth-child(even) {
            flex-direction: row-reverse;
        }
        @media (max-width: 992px) {
            .showcase-block, .showcase-block:nth-child(even) {
                flex-direction: column;
                gap: 2.5rem;
                text-align: center;
            }
            .showcase-icon-wrapper { margin: 0 auto 1.5rem; }
        }
        .showcase-content h3 {
            font-size: clamp(2rem, 4vw, 2.5rem);
            font-weight: 700;
            margin-bottom: 1rem;
            color: #ffffff;
        }
        .showcase-content p {
            color: var(--text-muted);
            font-size: 1.1rem;
            line-height: 1.7;
        }
        .showcase-icon-wrapper {
            width: 70px; height: 70px;
            border-radius: 20px;
            background: rgba(0, 242, 254, 0.1);
            border: 1px solid rgba(0, 242, 254, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            color: #00f2fe;
        }

        .showcase-visual {
            flex: 1;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 3rem;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            width: 100%;
        }
        
        /* Fixed icon visibility */
        .showcase-visual i {
            font-size: clamp(6rem, 15vw, 10rem);
            color: rgba(255, 255, 255, 0.05); /* Solid transparent instead of gradient for reliable contrast */
            text-shadow: 0 0 20px rgba(0, 242, 254, 0.1);
        }

        /* --- Bento Features Grid --- */
        .features {
            padding: 6rem 0;
            background: var(--section-bg);
            border-top: 1px solid var(--glass-border);
        }
        .bento-grid {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: 1.5rem;
        }
        .bento-card {
            background: rgba(255,255,255,0.03);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 2.5rem;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        .bento-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: radial-gradient(800px circle at var(--mouse-x, 50%) var(--mouse-y, 50%), rgba(255,255,255,0.08), transparent 40%);
            opacity: 0;
            transition: opacity 0.3s;
            z-index: 0;
            pointer-events: none;
        }
        .bento-card:hover::before { opacity: 1; }
        .bento-card:hover {
            transform: translateY(-5px);
            border-color: rgba(0, 242, 254, 0.4);
            box-shadow: 0 10px 30px rgba(0, 242, 254, 0.1);
        }
        .bento-card > * { position: relative; z-index: 1; }
        .bento-span-8 { grid-column: span 8; }
        .bento-span-4 { grid-column: span 4; }
        .bento-span-6 { grid-column: span 6; }
        
        @media (max-width: 992px) {
            .bento-span-8, .bento-span-4, .bento-span-6 { grid-column: span 12; }
            .bento-card { padding: 2rem; }
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            color: #00f2fe;
            display: inline-block;
        }
        .feature-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #ffffff;
        }
        .feature-text {
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 0;
        }

        /* --- Footer --- */
        .footer-custom {
            background: #060b13; /* Very dark for distinct footer */
            padding: 5rem 0 2rem;
            border-top: 1px solid var(--glass-border);
        }
        .footer-brand {
            font-size: 1.8rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .footer-brand i { color: #00f2fe; }
        .footer-desc {
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 2rem;
            max-width: 300px;
        }
        .footer-title {
            color: #ffffff;
            font-weight: 700;
            margin-bottom: 1.5rem;
            font-size: 1.1rem;
        }
        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .footer-links li { margin-bottom: 0.8rem; }
        .footer-links a {
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.3s;
        }
        .footer-links a:hover { color: #00f2fe; }
        .social-icons a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px; height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--glass-border);
            color: #ffffff;
            margin-right: 0.5rem;
            transition: all 0.3s;
        }
        .social-icons a:hover {
            background: var(--primary-gradient);
            border-color: transparent;
            transform: translateY(-3px);
            color: #111c30;
        }
        .footer-bottom {
            margin-top: 4rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.05);
            text-align: center;
            color: #64748b;
            font-size: 0.9rem;
        }
    </style>
</head>

<body>
    <!-- Ambient Background -->
    <div class="ambient-bg"></div>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand text-decoration-none" href="#">
                <i class="bi bi-mortarboard-fill"></i> UniTRS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" style="border-color: rgba(255,255,255,0.15);">
                <span class="bi bi-list text-white" style="font-size: 1.7rem;"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#vision">Our Vision</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#showcase">Roles</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#features">Features</a></li>
                </ul>
                <div class="d-flex align-items-center gap-3 mt-3 mt-lg-0 justify-content-center justify-content-lg-start">
                    <button id="pwaInstallBtn" class="btn btn-glass btn-sm rounded-pill px-3 py-2 text-decoration-none" style="display: none;" onclick="window.promptPwaInstall()">
                        <i class="bi bi-download me-1"></i> App
                    </button>
                    <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none text-white fw-bold mx-2">Sign In</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-gradient text-decoration-none">Get Started</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section 1 (Main) -->
    <section class="hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-5 mb-lg-0">
                    <h1>The Modern <br><span class="text-gradient">Academic Core</span></h1>
                    <p>UniTRS bridges the gap between students, educators, and administrators with a secure, 4-tier Jakarta EE architecture. Experience the future of university management today.</p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-gradient">Join the Network</a>
                        <a href="#showcase" class="btn btn-glass">Explore Roles</a>
                    </div>
                </div>
                <div class="col-lg-6 d-none d-md-block">
                    <div class="hero-img-wrapper">
                        <div class="hero-dashboard-mock">
                            <!-- Abstract UI Mockup -->
                            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary pb-3">
                                <div class="d-flex align-items-center gap-2">
                                    <div style="width:30px;height:30px;border-radius:50%;background:var(--primary-gradient);"></div>
                                    <div style="width:100px;height:10px;background:#334155;border-radius:5px;"></div>
                                </div>
                                <div style="width:60px;height:20px;background:#334155;border-radius:10px;"></div>
                            </div>
                            <div class="row g-3 mb-4">
                                <div class="col-4"><div style="height:80px;background:rgba(255,255,255,0.05);border-radius:10px;padding:15px;"><div style="width:40px;height:40px;background:rgba(0,242,254,0.3);border-radius:8px;margin-bottom:10px;"></div></div></div>
                                <div class="col-4"><div style="height:80px;background:rgba(255,255,255,0.05);border-radius:10px;padding:15px;"><div style="width:40px;height:40px;background:rgba(166,193,238,0.3);border-radius:8px;margin-bottom:10px;"></div></div></div>
                                <div class="col-4"><div style="height:80px;background:rgba(255,255,255,0.05);border-radius:10px;padding:15px;"><div style="width:40px;height:40px;background:rgba(255,255,255,0.15);border-radius:8px;margin-bottom:10px;"></div></div></div>
                            </div>
                            <div style="height:120px;background:rgba(255,255,255,0.03);border-radius:10px;border:1px dashed rgba(255,255,255,0.15);"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Hero Section 2 (Vision) -->
    <section id="vision" class="vision-section text-center">
        <div class="container">
            <h2 class="text-white">Transforming <br class="d-md-none"><span class="text-gradient-alt">Education</span></h2>
            <p class="lead text-muted mx-auto mt-3" style="max-width: 800px;">
                Legacy systems slow down academic progress. We built UniTRS from the ground up using robust Jakarta EE technologies to deliver real-time transcripts, seamless enrollment, and zero-friction communication between faculties.
            </p>
        </div>
    </section>

    <!-- Showcase Section (Roles) -->
    <section id="showcase" class="showcase-section">
        <div class="container">
            <div class="text-center mb-5 pb-4">
                <h2 class="fw-bold text-white">Dedicated Workspaces</h2>
                <p class="text-muted">Four distinct portals. One unified ecosystem.</p>
            </div>

            <!-- Student Block -->
            <div class="showcase-block">
                <div class="showcase-visual">
                    <i class="bi bi-backpack4"></i>
                </div>
                <div class="showcase-content flex-grow-1">
                    <div class="showcase-icon-wrapper"><i class="bi bi-person-badge"></i></div>
                    <h3>Student Portal</h3>
                    <p>Designed for clarity and speed. Register via University ID, verify your identity, and access the Batch Term Enrollment system. View your real-time weekly schedule and track a live GPA transcript across all 4 assessment components.</p>
                    <ul class="list-unstyled text-muted mt-3">
                        <li><i class="bi bi-check-circle-fill text-info me-2"></i> Instant Batch Term Registration</li>
                        <li><i class="bi bi-check-circle-fill text-info me-2"></i> Real-time Grades & GPA</li>
                        <li><i class="bi bi-check-circle-fill text-info me-2"></i> PWA Support for Mobile Access</li>
                    </ul>
                </div>
            </div>

            <!-- Professor Block -->
            <div class="showcase-block">
                <div class="showcase-visual">
                    <i class="bi bi-easel"></i>
                </div>
                <div class="showcase-content flex-grow-1">
                    <div class="showcase-icon-wrapper" style="color: #a6c1ee; border-color: rgba(166,193,238,0.3); background: rgba(166,193,238,0.1);"><i class="bi bi-person-workspace"></i></div>
                    <h3>Professor Portal</h3>
                    <p>Streamline your teaching workflow. View assigned morning, afternoon, evening, or weekend sections. Manage class rosters, track daily attendance, and input continuous assessments with automatic letter grade calculations.</p>
                    <ul class="list-unstyled text-muted mt-3">
                        <li><i class="bi bi-check-circle-fill text-primary me-2"></i> 4-Component Grade Management</li>
                        <li><i class="bi bi-check-circle-fill text-primary me-2"></i> Daily Attendance Tracking</li>
                        <li><i class="bi bi-check-circle-fill text-primary me-2"></i> Excel Roster Exports</li>
                    </ul>
                </div>
            </div>

            <!-- Dean Block -->
            <div class="showcase-block">
                <div class="showcase-visual">
                    <i class="bi bi-bank"></i>
                </div>
                <div class="showcase-content flex-grow-1">
                    <div class="showcase-icon-wrapper" style="color: #f6e05e; border-color: rgba(246,224,94,0.3); background: rgba(246,224,94,0.1);"><i class="bi bi-award"></i></div>
                    <h3>Dean & Administration</h3>
                    <p>Govern the academic structure. Bundle courses into specific terms, allocate physical rooms and professors, and review pending student enrollment requests for cohorts under your faculty.</p>
                    <ul class="list-unstyled text-muted mt-3">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Term-Course Bundling</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Room & Capacity Scheduling</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Faculty Governance</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Bento Features Section -->
    <section id="features" class="features">
        <div class="container">
            <div class="text-center mb-5 pb-3">
                <h2 class="fw-bold text-white">Under The Hood</h2>
                <p class="text-muted">Built with security and scale in mind.</p>
            </div>
            
            <div class="bento-grid">
                <!-- Large Security Card -->
                <div class="bento-card bento-span-8">
                    <i class="bi bi-shield-check feature-icon"></i>
                    <h3 class="feature-title">Bank-Grade Security</h3>
                    <p class="feature-text">BCrypt password hashing combined with a custom Two-Factor Authentication (2FA) and OTP flow via Email ensures only authorized personnel access academic records. Role-based routing prevents privilege escalation.</p>
                </div>

                <!-- Small Analytics -->
                <div class="bento-card bento-span-4">
                    <i class="bi bi-graph-up-arrow feature-icon"></i>
                    <h3 class="feature-title">Smart Grading</h3>
                    <p class="feature-text">Automated calculations for Attendance (15%), Assignments (25%), Midterm (30%), and Final (30%) straight to a standardized GPA metric.</p>
                </div>

                <!-- Medium Workflow -->
                <div class="bento-card bento-span-6">
                    <i class="bi bi-calendar-range feature-icon"></i>
                    <h3 class="feature-title">Shift-Based Scheduling</h3>
                    <p class="feature-text">Comprehensive scheduling accommodating Morning, Afternoon, Evening, and Weekend shifts across multiple academic years and physical room constraints.</p>
                </div>

                <!-- Medium PWA -->
                <div class="bento-card bento-span-6">
                    <i class="bi bi-phone feature-icon"></i>
                    <h3 class="feature-title">Installable PWA</h3>
                    <p class="feature-text">Native-like mobile experience. Install the UniTRS portal directly to your device home screen for quick, reliable access anytime.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer-custom">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-4 text-center text-lg-start">
                    <div class="footer-brand justify-content-center justify-content-lg-start">
                        <i class="bi bi-mortarboard-fill"></i> UniTRS
                    </div>
                    <p class="footer-desc mx-auto mx-lg-0">A modern, robust University Management System built with Jakarta EE 10 to streamline academic operations globally.</p>
                    <div class="social-icons justify-content-center justify-content-lg-start d-flex">
                        <a href="#"><i class="bi bi-github"></i></a>
                        <a href="#"><i class="bi bi-twitter-x"></i></a>
                        <a href="#"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 offset-lg-2 col-md-4 text-center text-md-start">
                    <h4 class="footer-title">Platform</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/auth/login">Student Portal</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth/login">Faculty Portal</a></li>
                        <li><a href="#features">Features</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4 text-center text-md-start">
                    <h4 class="footer-title">Company</h4>
                    <ul class="footer-links">
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Careers</a></li>
                        <li><a href="#">Contact Support</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4 text-center text-md-start">
                    <h4 class="footer-title">Legal</h4>
                    <ul class="footer-links">
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                        <li><a href="#">Security</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                &copy; 2026 UniTRS Project - ITE204 Java Enterprise Edition. All rights reserved.
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple glow effect for bento cards tracking mouse movement
        document.querySelectorAll('.bento-card').forEach(card => {
            card.addEventListener('mousemove', e => {
                const rect = card.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                card.style.setProperty('--mouse-x', x + 'px');
                card.style.setProperty('--mouse-y', y + 'px');
            });
        });
    </script>
</body>
</html>