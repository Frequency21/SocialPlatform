import { Komment } from './../shared/models/komment.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Poszt } from '../shared/models/poszt.model';

@Injectable({
  providedIn: 'root'
})
export class PosztService {

  rootUrl: string = '/api'

  constructor(private http: HttpClient) { }

  getPoszts(): Observable<Poszt[]> {
    return this.http.get<Poszt[]>(this.rootUrl + '/poszts');
  }

  addPoszt(poszt: Poszt): Observable<Poszt> {
    return this.http.post<Poszt>(this.rootUrl + '/poszt/add', poszt);
  }

  addKomment(komment: Komment): Observable<Komment> {
    console.log("AddKomment(" + komment + ")");
    return this.http.post<Komment>(this.rootUrl + "/poszt/addKomment", komment);
  }

}
