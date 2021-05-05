import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { User, Ismeros,  Fenykepalbum, Kategoria, Fenykep} from '../shared/models/user.model'

@Injectable({
  providedIn: 'root'
})
export class UserService {

  rootUrl: string = 'api/user/'

  constructor(private http: HttpClient) { }

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + 'all');
  }

  getUserByID(id: Number): Observable<User> {
    return this.http.get<User>(this.rootUrl + id);
  }

  getIsmeroses(felhasznalo_id: number): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + 'ismerosok?fh='+felhasznalo_id);
  }

  getKategorias(fenykepalbum_id: number): Observable<Kategoria> {
    return this.http.get<Kategoria>(this.rootUrl + '/kategorias?fa=' + fenykepalbum_id);
  }

  getFenykeps(fenykepalbum_id: number, kategorianev: string): Observable<Fenykep> {
    return this.http.get<Fenykep>(this.rootUrl + '/fenykeps?fa=' + fenykepalbum_id+'?kategorianev=' + kategorianev);
  }
}
