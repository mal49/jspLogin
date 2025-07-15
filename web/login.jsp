<%-- Document : login Created on : Jun 23, 2025, 9:49:21 AM Author : ikhma --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Coupon Management System - Login</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <style>
                body {
                    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                    min-height: 100vh;
                }

                .login-card {
                    backdrop-filter: blur(10px);
                    background: rgba(255, 255, 255, 0.95);
                    border-radius: 15px;
                    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                }

                .form-control:focus {
                    border-color: #ff6b6b;
                    box-shadow: 0 0 0 0.2rem rgba(255, 107, 107, 0.25);
                }

                .btn-login {
                    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                    border: none;
                }

                .btn-login:hover {
                    background: linear-gradient(135deg, #ff5252 0%, #d84315 100%);
                }

                .coupon-icon {
                    background: linear-gradient(45deg, #ff6b6b, #ee5a24);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }
            </style>
        </head>

        <body>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-transparent">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp"><i class="bi bi-ticket-perforated-fill me-2"></i>Coupon
                        Management System</a>
                    <div class="navbar-nav ms-auto">
                        <a class="nav-link" href="index.jsp">
                            <i class="bi bi-house me-1"></i>Home
                        </a>
                        <a class="nav-link" href="register.jsp">
                            <i class="bi bi-person-plus me-1"></i>Register
                        </a>
                    </div>
                </div>
            </nav>

            <!-- Login Section -->
            <div class="container">
                <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
                    <div class="col-md-6 col-lg-5">
                        <div class="login-card p-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-ticket-perforated-fill coupon-icon" style="font-size: 3rem;"></i>
                                <h2 class="fw-bold mt-3 mb-2">Welcome Back!</h2>
                                <p class="text-muted">Sign in to manage your coupons</p>
                            </div>

                            <form action="LoginServlet" method="POST" class="needs-validation" novalidate>
                                <div class="mb-3">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <input type="text" class="form-control" id="username" name="username"
                                            placeholder="Enter your username" required>
                                        <div class="invalid-feedback">
                                            Please provide a valid username.
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                        <input type="password" class="form-control" id="password" name="password"
                                            placeholder="Enter your password" required>
                                        <div class="invalid-feedback">
                                            Please provide a valid password.
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="rememberMe">
                                    <label class="form-check-label" for="rememberMe">
                                        Remember me
                                    </label>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-login btn-lg text-white">
                                        <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                                    </button>
                                </div>

                                <div class="text-center mt-4">
                                    <p class="text-muted">Don't have an account?
                                        <a href="register.jsp" class="text-primary text-decoration-none fw-bold">Sign up
                                            here</a>
                                    </p>
                                </div>
                            </form>

                            <!-- Error/Success Messages -->
                            <% if(request.getParameter("error") !=null) { %>
                                <div class="alert alert-danger mt-3" role="alert">
                                    <i class="bi bi-exclamation-triangle me-2"></i>
                                    Invalid username or password. Please try again.
                                </div>
                                <% } %>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Bootstrap form validation
                (function () {
                    'use strict';
                    window.addEventListener('load', function () {
                        var forms = document.getElementsByClassName('needs-validation');
                        var validation = Array.prototype.filter.call(forms, function (form) {
                            form.addEventListener('submit', function (event) {
                                if (form.checkValidity() === false) {
                                    event.preventDefault();
                                    event.stopPropagation();
                                }
                                form.classList.add('was-validated');
                            }, false);
                        });
                    }, false);
                })();
            </script>
        </body>

        </html>