import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { User, Ismeros,  Fenykepalbum, Kategoria, Fenykep} from '../shared/models/user.model'

@Injectable({
  providedIn: 'root'
})
export class UserService {

  rootUrl: string = '/api'

  constructor(private http: HttpClient) { }

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + '/users');
  }

  getUserByID(id: Number): Observable<User> {
    console.log(this.rootUrl+'/user/'+id);
    return this.http.get<User>(this.rootUrl + '/user/' + id);
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
