<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniTRS | University Management System</title>
    <meta name="description" content="UniTRS: The dedicated University Management System. Streamlining academics with a high-density, calm design architecture.">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <jsp:include page="/WEB-INF/views/common/pwa_head.jsp" />

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #00f2fe 0%, #4facfe 100%);
            --secondary-gradient: linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%);
            --dark-bg: #090e17; 
            --section-bg: #0d1522;
            --glass-bg: rgba(255, 255, 255, 0.03);
            --glass-border: rgba(255, 255, 255, 0.08);
            --text-main: #f8fafc; 
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-main);
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }

        .text-muted { color: #94a3b8 !important; }
        .text-light-muted { color: #cbd5e1 !important; }

        /* --- Performance-Optimized CSS Animations --- */
        @keyframes slideUpFade {
            0% { opacity: 0; transform: translateY(30px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .animate-up {
            animation: slideUpFade 0.7s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            opacity: 0;
        }
        .delay-100 { animation-delay: 100ms; }
        .delay-200 { animation-delay: 200ms; }
        .delay-300 { animation-delay: 300ms; }
        .delay-400 { animation-delay: 400ms; }

        /* Ambient Background */
        .ambient-bg {
            position: fixed;
            top: 0; left: 0; width: 100vw; height: 100vh;
            z-index: -1;
            background: radial-gradient(circle at 15% 50%, rgba(79, 172, 254, 0.06), transparent 40%),
                        radial-gradient(circle at 85% 30%, rgba(0, 242, 254, 0.06), transparent 40%);
            pointer-events: none;
        }

        .text-gradient {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: inline-block;
        }

        /* --- Custom Navbar --- */
        .navbar-custom {
            background: rgba(9, 14, 23, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--glass-border);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.4rem;
            color: #ffffff !important;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link-custom {
            color: var(--text-muted) !important;
            font-weight: 500;
            font-size: 0.95rem;
            margin: 0 0.8rem;
            transition: color 0.2s ease;
        }
        .nav-link-custom:hover { color: #f8fafc !important; }

        @media (max-width: 991px) {
            .navbar-collapse {
                background: var(--section-bg);
                padding: 1.5rem;
                border-radius: 12px;
                margin-top: 1rem;
                border: 1px solid var(--glass-border);
            }
        }

        /* Buttons */
        .btn-glass {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            color: #ffffff !important;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }
        .btn-glass:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-1px);
        }

        .btn-gradient {
            background: var(--primary-gradient);
            border: none;
            color: #090e17 !important;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 15px rgba(0, 242, 254, 0.15);
        }
        .btn-gradient:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(0, 242, 254, 0.3);
        }

        /* --- Hero Section --- */
        .hero {
            min-height: 90vh;
            display: flex;
            align-items: center;
            padding-top: 120px;
            position: relative;
        }

        .hero h1 {
            font-size: clamp(2.5rem, 5vw, 4rem);
            font-weight: 800;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            letter-spacing: -0.02em;
        }

        .hero p {
            font-size: clamp(1.05rem, 1.5vw, 1.15rem);
            max-width: 600px;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        /* High-Density Mockup UI */
        .mockup-container {
            background: rgba(13, 21, 34, 0.8);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(20px);
            position: relative;
        }
        .mockup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--glass-border);
        }
        .mockup-row {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            background: rgba(255,255,255,0.02);
            border-radius: 8px;
            margin-bottom: 0.5rem;
            border: 1px solid transparent;
            transition: background 0.2s;
        }
        .mockup-row:hover {
            background: rgba(255,255,255,0.05);
            border-color: var(--glass-border);
        }
        .skeleton-avatar { width: 32px; height: 32px; border-radius: 50%; background: var(--primary-gradient); opacity: 0.8; }
        .skeleton-line { height: 8px; border-radius: 4px; background: rgba(255,255,255,0.2); }
        .skeleton-pill { height: 20px; width: 60px; border-radius: 12px; background: rgba(0,242,254,0.15); border: 1px solid rgba(0,242,254,0.3); }

        /* Fast Data Ribbon */
        .data-ribbon {
            display: flex;
            gap: 3rem;
            margin-top: 3rem;
            border-top: 1px solid var(--glass-border);
            padding-top: 2rem;
        }
        .data-stat { display: flex; flex-direction: column; }
        .data-stat-num { font-size: 1.5rem; font-weight: 700; color: #fff; }
        .data-stat-label { font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; font-weight: 600; }

        @media (max-width: 991px) {
            .hero { padding-top: 100px; text-align: center; }
            .hero p { margin: 0 auto 2rem; }
            .hero .d-flex.gap-3 { justify-content: center; }
            .data-ribbon { justify-content: center; flex-wrap: wrap; gap: 2rem; }
            .mockup-container { margin-top: 3rem; }
        }

        /* --- Showcase Section (Roles zig-zag) --- */
        .showcase-section {
            padding: 8rem 0;
            position: relative;
            background: var(--section-bg);
            border-top: 1px solid var(--glass-border);
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
        
        .showcase-visual i.bg-icon {
            font-size: clamp(6rem, 15vw, 10rem);
            color: rgba(255, 255, 255, 0.05); 
            text-shadow: 0 0 20px rgba(0, 242, 254, 0.1);
        }

        /* --- Information Dense Architecture Section --- */
        .architecture-section {
            padding: 8rem 0;
            background: var(--dark-bg);
        }
        .arch-header {
            max-width: 600px;
            margin-bottom: 4rem;
        }
        .arch-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        .arch-card {
            background: rgba(255,255,255,0.02);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            padding: 2rem;
            transition: all 0.3s ease;
        }
        .arch-card:hover {
            background: rgba(255,255,255,0.04);
            border-color: rgba(0,242,254,0.3);
        }
        .arch-icon {
            width: 48px; height: 48px;
            border-radius: 12px;
            background: rgba(0,242,254,0.1);
            color: #00f2fe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .arch-card h4 { font-size: 1.2rem; font-weight: 700; margin-bottom: 0.75rem; color: #fff; }
        .arch-card p { font-size: 0.95rem; color: var(--text-muted); line-height: 1.6; margin: 0; }

        /* --- Dense Data Table Preview Section --- */
        .preview-section {
            padding: 8rem 0;
            position: relative;
            background: var(--section-bg);
            border-top: 1px solid var(--glass-border);
        }
        .preview-bento {
            background: rgba(13, 21, 34, 0.5);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 3rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }
        .feature-list { list-style: none; padding: 0; margin: 2rem 0 0; }
        .feature-list li {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }
        .feature-list i { color: #00f2fe; font-size: 1.2rem; margin-right: 1rem; margin-top: 2px; }
        .feature-list div h5 { font-size: 1.05rem; color: #fff; margin-bottom: 0.25rem; font-weight: 600; }
        .feature-list div p { font-size: 0.9rem; color: var(--text-muted); margin: 0; line-height: 1.5; }

        @media (max-width: 991px) {
            .preview-bento { grid-template-columns: 1fr; padding: 2rem; gap: 2rem; }
        }

        /* --- Footer --- */
        .footer-custom {
            background: #060a10; 
            padding: 4rem 0 2rem;
            border-top: 1px solid var(--glass-border);
        }
        .footer-title { color: #fff; font-weight: 600; font-size: 0.95rem; margin-bottom: 1.25rem; }
        .footer-links { list-style: none; padding: 0; margin: 0; }
        .footer-links li { margin-bottom: 0.75rem; }
        .footer-links a { color: var(--text-muted); text-decoration: none; font-size: 0.9rem; transition: color 0.2s; }
        .footer-links a:hover { color: #00f2fe; }
    </style>
</head>

<body>
    <!-- Ambient Background -->
    <div class="ambient-bg"></div>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand text-decoration-none animate-up" href="#">
                <i class="bi bi-mortarboard-fill text-gradient"></i> UniTRS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" style="border: none;">
                <i class="bi bi-list text-white fs-2"></i>
            </button>
            <div class="collapse navbar-collapse animate-up delay-100" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#showcase">Portals</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#architecture">Architecture</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#capabilities">Security</a></li>
                </ul>
                <div class="d-flex align-items-center gap-3 mt-3 mt-lg-0 justify-content-center justify-content-lg-start">
                    <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none text-muted fw-semibold hover-white">Sign In</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-glass">Portal</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="animate-up">
                        <span class="badge bg-dark border border-secondary text-light-muted mb-3 px-3 py-2 rounded-pill fw-medium" style="font-size: 0.8rem;">
                            <i class="bi bi-lightning-charge-fill text-warning me-1"></i> Jakarta EE 10 Powered
                        </span>
                        <h1>Calm Design for <br><span class="text-gradient">Complex Academics</span></h1>
                        <p class="text-light-muted">UniTRS cuts through administrative noise. Designed exclusively for the modern academic model, connecting thousands of students and faculties through a high-density, low-friction portal.</p>
                    </div>
                    
                    <div class="d-flex gap-3 flex-wrap animate-up delay-100">
                        <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-gradient">Open Dashboard</a>
                        <a href="#showcase" class="btn btn-glass">Read Docs</a>
                    </div>

                    <div class="data-ribbon animate-up delay-200">
                        <div class="data-stat">
                            <span class="data-stat-num">4,000+</span>
                            <span class="data-stat-label">Active Students</span>
                        </div>
                        <div class="data-stat">
                            <span class="data-stat-num">12</span>
                            <span class="data-stat-label">Colleges & Schools</span>
                        </div>
                        <div class="data-stat">
                            <span class="data-stat-num">4-Tier</span>
                            <span class="data-stat-label">Architecture</span>
                        </div>
                    </div>
                </div>

                <!-- High-Density SaaS Mockup -->
                <div class="col-lg-6 d-none d-lg-block animate-up delay-300">
                    <div class="mockup-container">
                        <!-- Header -->
                        <div class="mockup-header">
                            <div>
                                <div class="skeleton-line mb-2" style="width: 140px; background: #fff; height: 12px;"></div>
                                <div class="skeleton-line" style="width: 80px; height: 8px;"></div>
                            </div>
                            <div class="d-flex gap-2">
                                <div style="width: 32px; height: 32px; border-radius: 6px; background: rgba(255,255,255,0.05); border: 1px solid var(--glass-border);"></div>
                                <div style="width: 80px; height: 32px; border-radius: 6px; background: var(--primary-gradient);"></div>
                            </div>
                        </div>
                        
                        <!-- Filter Bar -->
                        <div class="d-flex gap-2 mb-3">
                            <div class="skeleton-line" style="width: 60px; height: 24px; border-radius: 12px;"></div>
                            <div class="skeleton-line" style="width: 80px; height: 24px; border-radius: 12px;"></div>
                            <div class="skeleton-line" style="width: 50px; height: 24px; border-radius: 12px; background: rgba(0,242,254,0.1);"></div>
                        </div>

                        <!-- Data Rows -->
                        <div class="mockup-row">
                            <div class="skeleton-avatar me-3"></div>
                            <div class="flex-grow-1">
                                <div class="skeleton-line mb-1" style="width: 120px;"></div>
                                <div class="skeleton-line" style="width: 70px; opacity: 0.5;"></div>
                            </div>
                            <div class="skeleton-pill"></div>
                        </div>
                        <div class="mockup-row">
                            <div class="skeleton-avatar me-3" style="background: rgba(255,255,255,0.1);"></div>
                            <div class="flex-grow-1">
                                <div class="skeleton-line mb-1" style="width: 150px;"></div>
                                <div class="skeleton-line" style="width: 90px; opacity: 0.5;"></div>
                            </div>
                            <div class="skeleton-pill" style="background: rgba(255,255,255,0.1); border-color: transparent;"></div>
                        </div>
                        <div class="mockup-row">
                            <div class="skeleton-avatar me-3" style="background: rgba(255,255,255,0.1);"></div>
                            <div class="flex-grow-1">
                                <div class="skeleton-line mb-1" style="width: 110px;"></div>
                                <div class="skeleton-line" style="width: 60px; opacity: 0.5;"></div>
                            </div>
                            <div class="skeleton-pill" style="background: rgba(255,255,255,0.1); border-color: transparent;"></div>
                        </div>
                        <div class="mockup-row" style="opacity: 0.5;">
                            <div class="skeleton-avatar me-3" style="background: rgba(255,255,255,0.05);"></div>
                            <div class="flex-grow-1">
                                <div class="skeleton-line mb-1" style="width: 130px;"></div>
                                <div class="skeleton-line" style="width: 80px; opacity: 0.5;"></div>
                            </div>
                            <div class="skeleton-pill" style="background: transparent; border-color: var(--glass-border);"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Showcase Section (Roles Zig-Zag Feature Telling) -->
    <section id="showcase" class="showcase-section">
        <div class="container">
            <div class="text-center mb-5 pb-4 animate-up">
                <h2 class="fw-bold text-white">Unified Academic Portals</h2>
                <p class="text-light-muted">Connecting every college and school across the university.</p>
            </div>

            <!-- Student Block -->
            <div class="showcase-block animate-up delay-100">
                <div class="showcase-visual">
                    <i class="bi bi-backpack4 bg-icon"></i>
                </div>
                <div class="showcase-content flex-grow-1">
                    <div class="showcase-icon-wrapper"><i class="bi bi-person-badge"></i></div>
                    <h3>Student Portal</h3>
                    <p class="text-light-muted">Register via your official University ID. Access our streamlined Batch Term Enrollment system, view your weekly schedule, and track a live GPA transcript across all assessments, whether you're in the College of Law or the School of Business.</p>
                    <ul class="list-unstyled text-light-muted mt-3">
                        <li><i class="bi bi-check-circle-fill text-info me-2"></i> Cohort Term Registrations</li>
                        <li><i class="bi bi-check-circle-fill text-info me-2"></i> Real-time Transcripts</li>
                        <li><i class="bi bi-check-circle-fill text-info me-2"></i> Installable Mobile App</li>
                    </ul>
                </div>
            </div>

            <!-- Professor Block -->
            <div class="showcase-block animate-up delay-100">
                <div class="showcase-visual">
                    <i class="bi bi-easel bg-icon"></i>
                </div>
                <div class="showcase-content flex-grow-1">
                    <div class="showcase-icon-wrapper" style="color: #a6c1ee; border-color: rgba(166,193,238,0.3); background: rgba(166,193,238,0.1);"><i class="bi bi-person-workspace"></i></div>
                    <h3>Faculty & Professors</h3>
                    <p class="text-light-muted">Built to support rigorous teaching standards. Manage class rosters, track daily attendance, and utilize our automated 4-component continuous grading system directly linked to the registrar.</p>
                    <ul class="list-unstyled text-light-muted mt-3">
                        <li><i class="bi bi-check-circle-fill text-primary me-2"></i> 4-Component Assessment System</li>
                        <li><i class="bi bi-check-circle-fill text-primary me-2"></i> Daily Roster Tracking</li>
                        <li><i class="bi bi-check-circle-fill text-primary me-2"></i> Excel Integrations</li>
                    </ul>
                </div>
            </div>

            <!-- Dean Block -->
            <div class="showcase-block animate-up delay-100">
                <div class="showcase-visual">
                    <i class="bi bi-bank bg-icon"></i>
                </div>
                <div class="showcase-content flex-grow-1">
                    <div class="showcase-icon-wrapper" style="color: #f6e05e; border-color: rgba(246,224,94,0.3); background: rgba(246,224,94,0.1);"><i class="bi bi-award"></i></div>
                    <h3>Deans & Administration</h3>
                    <p class="text-light-muted">Govern the academic structure of your specific College or School. Bundle courses into terms, allocate campus rooms on Northbridge Road, and review pending student enrollment requests efficiently.</p>
                    <ul class="list-unstyled text-light-muted mt-3">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Term-Course Bundling</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Campus Room Scheduling</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Enrollment Approvals</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Information Dense Architecture Section -->
    <section id="architecture" class="architecture-section">
        <div class="container">
            <div class="arch-header animate-up">
                <h2 class="fw-bold text-white mb-3">Role-Based Architecture</h2>
                <p class="text-light-muted">A modular, progressive disclosure system. Users only see what they need, minimizing cognitive load while maintaining absolute control over complex academic data.</p>
            </div>

            <div class="arch-grid">
                <!-- Card 1 -->
                <div class="arch-card animate-up delay-100">
                    <div class="arch-icon"><i class="bi bi-person-badge"></i></div>
                    <h4>Student Dashboard</h4>
                    <p>Action-driven interface prioritizing looming deadlines. Features instant batch term registration, real-time GPA tracking, and installable PWA mobile access.</p>
                </div>
                <!-- Card 2 -->
                <div class="arch-card animate-up delay-200">
                    <div class="arch-icon"><i class="bi bi-person-workspace"></i></div>
                    <h4>Faculty Tools</h4>
                    <p>Designed for fast data entry. Professors manage class rosters and utilize an automated 4-component continuous grading rubric directly linked to the registrar.</p>
                </div>
                <!-- Card 3 -->
                <div class="arch-card animate-up delay-300">
                    <div class="arch-icon"><i class="bi bi-diagram-3"></i></div>
                    <h4>Administrative Core</h4>
                    <p>Cross-college integration handles data across all university bodies. Deans bundle courses, allocate physical rooms, and approve cohort enrollments seamlessly.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Detailed Capability Preview -->
    <section id="capabilities" class="preview-section">
        <div class="container">
            <div class="preview-bento animate-up">
                <div>
                    <h2 class="fw-bold text-white mb-3">Engineered for Scale</h2>
                    <p class="text-light-muted mb-4">Under the hood, UniTRS uses a robust database schema heavily optimized with views and strict foreign key constraints, ensuring zero data anomalies.</p>
                    
                    <ul class="feature-list">
                        <li>
                            <i class="bi bi-shield-check"></i>
                            <div>
                                <h5>Bank-Grade Security</h5>
                                <p>BCrypt hashing combined with custom Two-Factor Authentication (2FA) via Email ensures strict privacy.</p>
                            </div>
                        </li>
                        <li>
                            <i class="bi bi-calendar-range"></i>
                            <div>
                                <h5>Shift-Based Scheduling</h5>
                                <p>Accommodates diverse student bodies with automated scheduling for Morning, Afternoon, Evening, and Weekend shifts.</p>
                            </div>
                        </li>
                        <li>
                            <i class="bi bi-graph-up-arrow"></i>
                            <div>
                                <h5>Standardized Grading</h5>
                                <p>Pre-configured calculation logic for Attendance (15%), Assignments (25%), Midterm (30%), and Final (30%).</p>
                            </div>
                        </li>
                    </ul>
                </div>
                
                <div class="h-100 w-100 rounded-4 d-flex align-items-center justify-content-center" style="background: rgba(0,0,0,0.2); border: 1px solid var(--glass-border); min-height: 400px; position: relative; overflow: hidden;">
                    <!-- Abstract Code/Data visualization -->
                    <div style="position: absolute; width: 150%; height: 150%; background: radial-gradient(circle, rgba(0,242,254,0.05) 0%, transparent 60%);"></div>
                    <i class="bi bi-server" style="font-size: 8rem; color: rgba(255,255,255,0.02); text-shadow: 0 0 30px rgba(0,242,254,0.1);"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer-custom">
        <div class="container">
            <div class="row g-4 mb-5">
                <div class="col-lg-5">
                    <div class="navbar-brand mb-3">
                        <i class="bi bi-mortarboard-fill text-gradient"></i> <span class="ms-1">UniTRS</span>
                    </div>
                    <p class="text-muted" style="max-width: 320px; font-size: 0.9rem; line-height: 1.6;">
                        The official University Management System powering modern academic infrastructure. Founded on the principles of academic excellence and technological advancement.
                    </p>
                </div>
                <div class="col-lg-2 col-6">
                    <h5 class="footer-title">Platform</h5>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/auth/login">Student Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth/login">Faculty Portal</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth/login">Admin Dashboard</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-6">
                    <h5 class="footer-title">Departments</h5>
                    <ul class="footer-links">
                        <li><a href="#">Science & Tech</a></li>
                        <li><a href="#">Arts & Humanities</a></li>
                        <li><a href="#">School of Business</a></li>
                        <li><a href="#">Graduate Studies</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h5 class="footer-title">Contact & Legal</h5>
                    <ul class="footer-links">
                        <li class="d-flex align-items-start mb-2">
                            <i class="bi bi-geo-alt me-2 text-muted mt-1"></i>
                            <span style="font-size: 0.9rem;">Northbridge Road, Sen Sok<br>Phnom Penh, Cambodia</span>
                        </li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">IT Guidelines</a></li>
                    </ul>
                </div>
            </div>
            <div class="d-flex justify-content-between align-items-center pt-4 border-top" style="border-color: var(--glass-border) !important;">
                <span class="text-muted" style="font-size: 0.85rem;">&copy; 2026 UniTRS System. All rights reserved.</span>
                <div class="d-flex gap-3">
                    <a href="#" class="text-muted hover-white transition"><i class="bi bi-github fs-5"></i></a>
                    <a href="#" class="text-muted hover-white transition"><i class="bi bi-twitter-x fs-5"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Intersection Observer for triggering animations on scroll to prevent lag
        document.addEventListener('DOMContentLoaded', () => {
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.animationPlayState = 'running';
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });

            // Initially pause animations for elements below the fold
            document.querySelectorAll('.showcase-section .animate-up, .architecture-section .animate-up, .preview-section .animate-up').forEach(el => {
                el.style.animationPlayState = 'paused';
                observer.observe(el);
            });
        });
    </script>
</body>
</html>