import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { User } from '../shared/models/user.model';

export class LoginDetails{
  constructor(
    public username: string,
    public password: string,
  ) {}
}

@Injectable({
  providedIn: 'root'
})
export class HttpClientService {

  constructor(private httpClient: HttpClient) { }

   localhost = 'http://localhost:8080/';


  public createAccount(user: User) {
    // const username = 'admin';
    // const password = 'admin';

    // const headers = new HttpHeaders({ Authorization: 'Basic ' + btoa(username + ':' + password) });
    return this.httpClient.post<Account>(this.localhost+'user/register', user);
  }

  public login(username: String, password: String)
  {
    const data = username + ':' + password;
    return this.httpClient.post<User>(this.localhost+'user/login', data);
  }

  public getUsers()
  {
    return this.httpClient.get<User[]>(this.localhost+'user/all');
  }
}
