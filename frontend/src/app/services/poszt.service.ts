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

  getPosztsByFelhasznaloId(id: number):  Observable<Poszt[]> {
    return this.http.get<Poszt[]>(this.rootUrl + id);
  }

  getPosztsByCsoportId(id: number):  Observable<Poszt[]> {
    return this.http.get<Poszt[]>(this.rootUrl + id);
  }

  addPoszt(poszt: Poszt): Observable<number> {
    return this.http.post<number>(this.rootUrl + 'add', poszt);
  }

  getKomments(): Observable<Komment[]> {
    return this.http.get<Komment[]>(this.rootUrl + "komments");
  }

  addKomment(komment: Komment): Observable<Komment> {
    console.log("AddKomment(" + komment + ")");
    return this.http.post<Komment>(this.rootUrl + "addKomment", komment);
  }

}
