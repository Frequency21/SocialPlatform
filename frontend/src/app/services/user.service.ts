import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { User, Ismeros,  Fenykepalbum, Kategoria, Fenykep} from '../shared/models/user.model'

@Injectable({
  providedIn: 'root'
})
export class UserService {

  rootUrl: string = '/api'

  // mock datas
  // users: User[] = [
  //   {id: 1, name: 'oli', created: new Date(2021, 3, 10, 14, 33), email: 'taylor@gmail.com'},
  //   {id: 2, name: 'ralf', created: new Date(2021, 3, 10, 14, 34), email: 'deny@gmail.com'},
  //   {id: 3, name: 'etele', created: new Date(2021, 3, 10, 14, 35), email: 'yndi@gmail.com'},
  // ]

  constructor(private http: HttpClient) { }

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + '/users');
  }

  getUserByID(id: Number): Observable<User> {
    return this.http.get<User>(this.rootUrl + '/user?id=' + id);
  }

  getIsmeroses(felhasznalo_id: number): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + '/ismerosok?fh='+felhasznalo_id);
  }

  getFenykepAlbum(album_id: number): Observable<Fenykepalbum> {
    return this.http.get<Fenykepalbum>(this.rootUrl + '/fenykepalbum?album='+ album_id);
  }

  getKategorias(fenykepalbum_id: number): Observable<Kategoria> {
    return this.http.get<Kategoria>(this.rootUrl + '/kategorias?fa=' + fenykepalbum_id);
  }

  getFenykeps(fenykepalbum_id: number, kategorianev: string): Observable<Fenykep> {
    return this.http.get<Fenykep>(this.rootUrl + '/fenykeps?fa=' + fenykepalbum_id+'?kategorianev=' + kategorianev);
  }
}
