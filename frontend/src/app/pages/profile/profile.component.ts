import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { AuthenticationService } from 'src/app/services/authentication.service';
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
  user?: User;
  oldUser!: User;

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
    public loginService: AuthenticationService,
    public authentocationService: AuthenticationService
  ) {    
     this.subscription = this.userService.userSource.subscribe(user => {this.user = user;  /*console.log(user); console.log(this.user);*/ });
  }

  ngOnInit(): void {
    try {
      if(this.user)
        if(this.user.id != null)
        this.userService.getUser(this.user.id)
          .subscribe(data => {
            this.oldUser = data;
        })
    } catch (error) {
      alert(error);
    }
  }

  public getUser(): void {
    try {
      if(this.user)
        if(this.user.id != null)
        this.userService.getUser(this.user.id)
          .subscribe(data => {
            return data;
        })
    } catch (error) {
      alert(error);
    }
  }

  // TODO: userServicebe vinni
  updateUser(): void {

    if(this.user) {
      try {
        if(this.user)
          if(this.user.id != null)
          this.userService.getUser(this.user.id)
            .subscribe(data => {
              this.oldUser = data;
          })
      } catch (error) {
        alert(error);
      }
     // console.log("userid: "+this.user.id);
        let newUser: User = {
          id: this.user.id,
          email: !!this.form.value.email ? this.form.value.email : this.oldUser.email,
          jelszo: !!this.form.value.password1 ? this.form.value.password1 : this.oldUser.jelszo,
          vnev: !!this.form.value.vnev ? this.form.value.vnev : this.oldUser.vnev,
          knev: !!this.form.value.knev ? this.form.value.knev : this.oldUser.knev,
          szul_dat: !!this.form.value.szul_dat ? this.form.value.szul_dat : this.oldUser.szul_dat,
          csatl: this.oldUser.csatl,
          munka_iskola: !!this.form.value.munka_iskola ? this.form.value.szul_dat : this.oldUser.munka_iskola,
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
              this.userService.refreshUser(id);
            }
          )
    }
  }

  public deleteUser(): void {
    if(this.user)
      if(this.user.id != null)
        this.userService.deleteUser(this.user.id)
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

