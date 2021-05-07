import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, ReplaySubject } from 'rxjs';
import { User, Kategoria, Fenykep } from '../shared/models/user.model'
import { tap } from "rxjs/operators";
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  rootUrl: string = '/api/user/'
  private _user = new ReplaySubject<User>(1);
  userSource = this._user.asObservable();

  constructor(
    private router: Router,
    private http: HttpClient) { }

  public createAccount(user: User) {
    return this.http.post<number>(this.rootUrl + 'register', user);
  }

  public login(email: string, jelszo: string) {
    let formData = new FormData();
    formData.append("email", email);
    formData.append("jelszo", jelszo);
    return this.http.post<User>(this.rootUrl + 'login', formData).pipe(
      tap(user => {
        // console.log('after login, user is:');
        // console.log(user);
        this._user.next(user);
        this.router.navigate(['profile']);
        return user;
      })
    );
  }

  public logout() {
    this._user.next(undefined);
    this.router.navigate(['']);
  }

  getUser(id: number): Observable<User> {
    return this.http.get<User>(this.rootUrl + id);
  }

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + 'all');
  }

  getUserByID(id: Number): Observable<User> {
    return this.http.get<User>(this.rootUrl + id);
  }

  public deleteUser(id: number) {
    return this.http.delete<Boolean>(this.rootUrl + id);
  }

  uploadProfile(formData: FormData, id: number): Observable<any> {
    return this.http.post(this.rootUrl + `profile/${id}`, formData);
  }

  getIsmeroses(felhasznalo_id: number): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + '/ismerosok?fh=' + felhasznalo_id);
  }

  getKategorias(fenykepalbum_id: number): Observable<Kategoria> {
    return this.http.get<Kategoria>(this.rootUrl + '/kategorias?fa=' + fenykepalbum_id);
  }

  getFenykeps(fenykepalbum_id: number, kategorianev: string): Observable<Fenykep> {
    return this.http.get<Fenykep>(this.rootUrl + '/fenykeps?fa=' + fenykepalbum_id + '?kategorianev=' + kategorianev);
  }
}
