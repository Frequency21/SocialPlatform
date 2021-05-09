import { Group } from './../shared/models/group.model';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { User } from '../shared/models/user.model';

@Injectable({
  providedIn: 'root'
})
export class GroupService {

  rootUrl: string = '/api/group/'

  constructor(private http: HttpClient) { }

  getGroups(): Observable<Group[]> {
    return this.http.get<Group[]>(this.rootUrl + 'all');
  }

  getGroupById(id: Number): Observable<Group> {
    return this.http.get<Group>(this.rootUrl + id);
  }

  getMembes(id: number): Observable<User[]> {
    return this.http.get<User[]>(this.rootUrl + "members/" + id);
  }
}
