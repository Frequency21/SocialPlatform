import { Router } from "@angular/router";
import { Component, OnInit } from '@angular/core';
import { HttpClientService } from "src/app/services/httpclient.service";
import { AuthenticationService } from "src/app/services/authentication.service";

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.scss']
})
export class NavigationComponent implements OnInit {

  isLoginSuccess = false;
  username = '';
  password = '';
  invalidLogin = false;

  name = sessionStorage.getItem('name');

  constructor(private router: Router,
    private httpClientService: HttpClientService,
    public loginService: AuthenticationService,
    public authentocationService: AuthenticationService) { }

  ngOnInit(): void { }

  public logout() {
    this.authentocationService.logOut();
    this.router.navigate(['']);
  }

  public login() {
    this.router.navigate(['login']);
  }

  public register() {
    this.router.navigate(['register']);
  }

  // tslint:disable-next-line:typedef
  checkLogin() {
    this.invalidLogin = false;

    try{
      this.httpClientService.login(this.username, this.password)
        .subscribe(data => {

          // sessionStorage.setItem('username', data.userName);
          // sessionStorage.setItem('name', data.lastName+" "+data.firstName);
          // sessionStorage.setItem('email', data.email);
          // sessionStorage.setItem('restaurant', data.restaurant);         
          
          // this.msgPopUp();
        }, error => {
          // this.msgPopUp(, 1);
          console.log(error.error.message);
      });
    }
    catch (error) {
      this.invalidLogin = true;
    }
  }


}
