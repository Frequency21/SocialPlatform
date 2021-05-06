import { Komment } from './../shared/models/komment.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Poszt } from '../shared/models/poszt.model';

@Injectable({
  providedIn: 'root'
})
export class PosztService {

  rootUrl: string = 'api/post/'

  constructor(private http: HttpClient) { }

  getPoszts(): Observable<Poszt[]> {
    return this.http.get<Poszt[]>(this.rootUrl + 'all');
  }

  addPoszt(poszt: Poszt): Observable<Poszt> {
    console.log("helloka!");
    return this.http.post<Poszt>(this.rootUrl + 'add', poszt);
  }

  addKomment(komment: Komment): Observable<Komment> {
    console.log("AddKomment(" + komment + ")");
    return this.http.post<Komment>(this.rootUrl + "addKomment", komment);
  }

}
