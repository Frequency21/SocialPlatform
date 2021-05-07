import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { UserService } from 'src/app/services/user.service';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

  public selectedFile?: File;
  public imgSrc?: string;
  public user!: User;

  public userId: number = 0;
  subscription: Subscription;

  form: FormGroup = new FormGroup({
    email: new FormControl(),
    vnev: new FormControl(),
    knev: new FormControl(),
    szul_dat: new FormControl(),
    munka_iskola: new FormControl(),
    password1: new FormControl(),
    password2: new FormControl(),
  });

  constructor(
    private router: Router,
    private userService: UserService,
  ) {    
     this.subscription = this.userService.userSource.subscribe(user => {this.user = user;    console.log(this.user);});
  }

  ngOnInit(): void {

  }

  public getUser(): void {
    try {
      this.userService.getUser(this.userId)
        .subscribe(data => {
          this.user = data;
          // console.log(this.user);
          alert("Successful")
        })
    } catch (error) {
      alert(error);
    }
  }

  // TODO: userServicebe vinni
  updateUser(): void {
    console.log(this.user);
      let newUser: User = {
        id: this.user.id,
        email: this.form.value.email,
        jelszo: this.form.value.password1,
        vnev: this.form.value.vnev,
        knev: this.form.value.knev,
        csatl: new Date(Date.now()),
        szul_dat: this.form.value.szul_dat,
        munka_iskola: this.form.value.munka_iskola,
        picture: undefined,
        isAdmin: false,
      }
  
      console.log(newUser);
  
      let formData = new FormData();
      if (this.selectedFile)
        formData.set('file', this.selectedFile as Blob, this.selectedFile?.name);
      
      this.userService.updateUser(newUser)
        .subscribe(
          id => {
            console.log('get id: ' + id);
            if (id && this.selectedFile) {
              console.log('start upload image');
              this.userService.uploadProfile(formData, id)
              .subscribe(
                path => {
                  console.log('succesfully upload img to: ' + path);
                  // if ()
                  newUser.picture = path;
                }
              )
            }
          }
        )
  }

  public deleteUser(): void {
    this.userService.deleteUser(this.user)
      .subscribe(data => {
        if (data)
          alert("Sikeres törlés");
        else {
          alert("Nem sikerült a törlés");
        }
      });
  }

  onSelectFile(event: any) {
    this.selectedFile = event.target.files[event.target.files.length - 1] as File;
  }
}

