import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClientService } from 'src/app/services/httpclient.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  username = '';
  password = '';
  invalidLogin = false;

  users: User[] = [];

  constructor(private router: Router,
    private httpClientService: HttpClientService,
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
    this.httpClientService.login(this.username, this.password)
      .subscribe((data => {
        // console.log(data.userName);
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
        sessionStorage.setItem('username', data.knev);

        alert("Login");
      }));
    }
    catch(error) {
      this.invalidLogin = true;
    }

  }


}
