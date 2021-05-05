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
    return this.httpClient.post<number>(this.localhost+'user/register', user);
  }

  public login(username: String, password: String)
  {
    return this.httpClient.post<User>(this.localhost+'user/login', {"username": username, "password": password} );
  }

  public getUser(userId: number)
  {
    return this.httpClient.get<User>(this.localhost+'api/user?id=' + userId);
  }

  public deleteUser(id:number)
  {
    return this.httpClient.delete<Boolean>(this.httpClient+'user/delete?id='+ id);
  }

  public updateUser(user: User)
  {
    return this.httpClient.post<User>(this.localhost+'user/update', user);
  }
}
