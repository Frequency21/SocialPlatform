import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from 'src/app/services/user.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  email = '';
  password = '';

  users: User[] = [];

  constructor(
    private router: Router,
    private userService: UserService,
    ) { }

  ngOnInit() {
  }

  handleSuccessfulResponse(response: any[])
  {
      this.users=response;
  }

  checkLogin() {
    try{
    this.userService.login(this.email, this.password)
      .subscribe((data => {
        if(data.id != null) {
          alert("Login succesful");
        } else {
          alert("Invalid login");
        }
     }));
    }
    catch(error) {
      alert("Invalid login");
    }

  }


}
