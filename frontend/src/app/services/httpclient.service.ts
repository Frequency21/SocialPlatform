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

  public login(username: String, password: String)
  {
    return this.httpClient.post<User>('/api/user/login', {"username": username, "password": password} );
  }

  public updateUser(user: User)
  {
    return this.httpClient.post<User>('/api/user/update', user);
  }
}
