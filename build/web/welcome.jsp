<%-- Document : welcome Created on : Jun 25, 2025, 11:00:46 AM Author : ikhmalhanif --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Student Control Panel - Dashboard</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <style>
                body {
                    background-color: #f8f9fa;
                }

                .sidebar {
                    min-height: 100vh;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                }

                .sidebar .nav-link {
                    color: rgba(255, 255, 255, 0.8);
                    transition: all 0.3s ease;
                }

                .sidebar .nav-link:hover,
                .sidebar .nav-link.active {
                    color: white;
                    background-color: rgba(255, 255, 255, 0.1);
                    border-radius: 8px;
                }

                .main-content {
                    min-height: 100vh;
                }

                .welcome-card {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border-radius: 15px;
                }

                .stats-card {
                    border-radius: 10px;
                    transition: transform 0.3s ease;
                }

                .stats-card:hover {
                    transform: translateY(-5px);
                }

                .activity-item {
                    border-left: 3px solid #667eea;
                    padding-left: 1rem;
                }

                .navbar-brand {
                    font-weight: bold;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- Sidebar -->
                    <div class="col-md-3 col-lg-2 px-0">
                        <div class="sidebar p-3">
                            <div class="text-center mb-4">
                                <i class="bi bi-mortarboard-fill text-white" style="font-size: 2.5rem;"></i>
                                <h5 class="text-white mt-2 mb-0">Student CP</h5>
                            </div>

                            <ul class="nav nav-pills flex-column">
                                <li class="nav-item mb-2">
                                    <a href="#" class="nav-link active">
                                        <i class="bi bi-house-door me-2"></i>Dashboard
                                    </a>
                                </li>
                                <li class="nav-item mb-2">
                                    <a href="#" class="nav-link">
                                        <i class="bi bi-person me-2"></i>Profile
                                    </a>
                                </li>
                                <li class="nav-item mb-2">
                                    <a href="#" class="nav-link">
                                        <i class="bi bi-book me-2"></i>Courses
                                    </a>
                                </li>
                                <li class="nav-item mb-2">
                                    <a href="#" class="nav-link">
                                        <i class="bi bi-calendar-event me-2"></i>Schedule
                                    </a>
                                </li>
                                <li class="nav-item mb-2">
                                    <a href="#" class="nav-link">
                                        <i class="bi bi-graph-up me-2"></i>Grades
                                    </a>
                                </li>
                                <li class="nav-item mb-2">
                                    <a href="#" class="nav-link">
                                        <i class="bi bi-gear me-2"></i>Settings
                                    </a>
                                </li>
                            </ul>

                            <hr class="text-white">

                            <div class="mt-auto">
                                <a href="LogoutServlet" class="nav-link text-white">
                                    <i class="bi bi-box-arrow-right me-2"></i>Logout
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-9 col-lg-10">
                        <div class="main-content p-4">
                            <!-- Top Navigation -->
                            <nav class="navbar navbar-expand-lg navbar-light bg-white rounded shadow-sm mb-4">
                                <div class="container-fluid">
                                    <span class="navbar-brand mb-0 h1">Dashboard</span>
                                    <div class="navbar-nav ms-auto">
                                        <div class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#"
                                                role="button" data-bs-toggle="dropdown">
                                                <i class="bi bi-person-circle me-2" style="font-size: 1.5rem;"></i>
                                                <span>
                                                    <%= request.getAttribute("username") !=null ?
                                                        request.getAttribute("username") : "Student" %>
                                                </span>
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="#"><i
                                                            class="bi bi-person me-2"></i>Profile</a></li>
                                                <li><a class="dropdown-item" href="#"><i
                                                            class="bi bi-gear me-2"></i>Settings</a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item" href="LogoutServlet"><i
                                                            class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </nav>

                            <!-- Welcome Section -->
                            <div class="welcome-card p-4 mb-4">
                                <div class="row align-items-center">
                                    <div class="col-md-8">
                                        <h2 class="fw-bold mb-2">Welcome back, <%= request.getAttribute("username")
                                                !=null ? request.getAttribute("username") : "Student" %>!</h2>
                                        <p class="mb-0 opacity-75">Ready to continue your learning journey? Check out
                                            your latest updates and activities below.</p>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <i class="bi bi-emoji-smile" style="font-size: 4rem; opacity: 0.7;"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Stats -->
                            <div class="row mb-4">
                                <div class="col-md-3 mb-3">
                                    <div class="card stats-card border-0 shadow-sm">
                                        <div class="card-body text-center">
                                            <i class="bi bi-book text-primary" style="font-size: 2.5rem;"></i>
                                            <h4 class="fw-bold mt-2 mb-1">6</h4>
                                            <p class="text-muted mb-0">Active Courses</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card stats-card border-0 shadow-sm">
                                        <div class="card-body text-center">
                                            <i class="bi bi-calendar-check text-success" style="font-size: 2.5rem;"></i>
                                            <h4 class="fw-bold mt-2 mb-1">4</h4>
                                            <p class="text-muted mb-0">Assignments Due</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card stats-card border-0 shadow-sm">
                                        <div class="card-body text-center">
                                            <i class="bi bi-graph-up text-info" style="font-size: 2.5rem;"></i>
                                            <h4 class="fw-bold mt-2 mb-1">3.7</h4>
                                            <p class="text-muted mb-0">Current GPA</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card stats-card border-0 shadow-sm">
                                        <div class="card-body text-center">
                                            <i class="bi bi-trophy text-warning" style="font-size: 2.5rem;"></i>
                                            <h4 class="fw-bold mt-2 mb-1">12</h4>
                                            <p class="text-muted mb-0">Achievements</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Recent Activity & Upcoming Events -->
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <div class="card border-0 shadow-sm">
                                        <div class="card-header bg-transparent border-0">
                                            <h5 class="fw-bold mb-0"><i class="bi bi-clock-history me-2"></i>Recent
                                                Activity</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="activity-item mb-3">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h6 class="mb-1">Submitted Math Assignment</h6>
                                                        <p class="text-muted small mb-0">Advanced Calculus - Problem Set
                                                            5</p>
                                                    </div>
                                                    <small class="text-muted">2h ago</small>
                                                </div>
                                            </div>
                                            <div class="activity-item mb-3">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h6 class="mb-1">Attended Online Lecture</h6>
                                                        <p class="text-muted small mb-0">Computer Science - Data
                                                            Structures</p>
                                                    </div>
                                                    <small class="text-muted">1d ago</small>
                                                </div>
                                            </div>
                                            <div class="activity-item mb-0">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h6 class="mb-1">Quiz Completed</h6>
                                                        <p class="text-muted small mb-0">Physics - Quantum Mechanics</p>
                                                    </div>
                                                    <small class="text-muted">2d ago</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-4">
                                    <div class="card border-0 shadow-sm">
                                        <div class="card-header bg-transparent border-0">
                                            <h5 class="fw-bold mb-0"><i class="bi bi-calendar-event me-2"></i>Upcoming
                                                Events</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-3 p-2 bg-light rounded">
                                                <div class="text-center me-3">
                                                    <div class="bg-primary text-white rounded p-2">
                                                        <div class="fw-bold">15</div>
                                                        <div style="font-size: 0.75rem;">JAN</div>
                                                    </div>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">Midterm Exam</h6>
                                                    <p class="text-muted small mb-0">Database Systems</p>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center mb-3 p-2 bg-light rounded">
                                                <div class="text-center me-3">
                                                    <div class="bg-success text-white rounded p-2">
                                                        <div class="fw-bold">18</div>
                                                        <div style="font-size: 0.75rem;">JAN</div>
                                                    </div>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">Project Presentation</h6>
                                                    <p class="text-muted small mb-0">Software Engineering</p>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center mb-0 p-2 bg-light rounded">
                                                <div class="text-center me-3">
                                                    <div class="bg-warning text-white rounded p-2">
                                                        <div class="fw-bold">22</div>
                                                        <div style="font-size: 0.75rem;">JAN</div>
                                                    </div>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">Assignment Due</h6>
                                                    <p class="text-muted small mb-0">Machine Learning</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>