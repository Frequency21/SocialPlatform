import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
    providedIn: 'root'
})
export class ImageService {
    constructor(private httpClient: HttpClient) { }
    public baseUrl = '/api/images/';
    
    /* api path */
    public uploadImage(formData: FormData, path: string): Observable<any> {
        const file = formData.get('file') as File;
        const url = this.baseUrl + `${path}?file=${file.name}`;
        return this.httpClient.post(url, formData, { responseType: 'text' });
    }
}