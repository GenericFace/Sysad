<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Collabo</title>
  <link rel="stylesheet" href="./assets/css/styles.css">
</head>
<body>
  <header>
    <h2 class="logo">COLLABO</h2>
    <nav class="nav">
      <a href="#">Home</a>
      <a href="#">About</a>
      <a href="#">Services</a>
      <a href="#">Contact</a>
      <button class="btnlogin-popup">Login</button>
    </nav>
  </header>

  <div class="wrapper">

    <span class="icon-close">
      <p> X </p>
    </span>

    <div class="form-box login">
      <h2>Login</h2>
      <form action="#">
        <div class="input-box">
          <input type="email" name="em" required>
          <label>Email</label>
        </div>
        <div class="input-box">
          <input type="password" name="pw" required>
          <label>Password</label>
        </div>
        <div class="remember-forgot">
          <label><input type="checkbox"> Remember Me</label>
        </div> 
        <button type="submit" class="btn">Login</button>
        <div class="login-register">
          <p>Dont have an account?<a href="#" class="register-link">Register</a></p>
        </div>
      </form>
    </div>

    <div class="form-box register">
      <h2>Registeration</h2>
      <form action="#">
        <div class="input-box">
          <input type="text" required>
          <label>Username</label>
        </div>
        <div class="input-box">
          <input type="email" required>
          <label>Email</label>
        </div>
        <div class="input-box">
          <span class="icon"></span>
          <input type="password" required>
          <label>Password</label>
        </div>
        <div class="remember-forgot">
          <label><input type="checkbox"> I agree to terms and conditions</label>
        </div> 
        <button type="submit" class="btn">Register</button>
        <div class="login-register">
          <p>Alrady have an account?<a href="#" class="login-link">Login</a></p>
        </div>
      </form>
    </div>
  </div>

  <script src="./assets/js/script.js"></script>
</body>
</html>