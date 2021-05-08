import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  rootUrl: string = '/api/komment';

  constructor(private http: HttpClient) { }

  getKommnetById(id: number) {
    return this.http.get(this.rootUrl + "/posztok/${id}")
  }
}
