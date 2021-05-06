import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';


@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  constructor(private httpClient: HttpClient) { }

  // tslint:disable-next-line:typedef
  isUserLoggedIn() {
    let user = sessionStorage.getItem('email');
    return !(user === null);
  }

  logOut() {
    sessionStorage.removeItem('email');
  }
}
