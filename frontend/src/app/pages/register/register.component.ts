import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ImageService } from 'src/app/services/image.service';
import { UserService } from 'src/app/services/user.service';
import { Router } from '@angular/router';
import { User } from 'src/app/shared/models/user.model';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  public selectedFile?: File;
  public imgSrc?: string;
  user!: User;

  form: FormGroup = new FormGroup({
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
    private imageService: ImageService,
    private router: Router,
    private userService: UserService
  ) { }

  ngOnInit(): void { }

  registration(): void {

    let newUser: User = {
      id: null,
      email: this.form.value.email,
      jelszo: this.form.value.password1,
      vnev: this.form.value.vnev,
      knev: this.form.value.knev,
      csatl: new Date(Date.now()),
      szul_dat: new Date(Date.now()),//this.form.value.szul_dat,
      munka_iskola: this.form.value.munka_iskola,
      picture: undefined,
      isAdmin: false,
    }


    let formData = new FormData();
    formData.set('file', this.selectedFile as Blob, this.selectedFile?.name);

    this.userService.createAccount(newUser)
      .subscribe(
        id => {
          console.log('get id: ' + id);
          console.log('start upload image');
          this.userService.uploadProfile(formData, id)
            .subscribe(
              path => {
                console.log('succesfully upload img to: ' + path);
              },
              console.error
            )
        },
        console.error
      )

  }

  onSelectFile(event: any) {
    this.selectedFile = event.target.files[event.target.files.length - 1] as File;
  }

}
