import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { map } from 'rxjs/operators';


@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  constructor(
    private httpClient:HttpClient
  ) {
     }

  // tslint:disable-next-line:typedef
  isUserLoggedIn() {
    let user = sessionStorage.getItem('username');
    return !(user === null);
  }

  isUserisAdministrator() {
    let r_id = sessionStorage.getItem("restaurant");
    return this.isUserLoggedIn() && (!(r_id === 'null'));
  }

  logOut() {
    sessionStorage.removeItem('username');
  }
}
