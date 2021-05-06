import { Group } from './../shared/models/group.model';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class GroupService {

  rootUrl: string = '/api/'

  constructor(private http: HttpClient) { }

  getGroups(): Observable<Group[]> {
    return this.http.get<Group[]>(this.rootUrl + 'groups');
  }

  getGroupById(id: Number): Observable<Group[]> {
    return this.http.get<Group[]>(this.rootUrl + 'group?id=' + id);
  }
}
