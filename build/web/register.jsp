<%-- Document : register Created on : Jun 23, 2025, 9:49:31 AM Author : ikhma --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Coupon Management System - Register</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <style>
                body {
                    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                    min-height: 100vh;
                }

                .register-card {
                    backdrop-filter: blur(10px);
                    background: rgba(255, 255, 255, 0.95);
                    border-radius: 15px;
                    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                }

                .form-control:focus {
                    border-color: #ff6b6b;
                    box-shadow: 0 0 0 0.2rem rgba(255, 107, 107, 0.25);
                }

                .btn-register {
                    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                    border: none;
                }

                .btn-register:hover {
                    background: linear-gradient(135deg, #ff5252 0%, #d84315 100%);
                }

                .step-indicator {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 2rem;
                }

                .step {
                    flex: 1;
                    text-align: center;
                    position: relative;
                }

                .step::after {
                    content: '';
                    position: absolute;
                    top: 15px;
                    right: -50%;
                    width: 100%;
                    height: 2px;
                    background: #dee2e6;
                    z-index: -1;
                }

                .step:last-child::after {
                    display: none;
                }

                .step.active .step-number {
                    background: #ff6b6b;
                    color: white;
                }

                .step-number {
                    width: 30px;
                    height: 30px;
                    border-radius: 50%;
                    background: #dee2e6;
                    color: #6c757d;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 0.875rem;
                    font-weight: bold;
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
                        <a class="nav-link" href="login.jsp">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Login
                        </a>
                    </div>
                </div>
            </nav>

            <!-- Register Section -->
            <div class="container">
                <div class="row justify-content-center" style="padding: 2rem 0;">
                    <div class="col-md-8 col-lg-6">
                        <div class="register-card p-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-ticket-perforated-fill coupon-icon" style="font-size: 3rem;"></i>
                                <h2 class="fw-bold mt-3 mb-2">Create Account</h2>
                                <p class="text-muted">Join our coupon management platform</p>
                            </div>

                            <!-- Step Indicator -->
                            <div class="step-indicator">
                                <div class="step active">
                                    <div class="step-number">1</div>
                                    <div class="step-label mt-2">Business Info</div>
                                </div>
                                <div class="step">
                                    <div class="step-number">2</div>
                                    <div class="step-label mt-2">Account Setup</div>
                                </div>
                                <div class="step">
                                    <div class="step-number">3</div>
                                    <div class="step-label mt-2">Complete</div>
                                </div>
                            </div>

                            <form action="registerServlet" method="POST" class="needs-validation" novalidate>
                                <!-- Business Information -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="firstName" class="form-label">First Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                                            <input type="text" class="form-control" id="firstName" name="firstName"
                                                placeholder="Enter first name" required>
                                            <div class="invalid-feedback">
                                                Please provide your first name.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                                            <input type="text" class="form-control" id="lastName" name="lastName"
                                                placeholder="Enter last name" required>
                                            <div class="invalid-feedback">
                                                Please provide your last name.
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email"
                                            placeholder="Enter your business email" required>
                                        <div class="invalid-feedback">
                                            Please provide a valid email address.
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="studentId" class="form-label">Business ID</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-building"></i></span>
                                        <input type="text" class="form-control" id="studentId" name="studentId"
                                            placeholder="Enter your business ID" required>
                                        <div class="invalid-feedback">
                                            Please provide your business ID.
                                        </div>
                                    </div>
                                </div>

                                <!-- Account Setup -->
                                <div class="mb-3">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person-circle"></i></span>
                                        <input type="text" class="form-control" id="username" name="username"
                                            placeholder="Choose a username" required>
                                        <div class="invalid-feedback">
                                            Please choose a username.
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="password" class="form-label">Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                            <input type="password" class="form-control" id="password" name="password"
                                                placeholder="Create password" required minlength="6">
                                            <div class="invalid-feedback">
                                                Password must be at least 6 characters long.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                            <input type="password" class="form-control" id="confirmPassword"
                                                name="confirmPassword" placeholder="Confirm password" required>
                                            <div class="invalid-feedback">
                                                Passwords do not match.
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                        <label class="form-check-label" for="agreeTerms">
                                            I agree to the <a href="#" class="text-primary">Terms and Conditions</a> and
                                            <a href="#" class="text-primary">Privacy Policy</a>
                                        </label>
                                        <div class="invalid-feedback">
                                            You must agree to the terms and conditions.
                                        </div>
                                    </div>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-register btn-lg text-white">
                                        <i class="bi bi-person-plus me-2"></i>Create Account
                                    </button>
                                </div>

                                <div class="text-center mt-4">
                                    <p class="text-muted">Already have an account?
                                        <a href="login.jsp" class="text-primary text-decoration-none fw-bold">Sign in
                                            here</a>
                                    </p>
                                </div>
                            </form>
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

                // Password confirmation validation
                document.getElementById('confirmPassword').addEventListener('input', function () {
                    var password = document.getElementById('password').value;
                    var confirmPassword = this.value;

                    if (password !== confirmPassword) {
                        this.setCustomValidity('Passwords do not match');
                    } else {
                        this.setCustomValidity('');
                    }
                });

                document.getElementById('password').addEventListener('input', function () {
                    var confirmPassword = document.getElementById('confirmPassword');
                    if (confirmPassword.value !== '') {
                        if (this.value !== confirmPassword.value) {
                            confirmPassword.setCustomValidity('Passwords do not match');
                        } else {
                            confirmPassword.setCustomValidity('');
                        }
                    }
                });
            </script>
        </body>

        </html>