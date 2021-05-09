import { Observable } from 'rxjs';
import { Komment } from './../shared/models/komment.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  rootUrl: string = '/api/komment';

  constructor(private http: HttpClient) { }

  saveKomment(komment: Komment): Observable<number> {
    return this.http.post<number>(this.rootUrl + "/", komment);
  }

  getKommnetByPosztId(id: number): Observable<Komment[]> {
    console.log(id);
    return this.http.get<Komment[]>(this.rootUrl + "/poszt/" + id);
  }
}
