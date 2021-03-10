import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { User } from '../shared/models/user.model'

@Injectable({
  providedIn: 'root'
})
export class UserService {

  // mock datas
  users: User[] = [
    {id: 1, name: 'oli', created: new Date(2021, 3, 10, 14, 33), email: 'taylor@gmail.com'},
    {id: 2, name: 'ralf', created: new Date(2021, 3, 10, 14, 34), email: 'deny@gmail.com'},
    {id: 3, name: 'etele', created: new Date(2021, 3, 10, 14, 35), email: 'yndi@gmail.com'},
  ]

  constructor(private http: HttpClient) { }

  getUsers(): Observable<User[]> {
    return of(this.users);
    // TODO valódi szerver kommunikáció
    // return new Observable<User>();
  }

}
