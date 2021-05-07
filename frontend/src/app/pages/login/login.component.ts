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
  invalidLogin = false;

  users: User[] = [];

  constructor(private router: Router,
    private userService: UserService,
    ) { }

  ngOnInit() {
  }

  handleSuccessfulResponse(response: any[])
  {
      this.users=response;
  }

  checkLogin() {
    this.invalidLogin = false;

    try{
    this.userService.login(this.email, this.password)
      .subscribe((data => {
        // console.log(data.email);
        // console.log(data.firstName);
        // console.log(data.lastName);
        // console.log(data.password);
        // console.log(data.email);
        // console.log(data.phone);
        // console.log(data.zipCode);
        // console.log(data.city);
        // console.log(data.area);
        // console.log(data.addressType);
        // console.log(data.houseNumber);
        // sessionStorage.setItem('email', String(data.email));
        // sessionStorage.setItem('knev', data.knev);
        // sessionStorage.setItem('vnev', data.vnev);

        alert("Login succesful");
      }));
    }
    catch(error) {
      this.invalidLogin = true;
    }

  }


}
