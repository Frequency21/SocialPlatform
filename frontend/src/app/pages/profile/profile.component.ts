import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClientService } from 'src/app/services/httpclient.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

  user!: User;

  public userId: number = 0;

  form: FormGroup = new FormGroup({
    username: new FormControl(),
    email: new FormControl(),

    // email: new FormControl(),
    vnev: new FormControl(),
    knev: new FormControl(),
    //csatl: new FormControl(),
    szul_dat: new FormControl(),
    munka_iskola: new FormControl(),
    // picture?: new FormControl(),
    password1: new FormControl(),
    password2: new FormControl(),
  });

  constructor(
    private router: Router,
    private httpClientService: HttpClientService,
    ) { }

  ngOnInit(): void {
  }

  public getUser(): void {
    try {
      this.httpClientService.getUser(this.userId)
      .subscribe((data => {
        this.user = data;
        alert("Successful")
      }))
    } catch(error) {
      alert(error);
    }
  }

  public updateUser(): void {   
    try {
      this.httpClientService.updateUser(this.user)
      .subscribe((data => {
        
        alert("Update succesful")
      }))
    }catch(error) {
      alert(error);
    }
  }


  public deleteUser(): void {
    try{
      this.httpClientService.deleteUser(this.userId)
        .subscribe((data => {
  
          alert("Delete succesful");
        }));
      }
      catch(error) {
        alert(error);
      }

    this.router.navigate(['logout']);
  }

}
