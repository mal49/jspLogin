<%-- Document : index Created on : Jun 23, 2025, 9:49:11 AM Author : ikhma --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Student Control Panel - Home</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <style>
                .hero-section {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                }

                .card-hover {
                    transition: transform 0.3s ease;
                }

                .card-hover:hover {
                    transform: translateY(-5px);
                }
            </style>
        </head>

        <body>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
                <div class="container">
                    <a class="navbar-brand" href="#"><i class="bi bi-mortarboard-fill me-2"></i>Student CP</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link active" href="index.jsp">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.jsp">Register</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6 text-white">
                            <h1 class="display-4 fw-bold mb-4">Welcome to Student Control Panel</h1>
                            <p class="lead mb-4">Your comprehensive platform for managing academic activities, accessing
                                resources, and staying connected with your educational journey.</p>
                            <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                                <a href="login.jsp" class="btn btn-light btn-lg px-4 me-md-2">
                                    <i class="bi bi-box-arrow-in-right me-2"></i>Login
                                </a>
                                <a href="register.jsp" class="btn btn-outline-light btn-lg px-4">
                                    <i class="bi bi-person-plus me-2"></i>Register
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6 text-center">
                            <i class="bi bi-mortarboard-fill text-white" style="font-size: 15rem; opacity: 0.8;"></i>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section class="py-5 bg-light">
                <div class="container">
                    <div class="row text-center mb-5">
                        <div class="col">
                            <h2 class="fw-bold">Why Choose Our Platform?</h2>
                            <p class="lead text-muted">Discover the features that make learning easier</p>
                        </div>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="card h-100 border-0 shadow-sm card-hover">
                                <div class="card-body text-center p-4">
                                    <i class="bi bi-shield-check text-primary" style="font-size: 3rem;"></i>
                                    <h5 class="card-title mt-3">Secure Access</h5>
                                    <p class="card-text text-muted">Your data is protected with industry-standard
                                        security measures.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100 border-0 shadow-sm card-hover">
                                <div class="card-body text-center p-4">
                                    <i class="bi bi-graph-up text-success" style="font-size: 3rem;"></i>
                                    <h5 class="card-title mt-3">Track Progress</h5>
                                    <p class="card-text text-muted">Monitor your academic progress and achievements in
                                        real-time.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100 border-0 shadow-sm card-hover">
                                <div class="card-body text-center p-4">
                                    <i class="bi bi-people text-info" style="font-size: 3rem;"></i>
                                    <h5 class="card-title mt-3">Community</h5>
                                    <p class="card-text text-muted">Connect with fellow students and share knowledge.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <footer class="bg-dark text-white py-4">
                <div class="container text-center">
                    <p class="mb-0">&copy; 2025 Student Control Panel. All rights reserved.</p>
                </div>
            </footer>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>