import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClientService } from 'src/app/services/httpclient.service';
import { UserService } from 'src/app/services/user.service';
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
    private userService: UserService
  ) { }

  ngOnInit(): void {
  }

  public getUser(): void {
    try {
      this.userService.getUser(this.userId)
        .subscribe(data => {
          this.user = data;
          console.log(this.user);
          alert("Successful")
        })
    } catch (error) {
      alert(error);
    }
  }

  // TODO: userServicebe vinni
  public updateUser(): void {
    try {
      this.httpClientService.updateUser(this.user)
        .subscribe(data => {
          alert("Update succesful")
        })
    } catch (error) {
      alert(error);
    }
  }


  public deleteUser(): void {
    this.userService.deleteUser(this.userId)
      .subscribe(data => {
        if (data)
          alert("Sikeres törlés");
        else {
          alert("Nem sikerült a törlés");
        }
      });
  }

}
