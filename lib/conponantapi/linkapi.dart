//ip for localhost is 10.0.2.2 if there is port add port :2


//thie ip is for emulator if i want to emulate it on
//my fone put my phone ip
//10.0.2.2
const String linkServerName = 'https://rosemary-dana.000webhostapp.com/coursephp' ;
const String linkImageRoot = 'https://rosemary-dana.000webhostapp.com/coursephp/upload' ;
//auth
//$linkImageRoot/${noteModel?.notesImage}
const String linkSignup = '$linkServerName/auth/signup.php';
const String linkLogin = '$linkServerName/auth/login.php';

const String linkViewNotes = '$linkServerName/notes/view.php';
const String linkAddPost = '$linkServerName/notes/add.php';
const String linkEditPost = '$linkServerName/notes/edit.php';
const String linkDeletePost = '$linkServerName/notes/delete.php';
const String linkViewAllPost = '$linkServerName/notes/viewAll.php';
const String linknamePost = '$linkServerName/notes/username.php';
const String linkcountPost = '$linkServerName/notes/count.php';

const String linkHabit = '$linkServerName/habitview.php';