import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Category } from '../shared/models/category.model';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  private rootUrl: string = '/api/category';

  constructor(
    private http: HttpClient
  ) { }

  getCategories(): Observable<Category[]> {
    return this.http.get<Category[]>(this.rootUrl + '/all');
  }

}
