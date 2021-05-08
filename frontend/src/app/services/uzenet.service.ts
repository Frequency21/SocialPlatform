import { Observable } from 'rxjs';
import { Injectable } from '@angular/core';
import { Uzenet } from '../shared/models/uzenet.model';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UzenetService {

  rootUrl: string = '/api/message/';

  constructor(
    private router: Router,
    private http: HttpClient) { }

  getUzenetForChat(senderId: number, receiverId: number): Observable<Uzenet[]> {
    return this.http.get<Uzenet[]>(this.rootUrl + senderId + "/" + receiverId);
  }

  sendMessage(message: Uzenet): Observable<boolean> {
    console.log(message);
    return this.http.post<boolean>(this.rootUrl, message);
  }

  deleteMessage(id: number): Observable<boolean> {
    return this.http.delete<boolean>(this.rootUrl + id);
  }
}
