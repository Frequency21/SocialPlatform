import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ImageService } from 'src/app/services/image.service';
import { UserService } from 'src/app/services/user.service';
import { Router } from '@angular/router';
import { HttpClientService } from 'src/app/services/httpclient.service';
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
    private imageService: ImageService,
    private router: Router,
    private httpClientService: HttpClientService,
    ) { }

  ngOnInit(): void { }

  registration(): void {
    let formData = new FormData();

    formData.set('file', this.selectedFile as Blob, this.selectedFile?.name);
    this.imageService.uploadImage(formData).subscribe(
      res => {
        this.imgSrc = res;
      }
    );

  }

  onSelectFile(event: any) {
    this.selectedFile = event.target.files[event.target.files.length - 1] as File;

    try {
      this.httpClientService.createAccount(this.user)
      .subscribe((data => {

        alert("Update succesful")
      }))
    }catch(error) {
      alert(error);
    }
  }

}
