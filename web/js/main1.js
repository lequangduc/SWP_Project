function validateRegisterForm(event) {
    event.preventDefault(); // this will prevent the submit event.
    if (document.registerform.userName.value == "") {
        //alert("User Name can not be left blank");
        document.registerform.userName.focus();
        document.getElementById('unameErr').textContent = '*User name can not be left blank';
        return false;
    } else if (document.registerform.password.value == "") {
        //alert("Password can not be left blank");
        document.registerform.password.focus();
        document.getElementById('passwordErr').textContent = '*Password can not be left blank';
        return false;
    } else if (document.registerform.name.value == "") {
        //alert("Name can not be left blank");
        document.registerform.name.focus();
        document.getElementById('nameErr').textContent = '*Name can not be left blank';
        return false;
    } else {
        document.registerform.submit(); // fire submit event
    }
}