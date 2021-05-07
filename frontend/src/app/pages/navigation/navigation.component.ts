import { Router } from "@angular/router";
import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthenticationService } from "src/app/services/authentication.service";
import { UserService } from "src/app/services/user.service";
import { User } from "src/app/shared/models/user.model";
import { Subscription } from "rxjs";

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.scss']
})
export class NavigationComponent implements OnInit, OnDestroy {

  isLoginSuccess = false;
  email = '';
  password = '';
  user?: User;
  subscription: Subscription;

  name = sessionStorage.getItem('name');

  constructor(private router: Router,
    private userService: UserService,
    public loginService: AuthenticationService,
    public authentocationService: AuthenticationService) {
    this.subscription = this.userService.userSource.subscribe(user => this.user = user);
  }

  ngOnInit(): void { }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }


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
    try {
      this.userService.login(this.email, this.password)
        .subscribe(data => {

          // sessionStorage.setItem('email', data.email);
          // sessionStorage.setItem('name', data.lastName+" "+data.firstName);
          // sessionStorage.setItem('email', data.email);
          // sessionStorage.setItem('restaurant', data.restaurant);         

          // this.msgPopUp();
        });
    }
    catch (error) {
      alert(error);
    }
  }


}
