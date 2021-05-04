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

}
